//
//  CTimeHierarchy+Debug.m
//  CMIDI
//
//  Created by CHARLES GILLINGHAM on 7/3/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CDebugMessages.h"
#import "CTimeMap+Debug.h"
#import "CTimeMap+TimeString.h"


@interface CTimeMap ()
@property (readwrite) NSMutableArray * _hierarchyChangeTimes; // List of CCurrentTimes
@property (readwrite) NSMutableArray * _hierarchyDuringTimePeriod;
@end


@implementation CTimeMap (Debug)

- (CTime) numberOfTimesToTest
{
    // Calculate the number of "times" we will test
    NSUInteger lastTimePeriod = self.countOfTimePeriods-1;
    
    // Do all times from zero up to the last hierarchy
    CTime nTests;
    if (lastTimePeriod == 0) {
        nTests = 0;
    } else {
        nTests = [self startOfTimePeriod:lastTimePeriod];
    }
    
    // Loop around the last hierarchy 4 times.
    CTimeHierarchy * lastHierarchy = [self hierarchyDuringTimePeriod:lastTimePeriod];
    nTests += 4 * [lastHierarchy AsPerB:0:lastHierarchy.maxTimeLine];
    
    return nTests;
}




- (BOOL) checkTimePeriodStartAndEnd
{
    // Check that the start and end times make sense (trivial in the current implementation)
    CTime tEnd = CTime_Min;
    for (NSUInteger tp = 0; tp < self.countOfTimePeriods; tp++) {
        CTime tStart = [self startOfTimePeriod:tp];
        if (!CASSERTEQUAL(tEnd, tStart)) return NO;
        tEnd = [self endOfTimePeriod:tp];
        if (!CASSERT(tStart < tEnd)) return NO;
    }
    if (!CASSERT(tEnd == CTime_Max)) return NO;
    
    return YES;
}


- (BOOL) checkListLengths
{
    // Check that we have the right number of hierarchies and change times
    // Note the change times are fence and hierarchies are fence posts.
    return CASSERT(self._hierarchyChangeTimes.count == self._hierarchyDuringTimePeriod.count-1);
}


- (BOOL) checkRelativeTime: (CTime) t0
{
    NSUInteger tp = [self timePeriodOfTime:t0 timeLine:0];
    CTimeHierarchy * th = [self hierarchyDuringTimePeriod:tp];
    
    for (NSUInteger level1 = 0; level1 < self.depth; level1++) {
        CTime t1 = [self convertTime:t0 from:0 to:level1];
        NSArray *relTimes = [self timeSignalForTime:t1 timeLine:level1];
        for (NSUInteger level = 0; level < self.depth-1; level++) {
            if (!CASSERT([relTimes[level] longLongValue] < [th AsPerB:level:level+1])) return NO;
        }
    }
    return YES;
}



- (BOOL) checkTimeStrength: (CTime) t0
{
    CTime s0 = [self timeStrengthOfTime:t0 timeLine:0];
    
    // Assumes conversions are correct.
    for (NSUInteger level = 0; level < self.depth; level++) {
        CTime t = [self convertTime:t0 from:0 to:level];
        CTime s = [self timeStrengthOfTime:t timeLine:level];
        
        NSArray * relTimes = [self timeSignalForTime:t timeLine:level];
        for (NSUInteger i = 0; i < self.depth; i++) {
            if (i < s) {
                CASSERT_RET([relTimes[i] longLongValue] == 0);
            } else {
                CASSERT_RET([relTimes[i] longLongValue] != 0);
                break;
            }
        }
        
        CASSERT_RET(s >= level);
        CASSERT_RET(s >= s0);
        /*
         printf("s0: %lld level: %lu s: %lld relative times:@[ ",s0,level,s);
         for (NSNumber * n in relTimes) {
         printf("%lld ", n.longLongValue);
         }
         printf("]\n");
         */
    }
    return YES;
}


