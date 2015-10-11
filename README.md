#CMusic
Representations of common musical objects such as tempo, meter, chords, scales, notes, etc.

##Harmonic information
Vertical information -- the relationships between notes.

###CMusicNote, CMusicPitchClass, CMusicOctave
Representation of notes, pitch classes and octaves. Every note is a unique combination of pitch class and octave (e.g. C# 4 is the first black key up from middle C). Every note is also assigned a number, which is aligned with MIDI note numbers. CMusicNote can also produce NSStrings to represent each note.

###CMusicHarmony and CMusicHarmonicStrength
A representation of harmonic information, including the current key, scale and chord. CMusicHarmony is KVC compliant.

harmony.harmonicStrengths gives the "harmonic strength" of each pitch class, where harmonic strength is defined as:
enum {
    CMusic_outOfKey  = 0,
    CMusic_scaleTone = 1,
    CMusic_chordTone = 2,
    CMusic_chordRoot = 3
};
For example, if the scale is C major and the chord is C major, the harmonic strengths are:
[3, 0, 1, 0, 2, 1, 0, 2, 0, 1, 0, 1]

Harmonic strengh is intended to capture the essential harmonic information. Notes with high harmonic strength are more likely to be played than notes with low harmonic strength. Notes with high harmonic strength tend to occur at moments of high "time strength" (see below) such as down beats.

###ScaleDegree / ScaleDegree space (CMusicHarmony+Scale.h)
Map the notes into "scale degrees". Every note has unique combination of "scale degree" and "accidental". The scale degree is incremented on each member of the scale. The accidental is the number of sharps to the note from the pitch class of the scale degree. The scale degree of the key (in octave 0) is 0.

###Other harmonic properties
CMusicHarmony also has these convenience properties:
- scale tones count (the number of notes in the scale)
- chord member count (the number of notes in the chord)
- key
- scale form (an array giving the pitch classes of the scale relative to the key)
- chord root scale degree
- chord root pitch class
- chord form (an array giving the pitch classes of the scale relative to the chord root pitch class)

CMusicWesternHarmony has these convenience properties:
- scale type 
- scale mode

###Names and description

##CMusicTempoMeter
CMusicTempoMeter represents the 

##Usage
##Todo

