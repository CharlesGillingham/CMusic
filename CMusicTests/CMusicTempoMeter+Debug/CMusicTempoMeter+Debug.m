//
//  MTempoAndMeterTest.m
//  SqueezeBox
//
//  Created by CHARLES GILLINGHAM on 6/17/14.
//  Copyright (c) 2014 CHARLES GILLINGHAM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CMusicTempoMeter+Debug.h"
#import "CDebugMessages.h"

@implementation CMusicTempoMeter (Debug)


- (NSArray *) reverseTimeSignalForTick: (MTicks) tick
{
    NSArray * ts = [self timeSignalForTime:tick timeLine:CMusic_Ticks];
    NSMutableArray * rev = [NSMutableArray arrayWithCapacity:ts.count];
    for (NSInteger i = ts.count-1; i >= 0; i--) {
        [rev addObject:ts[i]];
    }
    return rev;
}



+ (BOOL) testTempoAndMeter
{
    CMusicTempoMeter *tm = [CMusicTempoMeter new];
    NSArray * a;
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 0] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 1] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 2] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 3] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 4] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 5] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 6] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 7] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 8] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 9] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 10] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 11] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 12] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 13] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 14] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 15] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 16] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 17] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 18] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 19] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 20] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 21] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 22] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 23] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 24] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 25] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 26] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 27] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 28] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 29] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 30] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 31] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 32] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 33] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 34] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 35] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 36] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 37] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 38] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 39] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@0,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786424] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@0,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786425] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786426] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786427] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786428] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786429] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786430] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786431] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786432] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786433] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786434] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786435] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786436] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@1,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786437] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786438] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786439] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@1,@0,@2,@0]; CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: 786440] ,a)));
    CASSERT_RET([tm timeStrengthOfTime: 0 timeLine:CMusic_Ticks]-1 ==  11);
    CASSERT_RET([tm timeStrengthOfTime: 1 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 2 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 3 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 4 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 5 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 6 timeLine:CMusic_Ticks]-1 ==   2);
    CASSERT_RET([tm timeStrengthOfTime: 7 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 8 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 9 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 10 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 11 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 12 timeLine:CMusic_Ticks]-1 ==   3);
    CASSERT_RET([tm timeStrengthOfTime: 13 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 14 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 15 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 16 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 17 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 18 timeLine:CMusic_Ticks]-1 ==   2);
    CASSERT_RET([tm timeStrengthOfTime: 19 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 20 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 21 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 22 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 23 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 24 timeLine:CMusic_Ticks]-1 ==   4);
    CASSERT_RET([tm timeStrengthOfTime: 25 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 26 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 27 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 28 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 29 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 30 timeLine:CMusic_Ticks]-1 ==   2);
    CASSERT_RET([tm timeStrengthOfTime: 31 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 32 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 33 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 34 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 35 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 36 timeLine:CMusic_Ticks]-1 ==   3);
    CASSERT_RET([tm timeStrengthOfTime: 37 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 38 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 39 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 786424 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786425 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786426 timeLine:CMusic_Ticks]-1 ==   2);
    CASSERT_RET([tm timeStrengthOfTime: 786427 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786428 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786429 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 786430 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786431 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786432 timeLine:CMusic_Ticks]-1 ==   10);
    CASSERT_RET([tm timeStrengthOfTime: 786433 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786434 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786435 timeLine:CMusic_Ticks]-1 ==   1);
    CASSERT_RET([tm timeStrengthOfTime: 786436 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786437 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786438 timeLine:CMusic_Ticks]-1 ==   2);
    CASSERT_RET([tm timeStrengthOfTime: 786439 timeLine:CMusic_Ticks]-1 ==   0);
    CASSERT_RET([tm timeStrengthOfTime: 786440 timeLine:CMusic_Ticks]-1 ==   0);
    
    return YES;
}



/*
void MTempoAndMeterTestGenerator( MTempoAndMeter * tm)
{
    printf("[tm setMeterTable:@[");
    for (MBeatStrength i = 0; i < 16; i++) {
        printf("@%1hhu ", [tm meterTable][i]);
    }
    printf("]];\n");
    
    for (MTicks tick = 0; tick < 40; tick++) {
        MBeatSignalTestGenerator(tm, tick);
    }
    
    for (MTicks tick = (786424); tick <= (786430)+10; tick++) {
        MBeatSignalTestGenerator(tm, tick);
    }
    
    for (MTicks tick = 0; tick < 40; tick++) {
        MBeatStrengthTestGenerator(tm, tick);
    }
    
    for (MTicks tick = (786424); tick <= (786430)+10; tick++) {
        MBeatStrengthTestGenerator(tm, tick);
    }
}

 
void MBeatSignalTestGenerator( MTempoAndMeter *tm, MTicks tick )
{
    NSArray * bst = [tm reverseTimeSignalForTick: tick];
    
    printf("a = @[");
    for (int i = 0; i < 15; i++) printf("@%1ld,", ((NSNumber *)bst[i]).integerValue);
    printf("@%1ld]; ", (long)((NSNumber *)bst[15]).integerValue);
    printf("CASSERT_RET((CASSERTEQUAL([tm reverseTimeSignalForTick: %lld] ,a)));\n", tick);

}


void MBeatStrengthTestGenerator( MTempoAndMeter * tm, MTicks tick )
{
    MBeatStrength bs = [tm timeStrengthOfTime: tick];
    printf("CASSERT_RET([tm timeStrengthOfTime: %lld timeLine:CMusic_Ticks]-1 == %3d);\n", tick, bs);
}
*/

@end







