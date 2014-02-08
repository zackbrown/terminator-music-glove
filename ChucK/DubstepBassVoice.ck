// JazzBassVoice provides a jazz bass voice using
// samples for each supported note.  It is constrained to
// a C Jazz Scale (left two columns) and F jazz scale
// (right two columns)
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class DubstepBassVoice extends ISampleDrivenVoice{
	
	// Our array of samples
	
	["Resources/Dubstep/Bass/DS_BassA140D-01.wav",
	"Resources/Dubstep/Bass/DS_BassA140D-02.wav",
	"Resources/Dubstep/Bass/DS_BassA140D-03.wav",
	"Resources/Dubstep/Bass/DS_BassA140D-04.wav",
	"Resources/Dubstep/Bass/DS_BassA140D-05.wav",
	"Resources/Dubstep/Bass/DS_BassB140D-01.wav",
	"Resources/Dubstep/Bass/DS_BassB140D-02.wav",
	"Resources/Dubstep/Bass/DS_BassB140D-03.wav",
	"Resources/Dubstep/Bass/DS_BassB140D-04.wav",
	"Resources/Dubstep/Bass/DS_BassB140D-05.wav",
	"Resources/Dubstep/Bass/DS_BassJ140C-01.wav",
	"Resources/Dubstep/Bass/DS_BassJ140C-02.wav",
	"Resources/Dubstep/Bass/DS_BassJ140C-03.wav",
	"Resources/Dubstep/Bass/DS_BassJ140C-04.wav",
	"Resources/Dubstep/Bass/DS_BassJ140C-05.wav",
	"Resources/Dubstep/Bass/DS_BassK140C-01.wav",
	"Resources/Dubstep/Bass/DS_BassK140C-02.wav",
	"Resources/Dubstep/Bass/DS_BassK140C-03.wav",
	"Resources/Dubstep/Bass/DS_BassK140C-04.wav",
	"Resources/Dubstep/Bass/DS_BassK140C-05.wav",
	"Resources/Dubstep/Bass/DS_BassL140C-01.wav",
	"Resources/Dubstep/Bass/DS_BassL140C-02.wav",
	"Resources/Dubstep/Bass/DS_BassL140C-03.wav",
	"Resources/Dubstep/Bass/DS_BassL140C-04.wav",
	"Resources/Dubstep/Bass/DS_BassL140C-05.wav"] @=> samples;
	
	init();
	
	for(0 => int i; i < buffers.size(); i++){
		buffers[i].loop(1);
	}
}