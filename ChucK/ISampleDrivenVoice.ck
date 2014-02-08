// ISampleDrivenVoice provides an interface for voices using samples
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class ISampleDrivenVoice extends Voice{
	///Pre-constructor:
	
	// Our array of samples
	string samples[];
	SndBuf buffers[];
	
	fun void init(){
		// Create another array for our SndBufs themselves
		new SndBuf[samples.size()] @=> buffers;
		
		for(0 => int i; i < samples.size(); i++){
			SndBuf b;
			b.read(samples[i]);
			b @=> buffers[i];
		}
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
				noteEvent.pressure + getAveragePressure() / 2.0 => b.gain;
			}
		}
	}
}