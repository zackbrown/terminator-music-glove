// JazzBassVoice provides a jazz bass voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class DubstepBeat2Voice extends ISampleDrivenVoice{
	
	// Our array of samples
	
	["Resources/Dubstep/Beats/DS_BeatU140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatU140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatU140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatU140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatU140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatV140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatV140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatV140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatV140-04.wav",
	"Resources/Dubstep/Beats/DS_BeatV140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatW140-01.wav",
	"Resources/Dubstep/Beats/DS_BeatW140-02.wav",
	"Resources/Dubstep/Beats/DS_BeatW140-03.wav",
	"Resources/Dubstep/Beats/DS_BeatW140-04.wav",
	"Resources/Dubstep/Percussion/DS_PercE140-01.wav",
	"Resources/Dubstep/Percussion/DS_PercE140-02.wav",
	"Resources/Dubstep/Percussion/DS_PercE140-03.wav",
	"Resources/Dubstep/Percussion/DS_PercE140-04.wav",
	"Resources/Dubstep/Percussion/DS_PercE140-05.wav",
	"Resources/Dubstep/Percussion/DS_PercEfx140-01.wav",
	"Resources/Dubstep/Percussion/DS_PercEfx140-02.wav",
	"Resources/Dubstep/Percussion/DS_PercEfx140-03.wav",
	"Resources/Dubstep/Percussion/DS_PercEfx140-04.wav",
	"Resources/Dubstep/Percussion/DS_PercEfx140-05.wav",
	"Resources/Dubstep/Beats/DS_BeatY140-05.wav"] @=> samples;
	
	init();
	
	for(0 => int i; i < buffers.size(); i++){
		buffers[i].loop(1);
	}
}