- (BOOL) checkTimeConversion: (CTime) t0
{
    
    for (NSUInteger level1 = 0; level1 < self.depth; level1++) {
        CTime t1 = [self convertTime:t0 from:0 to:level1 ];
        for (NSUInteger level2 = 0; level2 < self.depth; level2++) {
            CTime t2 = [self  convertTime:t0 from:0 to:level2];
            for (NSUInteger level3 = 0; level3 < self.depth; level3++) {
                if (level3 >= level1 && level3 >= level2) {
                    CTime t3fromt1 = [self convertTime:t1 from:level1 to:level3 ];
                    CTime t3fromt2 = [self convertTime:t2 from:level2 to:level3 ];
                    if (!CASSERTEQUAL(t3fromt1, t3fromt2)) return NO;
                }
            }
        }
    }
    
    for (NSUInteger level1 = 0; level1 < self.depth; level1++) {
        CTime t1 = [self convertTime:t0 from:0 to:level1 ];
        NSArray * relTimes1 = [self timeSignalForTime:t1 timeLine:level1];
        
        CTime t1fromRel = [self timeOnTimeLine:level1 fromTimeSignal:relTimes1];
        if (!CASSERTEQUAL(t1fromRel, t1)) return NO;
    }
    
    return YES;
}




- (BOOL) checkRelativeTimeChanges
{
    BOOL fOK = YES;
    
    CTime nTests = [self numberOfTimesToTest];
    
    CTimeHierarchy  * th;
    NSUInteger tp;
    
    // Check 0 is 0.
    {
        NSUInteger tLevel0 = 0;
        tp = [self timePeriodOfTime:tLevel0 timeLine:0];
        th = [self hierarchyDuringTimePeriod:tp];
        
        NSArray * relTimes = [self timeSignalForTime:tLevel0 timeLine:0];
        for (CTimeLine level = 0; level < self.depth; level++) {
            CTime tt = [self convertTime:tLevel0 from:0 to:level ];
            CTime rt = [relTimes[level] longLongValue];
   
            if (!CASSERT(tt == 0)) return NO;
            if (!CASSERT(rt == 0)) return NO;
        }
   }
    
    // Set up tPrevTotalTimes for -nTests
    CASSERT_RET(self.depth < 10); // If this fails, just increment the max values in the next lines.
    CTime tPrevTotalTimes[10];
    CTime tPrevRelTimes[10];
    CTime tRelTimes[10];
    CTimeHierarchy * thPrev;
    {
        CTime tLevel0 = -10;
        tp = [self timePeriodOfTime:tLevel0 timeLine:0];
        th = [self hierarchyDuringTimePeriod:tp];
      
        NSArray * relTimes = [self timeSignalForTime:tLevel0 timeLine:0];
        for (CTimeLine level = 0; level < self.depth; level++) {
            CTime tt = [self convertTime:tLevel0 from:0 to:level ];
            CTime rt = [relTimes[level] longLongValue];
            
            tPrevTotalTimes[level] = tt;
            tPrevRelTimes[level] = rt;
        }
        
        thPrev = th;
    }
    
    
    // For each "tick" tLevel0 (the time at level 0)
    for (CTime tLevel0 = -9; tLevel0 <= nTests; tLevel0++) {
   
        tp = [self timePeriodOfTime:tLevel0 timeLine:0];
        th = [self hierarchyDuringTimePeriod:tp];
        
        BOOL nextLevelChanges = YES;
        
        NSArray * relTimes = [self timeSignalForTime:tLevel0 timeLine:0];

        for (CTimeLine level = 0; level < self.depth; level++) {
            tRelTimes[level] = [relTimes[level] longLongValue];
        }

        for (CTimeLine level = 0; level < self.depth; level++) {
            CTime tt = [self convertTime:tLevel0 from:0 to:level];
            CTime rt = [relTimes[level] longLongValue];
            
            if (nextLevelChanges) {
                if (!CASSERTEQUAL(tt, tPrevTotalTimes[level]+1)) fOK = NO;
        
                if (rt == 0) {
                    CTime r = [thPrev AsPerB:level:level+1];
                    if (!CASSERTEQUAL(r, tPrevRelTimes[level]+1)) fOK = NO;
                    nextLevelChanges = YES;
                } else {
                    if (!CASSERTEQUAL(rt, tPrevRelTimes[level]+1)) fOK = NO;
                    nextLevelChanges = NO;
                }
            } else {
                if (!CASSERTEQUAL(tt, tPrevTotalTimes[level])) fOK = NO;
                if (!CASSERTEQUAL(rt, tPrevRelTimes[level])) fOK = NO;
            }
            
            tPrevRelTimes[level] = rt;
            tPrevTotalTimes[level] = tt;
        }
  
        thPrev = th;
    }
    return fOK;
}


