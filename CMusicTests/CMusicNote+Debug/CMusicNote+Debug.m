//
//  CMusicNote+Debug.m
//  CMusic
//
//  Created by CHARLES GILLINGHAM on 9/4/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CMusicNote+Debug.h"
#import "CDebugMessages.h"

BOOL CMusicNoteTest()
{
    id self = nil;

    // Make sure that C4 comes out as MIDI middle C = 60
    CMusicNote middleC = CMusicNote_MiddleC;
    CASSERT_RET(CMusicOctaveWithNote(middleC) == 4);
    CASSERT_RET(CMusicPitchClassWithNote(middleC) == CMusicPitchClass_C);
   
    middleC = CMusicNoteWithOctavePitchClass(4, CMusicPitchClass_C);
    CASSERT_RET(CMusicOctaveWithNote(middleC) == 4);
    CASSERT_RET(CMusicPitchClassWithNote(middleC) == CMusicPitchClass_C);
    CASSERT_RET(middleC == CMusicNote_MiddleC);
    
    // Check that all the notes are in order, and that the pitch classes and octaves are consistent
    CMusicNote prevNote = CMusicNoteWithOctavePitchClass(-3,11);
    for (CMusicOctave octave = -2;  octave <= 8; octave++) {
        for (CMusicPitchClass pc = CMusicPitchClass_Min; pc <= CMusicPitchClass_Max; pc++) {
            CMusicNote note1 = CMusicNoteWithOctavePitchClass(octave, pc);
            CASSERT_RET(CMusicPitchClassWithNote(note1) == pc);
            CASSERT_RET(CMusicOctaveWithNote(note1) == octave);
        
            // Make sure the notes are all in the right order.
            CASSERT_RET(note1 == prevNote + 1 );
            prevNote = note1;
        }
    }
    
    return YES;
}

void CMusicNoteInspectionTest()
{
    for (CMusicNote n = -24; n < 132; n++) {
        printf("%5hd %8s\n", n, CMusicNoteName(n).UTF8String);
    }
}

