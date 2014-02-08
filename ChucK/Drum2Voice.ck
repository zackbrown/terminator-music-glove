// Drum2Voice provides a drum kit using
// samples for each supported note.  It supports only discrete notes.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-05

public class Drum2Voice extends Voice{
	///Pre-constructor:
	
	// Our array of samples
	["Resources/Drum2/FLS Crash 01a.wav","Resources/Drum2/FLS Crash 01b.wav","Resources/Drum2/FLS Crash 02a.wav","Resources/Drum2/FLS Crash 02b.wav","Resources/Drum2/FLS Ride 02a.wav","Resources/Drum2/FLS Ride 02b.wav","Resources/Drum2/FLS_Hatcl 01.wav","Resources/Drum2/FLS_Hatcl 02.wav","Resources/Drum2/FLS_Hatop 01.wav","Resources/Drum2/FLS_Hatop 02.wav","Resources/Drum2/FLS_Hatpd 01.wav","Resources/Drum2/FLS_Hatpd 02.wav","Resources/Drum2/FLS_Kick 01.wav","Resources/Drum2/FLS_Kick 02.wav","Resources/Drum2/FLS_Ride 01a.wav","Resources/Drum2/FLS_Ride 01b.wav","Resources/Drum2/FLS_Rim 01.wav","Resources/Drum2/FLS_Rim 02.wav","Resources/Drum2/FLS_Snare 01a.wav","Resources/Drum2/FLS_Snare 01b.wav","Resources/Drum2/FLS_Snare 02a.wav","Resources/Drum2/FLS_Snare 02b.wav","Resources/Drum2/FLS_TomF 01.wav","Resources/Drum2/FLS_TomF 02.wav","Resources/Drum2/FLS_TomL 01.wav","Resources/Drum2/FLS_TomL 02.wav","Resources/Drum2/FLS_TomM 01.wav","Resources/Drum2/FLS_TomM 02.wav","Resources/Drum2/FLS_TomN 01.wav","Resources/Drum2/FLS_TomN 02.wav","Resources/Drum2/FPC_CaribShake_007.wav","Resources/Drum2/FPC_Pap_Open TriangleII.wav","Resources/Drum2/OverH_Close_002aogg.wav","Resources/Drum2/OverH_Close_002bogg.wav","Resources/Drum2/OverH_Close_002cogg.wav","Resources/Drum2/OverH_Close_002dogg.wav","Resources/Drum2/OverH_Close_002eogg.wav","Resources/Drum2/OverH_Crash_002aogg.wav","Resources/Drum2/OverH_Crash_002bogg.wav","Resources/Drum2/OverH_Crash_002cogg.wav","Resources/Drum2/OverH_Crash_003aogg.wav","Resources/Drum2/OverH_Crash_003bogg.wav","Resources/Drum2/OverH_Crash_003cogg.wav","Resources/Drum2/OverH_Kick_002aogg.wav","Resources/Drum2/OverH_Kick_002bogg.wav","Resources/Drum2/OverH_Kick_002cogg.wav"] @=> string samples[];
	
	// Create another array for our SndBufs themselves
	SndBuf buffers[samples.size()];
	
	// Set note range supported by this voice
	40 => minSupportedNote;
	84 => maxSupportedNote;
	minSupportedNote => minSetNote;
	maxSupportedNote => maxSetNote;
	
	
	for(0 => int i; i < samples.size(); i++){
		SndBuf b;
		b.read(samples[i]);
		b @=> buffers[i];
	}
	///End pre-constructor
	
	fun void playRawNote(int playThisNote, NoteEvent noteEvent){
		buffers[playThisNote] @=> SndBuf b;
		0 => b.pos;
		0 => b.gain;
		b !=> this;
		b => this;
		while(true){
			noteEvent => now;
			if(noteEvent.stopMe){
				0 => killNoteImmediately;
				killNote(me, b);
			}else{
				1 => killNoteImmediately;
				noteEvent.pressure => b.gain;
			}
		}
	}
}