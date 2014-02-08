// PhasorVoice provides a simple synth voice using a generator
// to create the notes.  It supports only discrete notes.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class PhasorVoice extends Voice{
	///Pre-constructor:
	
	// Set note range supported by this voice
	40 => minSupportedNote;
	84 => maxSupportedNote;
	minSupportedNote => minSetNote;
	maxSupportedNote => maxSetNote;
	
	// Our generators (create many to support concurrent notes)
	Phasor gens[maxSupportedNote - minSupportedNote];
	
	
	for(0 => int i; i < gens.size(); i++){
		Phasor p;
		
		//use std's mtof to convert from MIDI number space to freqs
		Std.mtof(minSupportedNote + i) => p.freq;
		
		p @=> gens[i];
	}
	///End pre-constructor
	
	fun void playRawNote(int playThisNote, NoteEvent noteEvent){
		gens[playThisNote] @=> Phasor b;
		
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