// JazzBassVoice provides a jazz bass voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class DubstepSynth2Voice extends ISampleDrivenVoice{
	
	// Our array of samples
	
	["Resources/Dubstep/Synth/DS_Fizzer140C-01.wav",
	"Resources/Dubstep/Synth/DS_Fizzer140C-02.wav",
	"Resources/Dubstep/Synth/DS_Fizzer140C-03.wav",
	"Resources/Dubstep/Synth/DS_Fizzer140C-04.wav",
	"Resources/Dubstep/Synth/DS_Fizzer140C-05.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-01.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-02.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-03.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-04.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-05.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-06.wav",
	"Resources/Dubstep/Synth/DS_JenSyn140D-07.wav",
	"Resources/Dubstep/Synth/DS_PadA140D-01.wav",
	"Resources/Dubstep/Synth/DS_PadA140D-02.wav",
	"Resources/Dubstep/Synth/DS_PadA140D-03.wav",
	"Resources/Dubstep/Synth/DS_PadA140D-04.wav",
	"Resources/Dubstep/Synth/DS_PadA140D-05.wav",
	"Resources/Dubstep/Synth/DS_TerrorMin140C-01.wav",
	"Resources/Dubstep/Synth/DS_TerrorMin140C-02.wav",
	"Resources/Dubstep/Synth/DS_TerrorMin140C-03.wav",
	"Resources/Dubstep/Synth/DS_TerrorMin140C-04.wav",
	"Resources/Dubstep/Synth/DS_TerrorMin140C-05.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-03.wav"] @=> samples;
	
	init();
	
	for(0 => int i; i < buffers.size(); i++){
		buffers[i].loop(1);
	}
}