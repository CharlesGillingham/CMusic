//
//  CMusicHarmony+Debug.m
//  CMusic
//
//  Created by CHARLES GILLINGHAM on 10/4/15.
//  Copyright (c) 2015 CharlesGillingham. All rights reserved.
//

#import "CMusicHarmony+Debug.h"
#import "CMusicHarmony+Convenience.h"
#import "CMusicHarmony+Scales.h"
#import "CMusicHarmony+Chords.h"
#import "CMusicHarmony+Description.h"
#import "CDebugMessages.h"
#import "CKVCTester.h"

@interface CMusicHarmony ()
- (BOOL) checkParameters;
@end

@implementation CMusicHarmony (Debug)

- (BOOL) checkNote: (CMusicNote) n
{
    CMusicPitchClass       pc = CMusicPitchClassWithNote(n);
    
    BOOL                  isS = [self noteIsMemberOfScale:n];
    BOOL                  isC = [self noteIsMemberOfChord:n];
    BOOL                  isR = [self noteIsChordRoot:n];
    CMusicHarmonicStrength hs = [self harmonicStrengthOfNote:n];
    CMusicScaleDegree      sd = [self scaleDegreeFromNote:n];
    CMusicAccidental       ac = [self accidentalFromNote:n];
    CMusicScaleDegree    pcsd = [self scaleDegreeFromPitchClass:pc];
    
    CASSERT_RET([self pitchClassIsMemberOfScale:pc] == isS);
    CASSERT_RET([self pitchClassIsMemberOfChord:pc] == isC);
    CASSERT_RET([self pitchClassIsChordRoot:pc] == isR);
    
    CASSERT_RET([self harmonicStrength:pc] == hs);
    CASSERT_RET(pcsd == SInt16Mod(sd,[self scaleTonesCount]));
    CASSERT_RET(SInt16Mod([self pitchClassFromScaleDegree:sd] + ac,12) == pc);
    CASSERT_RET([self noteFromScaleDegree:sd] + ac == n);

    return YES;
}



- (BOOL) check
{
    if (![self checkParameters]) return NO;
    
    for (CMusicOctave o = -2; o <= 7; o++) {
        for (CMusicPitchClass pc = 0; pc <=  CMusicPitchClass_Max; pc++) {
            CMusicNote n = CMusicNoteWithOctavePitchClass(o, pc);
            CASSERT_RET(CMusicOctaveWithNote(n) == o);
            CASSERT_RET(CMusicPitchClassWithNote(n) == pc);
            
            if (![self checkNote:n]) return NO;
        }
    }
    return YES;
}


