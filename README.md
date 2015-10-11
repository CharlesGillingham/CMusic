#CMusic
Representations of common musical objects such as tempo, meter, chords, scales, notes, etc.

##Harmonic information
Representing the "vertical" information in a piece of music, such as note, chord, scale, key, etc.

###CMusicNote, CMusicPitchClass, CMusicOctave
Representation of notes, pitch classes and octaves. Every note is a unique combination of pitch class and octave (e.g. C# 4 is the first black key up from middle C). Every note is also assigned a number, which is aligned with MIDI note numbers. CMusicNote can also produce NSStrings to represent each note.

###CMusicHarmony and CMusicHarmonicStrength
A representation of harmonic information, including the current key, scale and chord.

harmony.harmonicStrengths gives the "harmonic strength" of each pitch class, where harmonic strength is defined as:
- CMusic_outOfKey
- CMusic_scaleTone
- CMusic_chordTone
- CMusic_chordRoot

For example, if the scale is C major and the chord is C major, the harmonic strengths are:
(3, 0, 1, 0, 2, 1, 0, 2, 0, 1, 0, 1)

Harmonic strengh is intended to capture the essential harmonic information. Notes with high harmonic strength are more likely to be played than notes with low harmonic strength. Notes with high harmonic strength tend to occur at moments of high "time strength" (see below) such as down beats.

###Scale degree space (CMusicHarmony+Scale.h)
Map the notes into "scale degrees". Every note has unique combination of "scale degree" and "accidental". The scale degree is incremented on each member of the scale. The accidental is the number of sharps to the note from the pitch class of the scale degree. The scale degree of the key (in octave 0) is 0.

The mapping into "scale degree space" allows us to consider structures that depend only on the scale degrees, for example a "triad" is a set of three scale degrees separated by two (e.g. [0,2,4]). The intervals of classical theory (such as 3rd, 4th, 5th) are numbered in scale degree space. These are patterns in the "white keys" of the keyboard, ignoring the black keys. 

###Scale distance
[CMusicHarmony distanceTo:<harmony>] gives a measure of the difference between two harmonies. This is related to the Hamming distance of their harmonic strengths.

###CMusicWesternHarmony and harmony.number
The space of possible harmonies is large, so CMusicWesternHarmony cuts the space down to a much smaller number. It can only represent Western harmonic structures used in common practice, jazz and pop music. 

CMusicWesternHarmony has the property "number" which gives a unique number to each Western harmonic structure.

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
- number 

All properties of CMusicHarmony and CMusicWesternHarmony 

###Names and descriptions

CMusicHarmony+Description and CMusicWesternHarmony+Description contain a full set of functions to produce strings describing harmonic objects. 

##Time
The "Horizontal" information -- the relationships between events and time. This represents the musical concepts of tempo, meter and temporal resolution.

###CTimeHierarchy
A time hierarchy describes a set of time lines, such as "seconds", "clock ticks", "beats", "bars". Each time line is counts at a fixed ratio to the preceding time line (for example, 2500000 nanoseconds per clock tick (tempo), 24 ticks per beat (resolution), 4 beats per bar (meter), etc.). The ratios are in the property "branchCounts".

A time hierarchy can easily describe non-musical time hierarchies such as SMPTE, with branch counts such as "subframes per frame", "frames per second", "seconds per minute", etc.

###CTimeMap
A set of time hierarchies, where the branch counts are changing at specific points in time. This captures the way that tempos and meters will change as a piece progresses.

###CMusicTempoMeter
A very general time map intended to describe musical structures, with the following time lines:
- CMusic_Nanos 
- CMusic_Ticks  // Clock ticks: the "resolution"; the most precise time of an event in this application. 
- CMusic_32nds
- CMusic_16ths
- CMusic_8ths
- CMusic_Beats
- CMusic_HalfBars
- CMusic_Bars
- CMusic_Section
- CMusic_Movement
- CMusic_PieceOrInterim
- CMusic_Piece

###Time strength
A measure of the "importance" of a point in time. For example: a downbeat is more "important" than upbeat thirty second note; the "backbeat" has a particular importance in pop music; and so on. The time strengths supplied by CMusicTempoMeter are these:
- CMusic_OddNanos               = 0,
- CMusic_OddTicks               = 1,
- CMusic_Upbeat32nds            = 2,
- CMusic_Upbeat16ths            = 3,
- CMusic_Upbeat8ths             = 4,
- CMusic_BackBeats              = 5,
- CMusic_MidBars                = 6,
- CMusic_OddBarDownBeats        = 7,
- CMusic_MiddleSectionDownBeats = 8,
- CMusic_LaterMovementDownBeats = 9,
- CMusic_PieceEnds              = 10,
- CMusic_PieceStarts            = 11

##Todo

