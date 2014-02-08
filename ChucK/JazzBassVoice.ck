// JazzBassVoice provides a jazz bass voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class JazzBassVoice extends ISampleDrivenVoice{
	
	// Our array of samples
	
	//C Jazz Scale
	["Resources/BassGuitar/02 DEEPER PURPLE_PLUCK C1ogg.wav",
	"Resources/BassGuitar/05 DEEPER PURPLE_PLUCK D#1ogg.wav",
	"Resources/BassGuitar/07 DEEPER PURPLE_PLUCK F1ogg.wav",
	"Resources/BassGuitar/08 DEEPER PURPLE_PLUCK F#1ogg.wav",
	"Resources/BassGuitar/09 DEEPER PURPLE_PLUCK G1ogg.wav",
	"Resources/BassGuitar/12 DEEPER PURPLE_PLUCK A#1ogg.wav",
	"Resources/BassGuitar/14 DEEPER PURPLE_PLUCK C2ogg.wav",
	"Resources/BassGuitar/17 DEEPER PURPLE_PLUCK D#2ogg.wav",
	"Resources/BassGuitar/19 DEEPER PURPLE_PLUCK F2ogg.wav",
	"Resources/BassGuitar/20 DEEPER PURPLE_PLUCK F#2ogg.wav",
	
	//F Jazz Scale
	"Resources/BassGuitar/07 DEEPER PURPLE_PLUCK F1ogg.wav",
	"Resources/BassGuitar/10 DEEPER PURPLE_PLUCK G#1ogg.wav",
	"Resources/BassGuitar/12 DEEPER PURPLE_PLUCK A#1ogg.wav",
	"Resources/BassGuitar/13 DEEPER PURPLE_PLUCK B1ogg.wav",
	"Resources/BassGuitar/14 DEEPER PURPLE_PLUCK C2ogg.wav",
	"Resources/BassGuitar/17 DEEPER PURPLE_PLUCK D#2ogg.wav",
	"Resources/BassGuitar/19 DEEPER PURPLE_PLUCK F2ogg.wav",
	"Resources/BassGuitar/22 DEEPER PURPLE_PLUCK G#2ogg.wav",
	"Resources/BassGuitar/24 DEEPER PURPLE_PLUCK A#2ogg.wav",
	"Resources/BassGuitar/25 DEEPER PURPLE_PLUCK B2ogg.wav"] @=> samples;
	
	init();
}