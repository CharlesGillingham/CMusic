//
//  CMusic.h
//  CMusic
//
//  Created by CHARLES GILLINGHAM on 10/9/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for CMusic.
FOUNDATION_EXPORT double CMusicVersionNumber;

//! Project version string for CMusic.
FOUNDATION_EXPORT const unsigned char CMusicVersionString[];

// Harmony
#import <CMusic/CMusicNote.h>
#import <CMusic/CMusicHarmony.h>
#import <CMusic/CMusicHarmony+Scales.h>
#import <CMusic/CMusicHarmony+Chords.h>
#import <CMusic/CMusicHarmony+Convenience.h>
#import <CMusic/CMusicWesternHarmony.h>

// Time
#import <CMusic/CTime.h>
#import <CMusic/CTimeHierarchy.h>
#import <CMusic/CTimeMap.h>
#import <CMusic/CMusicTempoMeter.h>

// Descriptions & strings
#import <CMusic/CTimeMap+TimeString.h>
#import <CMusic/CMusicHarmony+Description.h>
#import <CMusic/CMusicWesternHarmony+Description.h>

// User interface
#import <CMusic/CMusicWesternHarmony+UI.h>