- (BOOL) check
{
    if (![self checkTimePeriodStartAndEnd]) return NO;
    if (![self checkListLengths]) return NO;
    
    
    CTime nTests = [self numberOfTimesToTest];
    for (NSUInteger t0 = -nTests; t0 < nTests; t0++) {
        if (![self checkRelativeTime:t0]) return NO;
        if (![self checkTimeConversion:t0]) return NO;
        if (![self checkTimeStrength:t0]) return NO;
    }
    
    if (![self checkRelativeTimeChanges]) return NO;
    
    return YES;
}



// -----------------------------------------------------------------------------
#pragma mark        Test1
// -----------------------------------------------------------------------------



- (BOOL) checkbranchCountAtLevel: (NSUInteger) levelA
                       changesTo: (CTime) AsPerB
                          atTime: (CTime) B
{

    CTime t0 = [self convertTime:B from:levelA+1 to:0];
    printf("Changing branch count at level: %lu to: %lld at time %lld (level 0: %lld)\n", levelA, AsPerB, B, t0);
    
    // Keep track of the previous branch count.
    CTime prevAsPerB = ([self branchCountAtLevel:levelA atTime:t0-1 level:0]);
    

    [self branchCountAtLevel:levelA changesTo:AsPerB atTime:B];
    
    printf(" Count of time periods = %lu\n",self.countOfTimePeriods);
        
    CASSERT_RET([self branchCountAtLevel:levelA atTime:t0 level:0] == AsPerB);
    
    // If B == 0, then previous time period
    if (B != 0) {
        // Make sure the tempo change happens at exactly the right moment
        CASSERT_RET([self branchCountAtLevel:levelA atTime:t0-1 level:0] == prevAsPerB);
    } else {
        CASSERT_RET(self.countOfTimePeriods == 1);
    }
    
    return YES;
}


- (BOOL) checkSetBranchCount: (CTime) AsPerB
                     atLevel: (NSUInteger) levelA
{
    printf("Changing branch count at level: %lu to: %lld\n", levelA, AsPerB);
    
    [self setBranchCount:AsPerB atLevel:levelA];
    
    CASSERT_RET(self.countOfTimePeriods == 1);
    
    CASSERT_RET([self branchCountAtLevel:levelA atTime:0   level:0] == AsPerB);
    CASSERT_RET([self branchCountAtLevel:levelA atTime:44  level:0] == AsPerB);
    CASSERT_RET([self branchCountAtLevel:levelA atTime:-33 level:0] == AsPerB);

    return YES;

}




