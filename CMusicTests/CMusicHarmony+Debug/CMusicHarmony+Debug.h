//
//  CMusicHarmony+Debug.h
//  CMusic
//
//  Created by CHARLES GILLINGHAM on 10/4/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CMusicHarmony.h"

@interface CMusicHarmony (Debug)

// Examples
+ (CMusicHarmony *) CMajorV;
+ (CMusicHarmony *) AMajorI;
+ (CMusicHarmony *) EbAeolianII;
+ (CMusicHarmony *) GHarmonicMinorIV;
+ (CMusicHarmony *) GNoteScale;
+ (CMusicHarmony *) ChromaticDMajor;

- (void) show;
- (BOOL) check;
- (BOOL) test;

+ (BOOL) testHarmonySpecifics;
+ (BOOL) testKVC;

@end
