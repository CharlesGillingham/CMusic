//
//  CMusicWesternHarmony+Debug.m
//  CMusic
//
//  Created by CHARLES GILLINGHAM on 10/7/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CMusicWesternHarmony+Debug.h"
#import "CMusicHarmony+Debug.h"
#import "CMusicHarmony+Convenience.h"
#import "CMusicHarmony+Chords.h"
#import "CMusicWesternHarmony+Description.h"
#import "CDebugMessages.h"

@implementation CMusicWesternHarmony (Debug)


+ (BOOL) testModeAndType
{
    CMusicWesternHarmony * wh = [[CMusicWesternHarmony alloc] initWithType:CMusicScaleType_Major
                                                                      mode:0
                                                                       key:CMusicPitchClass_C
                                                                 chordRoot:0];
    
    if (!CASSERTEQUAL(wh.harmonicStrengths, [CMusicHarmony CMajorI].harmonicStrengths)) return NO;
    
    wh.chordRootScaleDegree = 4; // V chord.
    
    if (!CASSERTEQUAL(wh.harmonicStrengths, [CMusicHarmony CMajorV].harmonicStrengths)) return NO;
    
    wh.key = CMusicPitchClass_A;
    wh.chordRootScaleDegree = 0; // I chord.
    
    if (!CASSERTEQUAL(wh.harmonicStrengths, [CMusicHarmony AMajorI].harmonicStrengths)) return NO;
    
    wh.scaleType = CMusicScaleType_HarmonicMinor;
    wh.key = CMusicPitchClass_G;
    wh.chordRootScaleDegree = 3; // IV chord.
    
    if (!CASSERTEQUAL(wh.harmonicStrengths, [CMusicHarmony GHarmonicMinorIV].harmonicStrengths)) return NO;
    
    wh.chordRootScaleDegree = 1; // II chord.
    wh.scaleType = CMusicScaleType_Major;
    wh.key = CMusicPitchClass_Eflat;
    wh.scaleMode = CMusicMode_Aeolian;
    
    if (!CASSERTEQUAL(wh.harmonicStrengths, [CMusicHarmony EbAeolianII].harmonicStrengths)) return NO;
    
    return YES;
}


+ (void) inspectByNumber
{
    CMusicWesternHarmony * wh1 = [CMusicWesternHarmony CMajorI];
    for (SInt16 n = 0; n < 12*7*7*4 + 12*6*1 + 12*8*2; n++) {
        wh1.number = n;
        printf("%10hd %10hd %10s %10s %10s %10s (%10s)\n",
               n, wh1.number,
               wh1.keyName.UTF8String,
               wh1.scaleTypeName.UTF8String,
               wh1.scaleModeName.UTF8String,
               [wh1 scaleDegreeName:wh1.chordRootScaleDegree].UTF8String,
               wh1.displayName.UTF8String);
    }
}



+ (BOOL) testNumber
{
    CMusicWesternHarmony * wh3, * wh2, * wh1 = [CMusicWesternHarmony CMajorI];
    
    for (NSUInteger n = 0; n < CMusicWesternHarmony_Count; n++) {
        wh1.number = n;
        
        if (!CASSERTEQUAL(n,wh1.number)) return NO;
        
        wh2 = [[CMusicWesternHarmony alloc] initWithType:wh1.scaleType
                                                    mode:wh1.scaleMode
                                                     key:wh1.key
                                               chordRoot:wh1.chordRootScaleDegree];
        
        if (!CASSERTEQUAL(n, wh2.number)) return NO;
        if (!CASSERTEQUAL(wh1.scaleType, wh2.scaleType)) return NO;
        if (!CASSERTEQUAL(wh1.scaleMode, wh2.scaleMode)) return NO;
        if (!CASSERTEQUAL(wh1.chordForm, wh2.chordForm)) return NO;
        if (!CASSERTEQUAL(wh1.harmonicStrengths, wh2.harmonicStrengths)) return NO;
        if (!CASSERTEQUAL(wh1.chordRootScaleDegree, wh2.chordRootScaleDegree)) return NO;
        
        wh3 = [CMusicWesternHarmony CMajorI];
        wh3.key = wh1.key;
        wh3.scaleType = wh1.scaleType;
        wh3.scaleMode = wh1.scaleMode;
        wh3.chordForm = wh1.chordForm;
        wh3.chordRootScaleDegree = wh1.chordRootScaleDegree;
        
        if (!CASSERTEQUAL(n, wh3.number)) return NO;
        if (!CASSERTEQUAL(wh1.harmonicStrengths, wh3.harmonicStrengths)) return NO;
        if (!CASSERTEQUAL(wh1.scaleType, wh3.scaleType)) return NO;
        if (!CASSERTEQUAL(wh1.scaleMode, wh3.scaleMode)) return NO;
        if (!CASSERTEQUAL(wh1.chordRootScaleDegree, wh3.chordRootScaleDegree)) return NO;
        if (!CASSERTEQUAL(wh1.chordForm, wh3.chordForm)) return NO;
    }
    
    return YES;
}


@end
