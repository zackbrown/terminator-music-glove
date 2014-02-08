// Drum2Voice provides a drum kit using
// samples for each supported note.  It supports only discrete notes.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-05

public class Drum1Voice extends Voice{
	///Pre-constructor:
	
	// Our array of samples
	["Resources/Drum1/OverH_Kick_002dogg.wav","Resources/Drum1/OverH_Kick_002eogg.wav","Resources/Drum1/OverH_Open_002aogg.wav","Resources/Drum1/OverH_Open_002bogg.wav","Resources/Drum1/OverH_Open_002cogg.wav","Resources/Drum1/OverH_Open_002dogg.wav","Resources/Drum1/OverH_Ped_002aogg.wav","Resources/Drum1/OverH_Ped_002bogg.wav","Resources/Drum1/OverH_Ped_002cogg.wav","Resources/Drum1/OverH_Stick_002aogg.wav","Resources/Drum1/OverH_Stick_002bogg.wav","Resources/Drum1/OverH_Stick_002cogg.wav","Resources/Drum1/OverH_Stick_002dogg.wav","Resources/Drum1/OverH_Stick_002eogg.wav","Resources/Drum1/OverHiTom_002aogg.wav","Resources/Drum1/OverHiTom_002bogg.wav","Resources/Drum1/OverHiTom_002cogg.wav","Resources/Drum1/OverHiTom_002dogg.wav","Resources/Drum1/OverHiTom_002eogg.wav","Resources/Drum1/OverLowTom_002aogg.wav","Resources/Drum1/OverLowTom_002bogg.wav","Resources/Drum1/OverLowTom_002cogg.wav","Resources/Drum1/OverLowTom_002dogg.wav","Resources/Drum1/OverLowerTom_002aogg.wav","Resources/Drum1/OverLowerTom_002bogg.wav","Resources/Drum1/OverLowerTom_002cogg.wav","Resources/Drum1/OverLowerTom_002dogg.wav","Resources/Drum1/OverMidTom_002aogg.wav","Resources/Drum1/OverMidTom_002bogg.wav","Resources/Drum1/OverMidTom_002cogg.wav","Resources/Drum1/OverMidTom_002dogg.wav","Resources/Drum1/Overhead FlamA_01.wav","Resources/Drum1/Overhead Ride2_001ogg.wav","Resources/Drum1/Overhead Ride2_002ogg.wav","Resources/Drum1/Overhead Ridebell2_001ogg.wav","Resources/Drum1/Overhead Ridebell2_002ogg.wav","Resources/Drum1/Overhead Ridebell2_003ogg.wav","Resources/Drum1/Overhead Ridebell2_004ogg.wav","Resources/Drum1/Overhead Snare B L_001ogg.wav","Resources/Drum1/Overhead Snare B L_002ogg.wav","Resources/Drum1/Overhead Snare B L_003ogg.wav","Resources/Drum1/Overhead Snare B L_004ogg.wav","Resources/Drum1/Overhead Snare B R_001ogg.wav","Resources/Drum1/Overhead Snare B R_002ogg.wav","Resources/Drum1/Overhead Snare B R_003ogg.wav","Resources/Drum1/Overhead Snare B R_004ogg.wav"] @=> string samples[];
	
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