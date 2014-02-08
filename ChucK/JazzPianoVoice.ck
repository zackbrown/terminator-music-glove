// PianoVoice provides a piano voice using
// samples for each supported note.  It supports only discrete notes.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class JazzPianoVoice extends ISampleDrivenVoice{
	
	1.0::second => release;
	
	//C Jazz Scale
	["Resources/Piano/060CHANGPIANOHARD_C4OGG.wav",
	"Resources/Piano/063CHANGPIANOHARD_D#4OGG.wav",
	"Resources/Piano/065CHANGPIANOHARD_F4OGG.wav",
	"Resources/Piano/066CHANGPIANOHARD_F#4OGG.wav",
	"Resources/Piano/067CHANGPIANOHARD_G4OGG.wav",
	"Resources/Piano/070CHANGPIANOHARD_A#4OGG.wav",
	"Resources/Piano/072CHANGPIANOHARD_C5OGG.wav",
	"Resources/Piano/075CHANGPIANOHARD_D#5OGG.wav",
	"Resources/Piano/077CHANGPIANOHARD_F5OGG.wav",
	"Resources/Piano/078CHANGPIANOHARD_F#5OGG.wav",
	
	//F Jazz Scale
	"Resources/Piano/065CHANGPIANOHARD_F4OGG.wav",
	"Resources/Piano/068CHANGPIANOHARD_G#4OGG.wav",
	"Resources/Piano/070CHANGPIANOHARD_A#4OGG.wav",
	"Resources/Piano/071CHANGPIANOHARD_B4OGG.wav",
	"Resources/Piano/072CHANGPIANOHARD_C5OGG.wav",
	"Resources/Piano/075CHANGPIANOHARD_D#5OGG.wav",
	"Resources/Piano/077CHANGPIANOHARD_F5OGG.wav",
	"Resources/Piano/080CHANGPIANOHARD_G#5OGG.wav",
	"Resources/Piano/082CHANGPIANOHARD_A#5OGG.wav",
	"Resources/Piano/083CHANGPIANOHARD_B5OGG.wav"] @=> samples;
	
	init();
}