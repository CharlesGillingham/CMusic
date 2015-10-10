//
//  CTime+Debug.m
//  CMIDIClockTest
//
//  Created by CHARLES GILLINGHAM on 9/18/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CTime+Debug.h"
#import "CDebugMessages.h"

BOOL TestCTimeModAndDiv()
{
    for (CTime m = 1; m < 20; m++) {
        
        CTime i,j,k;
        i = -1000;
        k = CTimeDiv(i,m);
        j = CTimeMod(i,m);
        while (i <= 40) {
            j++;
            if (j == m) {
                k++;
                j=0;
            }
            i++;
            if (!CASSERT_IN_C((CTimeMod(i,m) == j))) return NO;
            if (!CASSERT_IN_C((CTimeDiv(i,m) == k))) return NO;
        }
        if (!CASSERT_IN_C((CTimeMod(0,m) == 0))) return NO;
        if (!CASSERT_IN_C((CTimeDiv(0,m) == 0))) return NO;
    }
    return YES;
}