- (void) show
{
    printf("Harmonic strengths (from list):\n");
    for (NSNumber * n in self.harmonicStrengths) {
        printf("%s ", n.description.UTF8String);
    }
    printf("\n\n");
    
    printf("Key\n");
    printf("%d %s\n\n",self.key, self.keyName.UTF8String);

    printf("Chord root\n");
    printf("Scale degree | Scale Degree name | Pitch class | Pitch class name\n");
    printf("%*d | %*s | %*d | %*s\n\n",
           (int)strlen("Scale degree"),
           self.chordRootScaleDegree,
           (int)strlen("Scale degree name"),
           self.chordRootScaleDegreeName.UTF8String,
           (int)strlen("Pitch class"),
           self.chordRootPitchClass,
           (int)strlen("Pitch class name"),
           self.chordRootPitchClassName.UTF8String);
    
    printf("Chord form:\n");
    printf("%s ", self.chordFormName.UTF8String);
    printf("[ ");
    for (NSNumber * n in self.chordForm) {
        printf("%s ", n.description.UTF8String);
    }
    printf("]");
    printf("[ ");
    for (NSNumber * sd in self.chordForm) {
        printf("%s ", [self scaleDegreePitchClassName:(SInt16)sd.integerValue + self.chordRootScaleDegree].UTF8String);
    }
    printf("]");

    
    printf("\n\n");
    
    for (CMusicNote n = -12; n < 24; n++) {
        
        CMusicHarmonicStrength hs = [self harmonicStrengthOfNote:n];
        CMusicScaleDegree      sd = [self scaleDegreeFromNote:n];
        CMusicAccidental       ac = [self accidentalFromNote:n];
        BOOL                  isS = [self noteIsMemberOfScale:n];
        BOOL                  isC = [self noteIsMemberOfChord:n];
        BOOL                  isR = [self noteIsChordRoot:n];

        CMusicPitchClass       pc = CMusicPitchClassWithNote(n);
        CMusicScaleDegree    pcsd = [self scaleDegreeFromPitchClass:pc];
        
        if (n == -12) {
            printf("%5s |%8s |%5s |%5s |%5s |%6s |%6s |%6s |%22s |%22s |%5s\n",
                   "Note", "", "PC", "", "HS",
                   "Scale","Chord", "Root",
                   "s.d. of p.c.","s.d. of note", "accid.");
           
        }
        printf("%5d |%8s |%5d |%5s |%5d",
               n,  [self noteName:n].UTF8String,
               pc, [self pitchClassName:pc].UTF8String,
               hs);
        printf(" |%6s |%6s |%6s",
               (isS ? "YES" : "---"),
               (isC ? "YES" : "---"),
               (isR ? "YES" : "---"));
        printf(" |%6d  %6s  %6s |%6d  %6s  %6s",
               sd,   [self scaleDegreeName:sd].UTF8String,   [self noteName:[self noteFromScaleDegree:sd]].UTF8String,
               pcsd, [self scaleDegreeName:pcsd].UTF8String, [self scaleDegreePitchClassName:pcsd].UTF8String);
        printf(" |%5d |%s%s",ac,
               [self scaleDegreePitchClassName:pcsd].UTF8String,
               (ac == 0 ? "" : (ac == 1 ? "#" : (ac == 2 ? "##" : "+"))));
        printf("\n");
        
        if (![self checkNote:n]) return;
    }
}


- (BOOL) test
{
    if (![self check]) return NO;
    
    // No need to check setting chord root pitch class, as this just a simple 
    for (CMusicScaleDegree sd = 0; sd < self.scaleTonesCount; sd++) {
        self.chordRootScaleDegree = sd;
        if (![self check]) return NO;
        if (!CASSERT(self.chordRootScaleDegree == sd)) return NO;
    }
    
    for (CMusicPitchClass pc = 0; pc < CMusicPitchClass_Count; pc++) {
        self.key = pc;
        if (![self check]) return NO;
        if (!CASSERT(self.key == pc)) return NO;
    }

    
    return YES;
}



+ (CMusicHarmony *) CMajorV
{
    return [[self alloc] initWithHarmonicStrengths:@[@1,@0,@2,@0, @1,@1,@0,@3, @0,@1,@0,@2]
                                               key:CMusicPitchClass_C];
}


+ (CMusicHarmony *) AMajorI
{
    return [[self alloc] initWithHarmonicStrengths:@[@0,@2,@1,@0,@2, @0,@1,@0,@1,@3,@0,@1]
                                               key:CMusicPitchClass_A];
}


+ (CMusicHarmony *) EbAeolianII
{
    return [[self alloc] initWithHarmonicStrengths:@[@0,@1,@0,@1,@0,@3,@1,@0,@2,@0,@1,@2]
                                               key:CMusicPitchClass_Eflat];
}


+ (CMusicHarmony *) GHarmonicMinorIV
{
    return [[self alloc] initWithHarmonicStrengths:@[@3,@0,@1,@2,@0,@0,@1,@2,@0,@1,@1,@0]
                                               key:CMusicPitchClass_G];
}


+ (CMusicHarmony *) GNoteScale
{
    return [[self alloc] initWithHarmonicStrengths:@[@0,@0,@0,@0,@0,@0,@0,@3,@0,@0,@0,@0]
                                               key:CMusicPitchClass_G];
}