+ (BOOL) test1
{
    //   CDebugInitAllPathsTest();
    BOOL fOK = YES;
    
    CTime rs[5] = {2,3,4,3,2};
    
    printf("Creating time map:\n");
    CTimeMap * tm = [CTimeMap mapWithBranchCounts:rs count:5];
    CASSERT_RET(tm.countOfTimePeriods == 1);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:0 changesTo:3 atTime:8]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 2);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:3 changesTo:2 atTime:1]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 3);
    if (!CCHECK(tm)) return NO;
    
    if (![tm checkbranchCountAtLevel:2 changesTo:2 atTime:4]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 4);
    if (!CCHECK(tm)) fOK = NO;
    
    // This make no change in the last time period (returns without modifying the map)
    if (![tm checkbranchCountAtLevel:2 changesTo:2 atTime:4]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 4);
    if (!CCHECK(tm)) fOK = NO;
    
    // Make a change in the last time period.
    if (![tm checkbranchCountAtLevel:2 changesTo:3 atTime:4]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 4);
    if (!CCHECK(tm)) fOK = NO;
    
    // This change the final time.
    CTime lastTime = [tm startOfTimePeriod:[tm countOfTimePeriods]-1];
    lastTime = [tm convertTime:lastTime from:0 to:3];
    if (![tm checkbranchCountAtLevel:2 changesTo:3 atTime:lastTime]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 4);
    if (!CCHECK(tm)) fOK = NO;
    
    printf("\n\n\n");
    
    // Step backwards erasing future
    if (![tm checkbranchCountAtLevel:1 changesTo:4 atTime:2]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 2);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:1 changesTo:3 atTime:3]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 3);
    if (!CCHECK(tm)) fOK = NO;
 
    if (![tm checkbranchCountAtLevel:1 changesTo:4 atTime:4]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 4);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:1 changesTo:3 atTime:5]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 5);
    if (!CCHECK(tm)) fOK = NO;
  
    if (![tm checkbranchCountAtLevel:1 changesTo:4 atTime:6]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 6);
    if (!CCHECK(tm)) fOK = NO;
   
    if (![tm checkbranchCountAtLevel:1 changesTo:3 atTime:7]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 7);
    if (!CCHECK(tm)) fOK = NO;
   
    if (![tm checkbranchCountAtLevel:1 changesTo:2 atTime:6]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 6);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:1 changesTo:2 atTime:5]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 5);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:1 changesTo:2 atTime:4]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 4);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:1 changesTo:2 atTime:3]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 3);
    if (!CCHECK(tm)) fOK = NO;
    
    if (![tm checkbranchCountAtLevel:1 changesTo:2 atTime:2]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 2);
    if (!CCHECK(tm)) fOK = NO;
    
    // Still 2, because we've just moved the one and only branch cound change down by 1.
    if (![tm checkbranchCountAtLevel:1 changesTo:2 atTime:1]) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 2);
    if (!CCHECK(tm)) fOK = NO;
    
    // Add 3 branch count changes
    if (![tm checkbranchCountAtLevel:1 changesTo:4 atTime:2]) fOK = NO;
    if (![tm checkbranchCountAtLevel:1 changesTo:3 atTime:3]) fOK = NO;
    if (![tm checkbranchCountAtLevel:1 changesTo:4 atTime:4]) fOK = NO;
    if (!CCHECK(tm)) fOK = NO;
    CASSERT_RET(tm.countOfTimePeriods == 5);

    if (![tm checkSetBranchCount:2 atLevel:4]) fOK = NO;
    if (!CCHECK(tm)) fOK = NO;

    if (![tm checkSetBranchCount:3 atLevel:2]) fOK = NO;
    if (!CCHECK(tm)) fOK = NO;
    
    
    return fOK;
}


// -----------------------------------------------------------------------------
#pragma mark        Test2: tableExample
// -----------------------------------------------------------------------------


#define CTimeMapDebug_TestTableSize (21)

// Table is an example

CTime CTimeMapDebug_TestTable[CTimeMapDebug_TestTableSize][4][3] = {
    {{0},{2,2},{0,0,0},{0,0,0}},
    {{0},{2,2},{0,0,1},{0,0,1}},
    
    {{1},{2,3},{0,1,0},{0,1,2}}, //  Change in while total time at level 2 stays 0.
    {{1},{2,3},{0,1,1},{0,1,3}}, //  In this region, time period of total time at level 2 is still 0.
    {{1},{2,3},{0,1,2},{0,1,4}}, //  But time period of total time at level 1 or 0 is now 1.
    
    {{1},{2,3},{1,0,0},{1,2,5}},
    {{1},{2,3},{1,0,1},{1,2,6}},
    {{1},{2,3},{1,0,2},{1,2,7}},
    
    {{1},{2,3},{1,1,0},{1,3,8}},
    {{1},{2,3},{1,1,1},{1,3,9}},
    {{1},{2,3},{1,1,2},{1,3,10}},
    
    {{2},{2,2},{2,0,0},{2,4,11}}, // Change at a higher point
    {{2},{2,2},{2,0,1},{2,4,12}},
    
    {{3},{2,3},{2,1,0},{2,5,13}}, // Change in between
    {{3},{2,3},{2,1,1},{2,5,14}},
    {{3},{2,3},{2,1,2},{2,5,15}},
    
    {{3},{2,3},{3,0,0},{3,6,16}},
    {{3},{2,3},{3,0,1},{3,6,17}},
    {{3},{2,3},{3,0,2},{3,6,18}},
    
    {{3},{2,3},{3,1,0},{3,7,19}},
    {{3},{2,3},{3,1,1},{3,7,20}}
};


