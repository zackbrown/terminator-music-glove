// JazzBassVoice provides a jazz bass voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class DubstepSynth1Voice extends ISampleDrivenVoice{
	
	// Our array of samples
	
	["Resources/Dubstep/Synth/DS_BitOrgan140D-01.wav",
	"Resources/Dubstep/Synth/DS_BitOrgan140D-02.wav",
	"Resources/Dubstep/Synth/DS_BitOrgan140D-03.wav",
	"Resources/Dubstep/Synth/DS_BitOrgan140D-04.wav",
	"Resources/Dubstep/Synth/DS_BitOrgan140D-05.wav",
	"Resources/Dubstep/Synth/DS_BitOrganFX140D-01.wav",
	"Resources/Dubstep/Synth/DS_BitOrganFX140D-02.wav",
	"Resources/Dubstep/Synth/DS_BitOrganFX140D-03.wav",
	"Resources/Dubstep/Synth/DS_BitOrganFX140D-04.wav",
	"Resources/Dubstep/Synth/DS_BitOrganFX140D-05.wav",
	"Resources/Dubstep/Synth/DS_DubPi140C-01.wav",
	"Resources/Dubstep/Synth/DS_DubPi140C-02.wav",
	"Resources/Dubstep/Synth/DS_DubPi140C-03.wav",
	"Resources/Dubstep/Synth/DS_DubPi140C-04.wav",
	"Resources/Dubstep/Synth/DS_DubPi140C-05.wav",
	"Resources/Dubstep/Synth/DS_FXA140D-01.wav",
	"Resources/Dubstep/Synth/DS_FXA140D-02.wav",
	"Resources/Dubstep/Synth/DS_FXA140D-03.wav",
	"Resources/Dubstep/Synth/DS_FXA140D-04.wav",
	"Resources/Dubstep/Synth/DS_FXA140D-05.wav",
	"Resources/Dubstep/Synth/DS_FXB140D-01.wav",
	"Resources/Dubstep/Synth/DS_FXB140D-02.wav",
	"Resources/Dubstep/Synth/DS_FXB140D-03.wav",
	"Resources/Dubstep/Synth/DS_FXB140D-04.wav",
	"Resources/Dubstep/Synth/DS_FXB140D-05.wav"] @=> samples;
	
	init();
	
	for(0 => int i; i < buffers.size(); i++){
		buffers[i].loop(1);
	}
}