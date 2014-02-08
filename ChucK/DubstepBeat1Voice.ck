// JazzBassVoice provides a jazz bass voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class DubstepBeat1Voice extends ISampleDrivenVoice{
	
	// Our array of samples
	
	["Resources/Dubstep/Beats/DS_BeatA140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatA140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatB140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatB140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatB140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatB140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatB140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatC140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatC140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatC140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatC140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatC140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatD140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatD140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatD140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatD140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatD140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatE140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatE140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatE140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatE140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatE140-05.wav"] @=> samples;
	
	init();
	
	for(0 => int i; i < buffers.size(); i++){
		buffers[i].loop(1);
	}
}