+ (CTimeMap *) tableExample
{
    CTime branchCounts[2] = {2,2};
    CTimeMap * tm = [CTimeMap mapWithBranchCounts:branchCounts count:2];
    [tm branchCountAtLevel:0 changesTo:3 atTime:[tm convertTime:2 from:0 to:1 ]]; // 2
    [tm branchCountAtLevel:0 changesTo:2 atTime:[tm convertTime:11 from:0 to:1 ]]; // 11
    [tm branchCountAtLevel:0 changesTo:3 atTime:[tm convertTime:13 from:0 to:1 ]]; // 13
    return tm;
}


// Table is stored in reversed order, because I find this easier to read in a table.
// The code reads better with the fastest changing level being level "0".

#define CTimeMapDebug_TestTimePeriod(t)       CTimeMapDebug_TestTable[t][0][0]
#define CTimeMapDebug_TestBranchCount(t,i)    CTimeMapDebug_TestTable[t][1][1-(i)]
#define CTimeMapDebug_TestRelativeTime(t, i)  [NSNumber numberWithLongLong:CTimeMapDebug_TestTable[t][2][2-(i)]]
#define CTimeMapDebug_TestTotalTime(t, i)     CTimeMapDebug_TestTable[t][3][2-(i)]

- (BOOL) testTime: (CTime) t level: (NSUInteger) level againstTableRow: (NSUInteger) row
{
    NSArray * relTimes = [self timeSignalForTime:t timeLine:level];
    for (NSUInteger i = 0; i < 3; i++) {
        CTime tt = [self convertTime:t from:level to:i ];
        if (!CASSERTEQUAL(tt,          CTimeMapDebug_TestTotalTime(row,i))) return NO;
        if (!CASSERTEQUAL(relTimes[i], CTimeMapDebug_TestRelativeTime(row,i))) return NO;
    }
    return YES;
}


- (BOOL) testRelativeTimes: (NSArray *) relTimes againstTableRow: (NSUInteger) row
{
    for (NSUInteger i = 0; i < 3; i++) {
        CTime tt = [self timeOnTimeLine:i fromTimeSignal:relTimes];
        if (!CASSERTEQUAL(tt,          CTimeMapDebug_TestTotalTime(row,i))) return NO;
        if (!CASSERTEQUAL(relTimes[i], CTimeMapDebug_TestRelativeTime(row,i))) return NO;
    }
    return YES;
    
}



