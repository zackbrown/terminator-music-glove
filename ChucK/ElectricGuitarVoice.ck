// ElectricGuitarVoice provides an electric guitar voice using
// samples for each supported note.  It supports only discrete notes.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class ElectricGuitarVoice extends Voice{
	///Pre-constructor:
	
	// Our array of samples
	["Resources/Guitar/01 DARK STAR METAL_E2OGG.wav","Resources/Guitar/02 DARK STAR METAL_F2OGG.wav","Resources/Guitar/03 DARK STAR METAL_F#2OGG.wav","Resources/Guitar/04 DARK STAR METAL_G2OGG.wav","Resources/Guitar/05 DARK STAR METAL_G#2OGG.wav","Resources/Guitar/06 DARK STAR METAL_A2OGG.wav","Resources/Guitar/07 DARK STAR METAL_A#2OGG.wav","Resources/Guitar/08 DARK STAR METAL_B2OGG.wav","Resources/Guitar/09 DARK STAR METAL_C3OGG.wav","Resources/Guitar/10 DARK STAR METAL_C#3OGG.wav","Resources/Guitar/11 DARK STAR METAL_D3OGG.wav","Resources/Guitar/12 DARK STAR METAL_D#3OGG.wav","Resources/Guitar/13 DARK STAR METAL_E3OGG.wav","Resources/Guitar/14 DARK STAR METAL_F3OGG.wav","Resources/Guitar/15 DARK STAR METAL_F#3OGG.wav","Resources/Guitar/16 DARK STAR METAL_G3OGG.wav","Resources/Guitar/17 DARK STAR METAL_G#3OGG.wav","Resources/Guitar/18 DARK STAR METAL_A3OGG.wav","Resources/Guitar/18 DARK STAR METAL_A#3OGG.wav","Resources/Guitar/19 DARK STAR METAL_B3OGG.wav","Resources/Guitar/20 DARK STAR METAL_C4OGG.wav","Resources/Guitar/21 DARK STAR METAL_C#4OGG.wav","Resources/Guitar/22 DARK STAR METAL_D4OGG.wav","Resources/Guitar/23 DARK STAR METAL_D#4OGG.wav","Resources/Guitar/24 DARK STAR METAL_E4OGG.wav","Resources/Guitar/24 DARK STAR METAL_F4OGG.wav","Resources/Guitar/25 DARK STAR METAL_F#4OGG.wav","Resources/Guitar/26 DARK STAR METAL_G4OGG.wav","Resources/Guitar/27 DARK STAR METAL_G#4OGG.wav","Resources/Guitar/28 DARK STAR METAL_A4OGG.wav","Resources/Guitar/29 DARK STAR METAL_A#4OGG.wav","Resources/Guitar/30 DARK STAR METAL_B4OGG.wav","Resources/Guitar/31 DARK STAR METAL_C5OGG.wav","Resources/Guitar/32 DARK STAR METAL_C#5OGG.wav","Resources/Guitar/33 DARK STAR METAL_D5OGG.wav","Resources/Guitar/34 DARK STAR METAL_D#5OGG.wav","Resources/Guitar/35 DARK STAR METAL_E5OGG.wav","Resources/Guitar/36 DARK STAR METAL_F5OGG.wav","Resources/Guitar/37 DARK STAR METAL_F#5OGG.wav","Resources/Guitar/38 DARK STAR METAL_G5OGG.wav","Resources/Guitar/38 DARK STAR METAL_G#5OGG.wav","Resources/Guitar/39 DARK STAR METAL_A5OGG.wav","Resources/Guitar/40 DARK STAR METAL_A#5OGG.wav","Resources/Guitar/40 DARK STAR METAL_B5OGG.wav","Resources/Guitar/41 DARK STAR METAL_C6OGG.wav"] @=> string samples[];
	
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
				<<< "gain: ", b.gain() >>>;
			}
		}
	}
}