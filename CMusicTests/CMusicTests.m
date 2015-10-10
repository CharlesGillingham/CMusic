//
//  CMusicTests.m
//  CMusicTests
//
//  Created by CHARLES GILLINGHAM on 9/12/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "CTime+Debug.h"
#import "CTimeMap+Debug.h"
#import "CMusicTempoMeter+Debug.h"
#import "CMusicNote+Debug.h"
#import "CMusicHarmony+Debug.h"
#import "CMusicWesternHarmony+Debug.h"
#import "CDebugMessages.h"


@interface CMusicTests : XCTestCase
@end

@implementation CMusicTests
- (void) testTime1   { XCTAssert([CTimeMap test1]); }
- (void) testTime2   { XCTAssert([CTimeMap test2]); }
- (void) testTempoMeter {  XCTAssert([CMusicTempoMeter testTempoAndMeter]); }
- (void) testNotes   { XCTAssert(CMusicNoteTest()); }
- (void) testTimeMod { XCTAssert(TestCTimeModAndDiv()); }

- (void) testHarmonies
{
    XCTAssert([[CMusicHarmony CMajorI] test]);
    XCTAssert([[CMusicHarmony CMajorV] check]);
    XCTAssert([[CMusicHarmony EbAeolianII] check]);
    XCTAssert([[CMusicHarmony AMajorI] check]);
    XCTAssert([[CMusicHarmony ChromaticDMajor] check]);
    XCTAssert([[CMusicHarmony GNoteScale] check]);
    XCTAssert([[CMusicHarmony GHarmonicMinorIV] check]);
}

- (void) testHarmonySpecifics { XCTAssert([CMusicHarmony testHarmonySpecifics]); }
- (void) testKVC              { XCTAssert([CMusicHarmony testKVC]); }
- (void) testModeAndType {  XCTAssert([CMusicWesternHarmony testModeAndType]); }
- (void) testNumber      {  XCTAssert([CMusicWesternHarmony testNumber]);  }


@end


@interface CMusicInspectionTests :XCTestCase
@end

@implementation CMusicInspectionTests

// Tempo meter inspection tests.
- (void) testSecondString  { CTimeSecondStringInspectionTest(); }
- (void) testTime_Binary   { [[CTimeMap binaryExample] show]; }
- (void) testTime_3232     { [[CTimeMap example2323]   show];   }
- (void) testTime_Table    { [[CTimeMap tableExample]  show];  }
- (void) testTime_Binary_0 { [[CTimeMap binaryExample] showAllFormats:0]; }
- (void) testTime_Binary_1 { [[CTimeMap binaryExample] showAllFormats:1]; }
- (void) testTime_Binary_2 { [[CTimeMap binaryExample] showAllFormats:2]; }
- (void) testTime_Binary_3 { [[CTimeMap binaryExample] showAllFormats:3]; }
- (void) testTime_Binary_4 { [[CTimeMap binaryExample] showAllFormats:4]; }
- (void) testTime_2323_0   { [[CTimeMap example2323]   showAllFormats:0]; }
- (void) testTime_2323_1   { [[CTimeMap example2323]   showAllFormats:1]; }
- (void) testTime_2323_2   { [[CTimeMap example2323]   showAllFormats:2]; }
- (void) testTime_2323_3   { [[CTimeMap example2323]   showAllFormats:3]; }
- (void) testTime_2323_4   { [[CTimeMap example2323]   showAllFormats:4]; }

// Harmony inspection tests
- (void) testInspectNotes            { CMusicNoteInspectionTest(); }
- (void) testInspectCMajorI          { [[CMusicHarmony CMajorI] show]; }
- (void) testInspectCMajorV          { [[CMusicHarmony CMajorV] show]; }
- (void) testInspectAMajorI          { [[CMusicHarmony AMajorI] show]; }
- (void) testInspectGHarmonicMinorIV { [[CMusicHarmony GHarmonicMinorIV] show]; }
- (void) testInspectGNoteScale       { [[CMusicHarmony GNoteScale] show]; }
- (void) testInspectChromaticDMajor  { [[CMusicHarmony ChromaticDMajor] show]; }

- (void) testInspectByNumber         { [CMusicWesternHarmony inspectByNumber]; }
@end