+ (BOOL) test2
{
    [self testCTimeRelativeTimeOrder];
    
    // Set up a time map, matching the table above.
    CTimeMap * tm = [CTimeMap tableExample];
    
    if (![tm check]) return NO;
    
    //    [tm branchCountAtLevel:0 changesTo:2 atTime:[tm timeWithTotalTime: level:0]]
    
    
    // Check the time periods from total Time
    for (CTime t = 0; t < CTimeMapDebug_TestTableSize; t++) {
        NSUInteger tp = [tm timePeriodOfTime:t timeLine:0];
        if (!CASSERTEQUAL(tp, CTimeMapDebug_TestTimePeriod(t))) return NO;
    }
    if (!CASSERTEQUAL([tm timePeriodOfTime:0 timeLine:1], 0)) return NO;
    CASSERTEQUAL([tm timePeriodOfTime:1 timeLine:1], 1);
    CASSERTEQUAL([tm timePeriodOfTime:2 timeLine:1], 1);
    CASSERTEQUAL([tm timePeriodOfTime:3 timeLine:1], 1);
    CASSERTEQUAL([tm timePeriodOfTime:4 timeLine:1], 2);
    CASSERTEQUAL([tm timePeriodOfTime:5 timeLine:1], 3);
    CASSERTEQUAL([tm timePeriodOfTime:6 timeLine:1], 3);
    CASSERTEQUAL([tm timePeriodOfTime:7 timeLine:1], 3);
    CASSERTEQUAL([tm timePeriodOfTime:8 timeLine:1], 3);
    
    CASSERTEQUAL([tm timePeriodOfTime:0 timeLine:2], 0);
    CASSERTEQUAL([tm timePeriodOfTime:1 timeLine:2], 1);
    CASSERTEQUAL([tm timePeriodOfTime:2 timeLine:2], 2);
    CASSERTEQUAL([tm timePeriodOfTime:3 timeLine:2], 3);
    CASSERTEQUAL([tm timePeriodOfTime:4 timeLine:2], 3);
    
    // Check time period from relative time
    for (CTime t = 0; t < CTimeMapDebug_TestTableSize; t++) {
        // The relative times in this table are in reverse order.
        NSArray * relTimes = @[
                               CTimeMapDebug_TestRelativeTime(t,0),
                               CTimeMapDebug_TestRelativeTime(t,1),
                               CTimeMapDebug_TestRelativeTime(t,2)];
        
        NSUInteger tp = [tm timePeriodOfTimeSignal:relTimes];
        if (!CASSERTEQUAL(tp, CTimeMapDebug_TestTimePeriod(t))) return NO;
    }
    
    // Test time hierarchy for each time period
    CTimeHierarchy * th;
    th = [tm hierarchyDuringTimePeriod:0]; CASSERT_RET([th AsPerB:0:1] == 2 && [th AsPerB:1:2] == 2);
    th = [tm hierarchyDuringTimePeriod:1]; CASSERT_RET([th AsPerB:0:1] == 3 && [th AsPerB:1:2] == 2);
    th = [tm hierarchyDuringTimePeriod:2]; CASSERT_RET([th AsPerB:0:1] == 2 && [th AsPerB:1:2] == 2);
    th = [tm hierarchyDuringTimePeriod:3]; CASSERT_RET([th AsPerB:0:1] == 3 && [th AsPerB:1:2] == 2);
    
    // Test "timeWithTotalTime"
    for (CTime t = 0; t < CTimeMapDebug_TestTableSize; t++) {
        if (![tm testTime:t level:0 againstTableRow: t]) return NO;
    }
    [tm testTime:0 level:1 againstTableRow:0];
    [tm testTime:1 level:1 againstTableRow:2];
    [tm testTime:2 level:1 againstTableRow:5];
    [tm testTime:3 level:1 againstTableRow:8];
    [tm testTime:4 level:1 againstTableRow:11];
    [tm testTime:5 level:1 againstTableRow:13];
    [tm testTime:6 level:1 againstTableRow:16];
    [tm testTime:7 level:1 againstTableRow:19];
    
    [tm testTime:0 level:2 againstTableRow:0];
    [tm testTime:1 level:2 againstTableRow:5];
    [tm testTime:2 level:2 againstTableRow:11];
    [tm testTime:3 level:2 againstTableRow:16];
    
    // Test "timeWithRelativeTime"
    for (CTime t = 0; t < CTimeMapDebug_TestTableSize; t++) {
        
        // The relative times in this table are in reverse order.
        NSArray * relTimes = @[
                               CTimeMapDebug_TestRelativeTime(t,0),
                               CTimeMapDebug_TestRelativeTime(t,1),
                               CTimeMapDebug_TestRelativeTime(t,2)];
        
        if (![tm testRelativeTimes:relTimes againstTableRow:t]) return NO;
    }
    
    return YES;
}


// Use the "time table" above to check that this utility function works as designed.

NSComparisonResult CTimeRelativeTimeOrder(NSArray * r1,
                                          NSArray * r2);


+ (BOOL) testCTimeRelativeTimeOrder
{
    for (NSUInteger i = 0; i < CTimeMapDebug_TestTableSize; i++) {
        NSArray * relTimes1 = @[
                                CTimeMapDebug_TestRelativeTime(i,0),
                                CTimeMapDebug_TestRelativeTime(i,1),
                                CTimeMapDebug_TestRelativeTime(i,2)];
        
        for (NSUInteger j = 0; j < CTimeMapDebug_TestTableSize; j++) {
            NSArray * relTimes2 = @[
                                    CTimeMapDebug_TestRelativeTime(j,0),
                                    CTimeMapDebug_TestRelativeTime(j,1),
                                    CTimeMapDebug_TestRelativeTime(j,2)
                                    ];
            
            NSComparisonResult cr = CTimeRelativeTimeOrder(relTimes1, relTimes2);
            switch (cr) {
                case NSOrderedAscending:  { if (!CASSERT(i < j))     return NO; break; }
                case NSOrderedDescending: { if (!CASSERT(i > j))     return NO; break; }
                case NSOrderedSame:       { if (!CASSERTEQUAL(i, j)) return NO; break; }
            }
        }
    }
    return YES;
    
}



