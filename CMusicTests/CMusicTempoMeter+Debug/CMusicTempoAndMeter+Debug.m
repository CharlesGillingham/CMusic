//
//  MTempoAndMeterTest.m
//  SqueezeBox
//
//  Created by CHARLES GILLINGHAM on 6/17/14.
//  Copyright (c) 2014 CHARLES GILLINGHAM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CMusicTempoMeter.h"
#import "CMusicTempoMeter+BackwardCompatibility.h"
#import "CDebugMessages.h"

@interface MTempoAndMeterTest : XCTestCase
@end


@implementation MTempoAndMeterTest

- (void) testTempoAndMeter
{
    CMusicTempoMeter *tm = [CMusicTempoMeter new];
    NSArray * a;
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 0] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 1] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 2] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 3] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 4] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 5] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 6] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 7] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 8] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 9] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 10] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 11] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 12] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 13] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 14] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 15] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 16] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 17] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 18] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 19] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 20] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 21] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 22] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@0,@1,@1,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 23] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 24] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 25] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 26] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 27] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 28] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@0,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 29] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 30] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 31] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 32] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 33] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 34] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@0,@1,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 35] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 36] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 37] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 38] ,a)));
    a = @[@0,@0,@0,@0,@0,@0,@1,@1,@0,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 39] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@0,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786424] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@0,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786425] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786426] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786427] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786428] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786429] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786430] ,a)));
    a = @[@511,@1,@1,@1,@1,@1,@1,@1,@1,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786431] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786432] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786433] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786434] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786435] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@1,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786436] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@0,@1,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786437] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786438] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@1,@0,@1,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786439] ,a)));
    a = @[@512,@0,@0,@0,@0,@0,@0,@0,@1,@0,@2,@0]; XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: 786440] ,a)));
    XCTAssert([tm beatStrengthOfTick: 0] ==  11);
    XCTAssert([tm beatStrengthOfTick: 1] ==   0);
    XCTAssert([tm beatStrengthOfTick: 2] ==   0);
    XCTAssert([tm beatStrengthOfTick: 3] ==   1);
    XCTAssert([tm beatStrengthOfTick: 4] ==   0);
    XCTAssert([tm beatStrengthOfTick: 5] ==   0);
    XCTAssert([tm beatStrengthOfTick: 6] ==   2);
    XCTAssert([tm beatStrengthOfTick: 7] ==   0);
    XCTAssert([tm beatStrengthOfTick: 8] ==   0);
    XCTAssert([tm beatStrengthOfTick: 9] ==   1);
    XCTAssert([tm beatStrengthOfTick: 10] ==   0);
    XCTAssert([tm beatStrengthOfTick: 11] ==   0);
    XCTAssert([tm beatStrengthOfTick: 12] ==   3);
    XCTAssert([tm beatStrengthOfTick: 13] ==   0);
    XCTAssert([tm beatStrengthOfTick: 14] ==   0);
    XCTAssert([tm beatStrengthOfTick: 15] ==   1);
    XCTAssert([tm beatStrengthOfTick: 16] ==   0);
    XCTAssert([tm beatStrengthOfTick: 17] ==   0);
    XCTAssert([tm beatStrengthOfTick: 18] ==   2);
    XCTAssert([tm beatStrengthOfTick: 19] ==   0);
    XCTAssert([tm beatStrengthOfTick: 20] ==   0);
    XCTAssert([tm beatStrengthOfTick: 21] ==   1);
    XCTAssert([tm beatStrengthOfTick: 22] ==   0);
    XCTAssert([tm beatStrengthOfTick: 23] ==   0);
    XCTAssert([tm beatStrengthOfTick: 24] ==   4);
    XCTAssert([tm beatStrengthOfTick: 25] ==   0);
    XCTAssert([tm beatStrengthOfTick: 26] ==   0);
    XCTAssert([tm beatStrengthOfTick: 27] ==   1);
    XCTAssert([tm beatStrengthOfTick: 28] ==   0);
    XCTAssert([tm beatStrengthOfTick: 29] ==   0);
    XCTAssert([tm beatStrengthOfTick: 30] ==   2);
    XCTAssert([tm beatStrengthOfTick: 31] ==   0);
    XCTAssert([tm beatStrengthOfTick: 32] ==   0);
    XCTAssert([tm beatStrengthOfTick: 33] ==   1);
    XCTAssert([tm beatStrengthOfTick: 34] ==   0);
    XCTAssert([tm beatStrengthOfTick: 35] ==   0);
    XCTAssert([tm beatStrengthOfTick: 36] ==   3);
    XCTAssert([tm beatStrengthOfTick: 37] ==   0);
    XCTAssert([tm beatStrengthOfTick: 38] ==   0);
    XCTAssert([tm beatStrengthOfTick: 39] ==   1);
    XCTAssert([tm beatStrengthOfTick: 786424] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786425] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786426] ==   2);
    XCTAssert([tm beatStrengthOfTick: 786427] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786428] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786429] ==   1);
    XCTAssert([tm beatStrengthOfTick: 786430] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786431] ==   0);
    XCTAssert((CASSERTEQUAL([tm beatStrengthOfTick: 786432],10)));
    XCTAssert([tm beatStrengthOfTick: 786433] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786434] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786435] ==   1);
    XCTAssert([tm beatStrengthOfTick: 786436] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786437] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786438] ==   2);
    XCTAssert([tm beatStrengthOfTick: 786439] ==   0);
    XCTAssert([tm beatStrengthOfTick: 786440] ==   0);
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
    NSArray * bst = [tm beatSignalOfTick: tick];
    
    printf("a = @[");
    for (int i = 0; i < 15; i++) printf("@%1ld,", ((NSNumber *)bst[i]).integerValue);
    printf("@%1ld]; ", (long)((NSNumber *)bst[15]).integerValue);
    printf("XCTAssert((CASSERTEQUAL([tm beatSignalOfTick: %lld] ,a)));\n", tick);

}


void MBeatStrengthTestGenerator( MTempoAndMeter * tm, MTicks tick )
{
    MBeatStrength bs = [tm beatStrengthOfTick: tick];
    printf("XCTAssert([tm beatStrengthOfTick: %lld] == %3d);\n", tick, bs);
}
*/

@end







