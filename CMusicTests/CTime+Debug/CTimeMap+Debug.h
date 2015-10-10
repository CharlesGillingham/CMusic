//
//  CTimeHierarchy+Debug.h
//  CMIDI
//
//  Created by CHARLES GILLINGHAM on 7/3/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CDebugMessages.h"
#import "CDebugSelfCheckingObject.h"
#import "CTimeMap.h"
#import "CTimeMap+TimeString.h"

@interface CTimeMap (Debug) <CDebugSelfCheckingObject>
+ (BOOL) test1;
+ (BOOL) test2;

// Examples
+ (CTimeMap *) tableExample;
+ (CTimeMap *) binaryExample;
+ (CTimeMap *) binaryExampleWithNames;
+ (CTimeMap *) example2323;

// Inspection tests
- (void) show;
- (void) showAllFormats;
- (void) showAllFormats: (CTimeLine) incrementTimeLine;

@end

BOOL CTimeSecondStringInspectionTest();