// -----------------------------------------------------------------------------
#pragma mark        Inspection Test (Show)
// -----------------------------------------------------------------------------
// This test doesn't use the description code...

#define CMapValueWidth (5)

- (void) printShowHeader
{
    int periodWidth      = (int) strlen("Period");
    int branchCountWidth = (int) ((self.depth-1)*(CMapValueWidth+1)-1);
    int totalTimeWidth   = (int) (self.depth*(CMapValueWidth+1)-1);
    int timeSignalWidth  = (int) (self.depth*(CMapValueWidth+1)-1);
    
    printf("%*s | %*s | %*s | %*s | %s\n",
           periodWidth, "Period",
           branchCountWidth, "Branch counts",
           totalTimeWidth, "Total time",
           timeSignalWidth, "Time signal",
           "Strength");
}


- (void) printTime: (CTime) t0
{
    int periodWidth      = (int) strlen("Period");
    int branchCountWidth = (int) ((self.depth-1)*(CMapValueWidth+1)-1);
    int totalTimeWidth   = (int) (self.depth*(CMapValueWidth+1)-1);
    int timeSignalWidth  = (int) (self.depth*(CMapValueWidth+1)-1);
    
    int bcPad = (strlen("Branch counts")) - branchCountWidth;
    if (bcPad < 0) bcPad = 0;
    int ttPad = (strlen("Total time")) - totalTimeWidth;
    if (ttPad < 0) ttPad = 0;
    int tsPad = (strlen("Time signal")) - timeSignalWidth;
    if (tsPad < 0) tsPad = 0;

    NSUInteger tp = [self timePeriodOfTime:t0 timeLine:0];
    CTimeHierarchy * th = [self hierarchyDuringTimePeriod:tp];
    
    printf("%*d | ", periodWidth, (int)tp);
    
    printf("%*s", bcPad, "");
    for (NSInteger i = self.depth-2; i >= 0; i--) {
        printf("%*lld ", CMapValueWidth, [th AsPerB:i:i+1]);
    }
    printf("| ");
    
    printf("%*s", ttPad, "");
    for (NSInteger level = self.depth-1; level >= 0; level--) {
        CTime t = [self convertTime:t0 from:0 to:level ];
        printf("%*lld ", CMapValueWidth, t);
    }
    printf("| ");
    
    printf("%*s", tsPad, "");
    NSArray * relTimes = [self timeSignalForTime:t0 timeLine:0];
    for (NSInteger level = self.depth-1; level >= 0; level--) {
        CTime t = [relTimes[level] longLongValue];
        printf("%*lld ", CMapValueWidth, t);
    }
    printf("| ");
    
    printf("%lu", [self timeStrengthOfTime:t0 timeLine:0]);
    printf("\n");
}


- (void) show
{
    CTime nTests = [self numberOfTimesToTest];
    CDebugInspectionTestHeader("CTimeMap inspection test",
                               (char *)[NSString stringWithFormat:@" Number of tests: %lld",
                                        nTests].UTF8String);
    [self printShowHeader];
    
    NSUInteger tp = 0;
    CTime nextEnd = [self endOfTimePeriod:tp];
    for (CTime t0 = -nTests; t0 < nTests; t0++) {
        if (t0 == nextEnd) {
            printf("----------------------------------------------------------");
            printf("----------------------------------------------------------\n");
            nextEnd = [self endOfTimePeriod:++tp];
        }
        [self printTime:t0];
    }
    CDebugInspectionTestFooter();
}


// -----------------------------------------------------------------------------
#pragma mark        Description Inspection Test (ShowAllFormats)
// -----------------------------------------------------------------------------