+ (CMusicHarmony *) ChromaticDMajor
{
    return [[self alloc] initWithHarmonicStrengths:@[@1,@1,@3,@1,@1,@1,@2,@1,@1,@2,@1,@1]
                                               key:CMusicPitchClass_G];
 
}



+ (BOOL)testHarmonySpecifics
{
    CMusicHarmony * h = [self CMajorI];
 
    if (![h check]) return NO;
    
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_C]      == 0);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Csharp] == 0);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_D]      == 1);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Eflat]  == 1);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_E]      == 2);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_F]      == 3);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Fsharp] == 3);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_G]      == 4);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Aflat]  == 4);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_A]      == 5);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Bflat]  == 5);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_B]      == 6);
    
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_C]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Csharp] == 1);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_D]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Eflat]  == 1);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_E]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_F]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Fsharp] == 1);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_G]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Aflat]  == 1);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_A]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Bflat]  == 1);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_B]      == 0);

    
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_C]        == YES);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Csharp]   == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_D]        == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Eflat]    == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_E]        == YES);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_F]        == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Fsharp]   == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_G]        == YES);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Aflat]    == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_A]        == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Bflat]    == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_B]        == NO);
    
    CASSERT_RET([h.keyName isEqualTo:@"C"]);
    
    h = [self EbAeolianII];
    
    if (![h check]) return NO;
    
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_C]      == 5);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Csharp] == 6);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_D]      == 6);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Eflat]  == 0);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_E]      == 0);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_F]      == 1);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Fsharp] == 2);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_G]      == 2);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Aflat]  == 3);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_A]      == 3);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_Bflat]  == 4);
    CASSERT_RET([h scaleDegreeFromPitchClass: CMusicPitchClass_B]      == 5);
    
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_C]      == 1 );
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Csharp] == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_D]      == 1 );
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Eflat]  == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_E]      == 1 );
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_F]      == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Fsharp] == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_G]      == 1 );
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Aflat]  == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_A]      == 1 );
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_Bflat]  == 0);
    CASSERT_RET([h accidentalFromNote: CMusicPitchClass_B]      == 0);
    
    
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_C]      == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Csharp] == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_D]      == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Eflat]  == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_E]      == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_F]      == YES);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Fsharp] == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_G]      == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Aflat]  == YES);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_A]      == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_Bflat]  == NO);
    CASSERT_RET([h noteIsMemberOfChord: CMusicNote_MiddleC + CMusicPitchClass_B]      == YES);
    
    return YES;
}

+ (NSArray *) allKeysAffectedByHarmonicStrengths
{
    return @[@"harmonicStrengths",
             @"KVCHarmonicStrengths",
             @"chordForm",
             @"chordMemberCount",
             @"chordRootScaleDegree",
             @"chordRootPitchClass",
      
             @"description",
      
             @"pitchClassNames",
             @"scaleDegreeNames",
             @"scaleDegreePitchClassNames",
             @"chordFormNames",
      
             @"keyName",
             @"chordFormName",
             @"chordRootScaleDegreeName",
             @"chordRootPitchClassName"
             ];
}


+ (BOOL) testKVC
{
    CMusicHarmony * h = [CMusicHarmony CMajorI];
    
    NSArray * hsKeys = [self allKeysAffectedByHarmonicStrengths];
    
    CKVCTester * kvcT = [CKVCTester testerWithObject:h expectedKeys:hsKeys];
    
    if (![kvcT testWhenNotModified]) return NO;
    
    h.key = 2;
    
    if (![kvcT testCount:1]) return NO;
    if (![kvcT testWhenNotModified]) return NO;
    
    h.chordRootScaleDegree = 2;
    
    if (![kvcT testCount:1]) return NO;
    if (![kvcT testWhenNotModified]) return NO;
    
    return YES;
}

@end