- (void) printAllFormatsHeader
{
    for (CTimeStringFormat tl = 0; tl < self.timeStringFormatsCount; tl++) {
        self.timeStringFormat = tl;
        printf("|%*s", self.timeStringMaxLength, self.timeStringHeader.UTF8String);
    }
    printf("\n");
}



- (void) printAllFormats: (SInt64) time : (NSUInteger) timeLine
{
    CTime nanos = [self convertTime:time from:timeLine to:0];
    for (CTimeStringFormat tl = 0; tl < self.timeStringFormatsCount; tl++) {
        self.timeStringFormat = tl;
        printf("|%*s", self.timeStringMaxLength,
               [self timeString:nanos timeLine:0].UTF8String);
    }
    printf("\n");
}


- (void) showAllFormats: (NSUInteger) incrementTimeLine
{
    NSString * title = [NSString stringWithFormat:@"CMIDICurrentTime inspection test increment on each %s",
                        [self.timeLineNames[incrementTimeLine] UTF8String]];
    CDebugInspectionTestHeader((char *)title.UTF8String, "Check that the time formats all make sense.");
    
    SInt64 nTests = 24 * 8;
    
    [self printAllFormatsHeader];
    for (NSInteger i = -24; i <= nTests; i++) {
        [self printAllFormats:i:incrementTimeLine];
    }
    
    CDebugInspectionTestFooter();
}


- (void) showAllFormats
{
    return [self showAllFormats:0];
}

// -----------------------------------------------------------------------------
#pragma mark        Examples
// -----------------------------------------------------------------------------
// Also "tableExample" above

+ (CTimeMap *) binaryExample
{
    CTime buf[4] = {2,2,2,2};
    CTimeMap * tm = [CTimeMap mapWithBranchCounts:buf count:4];
    return tm;
}


+ (CTimeMap *) binaryExampleWithNames
{
    CTimeMap * tm = [self binaryExample];
    tm.timeLineNames = @[@"A long first one",@"B",@"C+++",@"D",@"E"];
    return tm;
}


- (void) toggleBranchCountsIn2323
{
    CTime levels[self.depth];
    CTime levelsNext[self.depth];
    for (NSUInteger level = 1; level < self.depth; level++) {
        levels[level] = 0;
        levelsNext[level] = 3;
    }
    for (CTime t0 = 0; t0 < 50; t0++) {
        for (NSUInteger level = 1; level < self.depth; level++) {
            CTime tLevel = [self convertTime:t0 from:0 to:level];
            if (tLevel > levels[level]) {
                [self branchCountAtLevel:level-1 changesTo:levelsNext[level] atTime:tLevel];
                levels[level] = tLevel;
                levelsNext[level] = (levelsNext[level] == 3 ? 2 : 3);
            }
        }
    }
}


+ (CTimeMap *) example2323
{
    CTime buf[4] = {2,2,2,2};
    CTimeMap * tm = [CTimeMap mapWithBranchCounts:buf count:4];
    [tm toggleBranchCountsIn2323];
    return tm;
}


+ (CTimeMap *) example2323:(CTimeStringFormat)format
{
    CTimeMap * tm = [self example2323];
    tm.timeStringFormat = format;
    return tm;
}


@end




BOOL CTimeSecondStringInspectionTest()
{
    CTime t[20] = {
        1987654321987654321,
        987654321987654321,
        87654321987654321,
        7654321987654321,
        654321987654321,
        54321987654321,
        4321987654321,
        321987654321,
        21987654321,
        1987654321,
        987654321,
        87654321,
        7654321,
        654321,
        54321,
        4321,
        321,
        21,
        1,
        0};
    
    printf("%-21s %-21s %-s\n", "CMIDINanoseconds", "CMIDISecondString", "Floating point (the display loses precision; using the integer string gives the correct number).");
    for (int i = 0; i < 20; i++) {
        char floatString[100];
        sprintf(floatString, "%10.10f", ((Float64)t[i])/1000000000);
        printf("%21llu %21s %22s\n", t[i], CTimeSecondString(t[i]).UTF8String, floatString);
    }
    return YES;
}

