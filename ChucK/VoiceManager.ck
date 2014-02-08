// VoiceManager accepts a list of Voices, then subsequently
// a series of "play" commands.  It handles the y value of
// the current position to change the active track
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-05

public class VoiceManager extends UGen{
	Voice voices[0];
	.5 => float x;
	.5 => float y;
	1 => int columns;
	
	// Adds a voice to the current array (must resize first)
	fun void addVoice(Voice newVoice){
		Voice newVoices[voices.size() + 1];
		for(0 => int i; i < voices.size(); i++){
			voices[i] @=> newVoices[i];
		}
		
		columns => newVoice.columns;
		newVoice @=> newVoices[voices.size()];
		newVoice => this;
		newVoices @=> voices;
	}
	
	fun void setNoteRange(int min, int max){
		for(0 => int i; i < voices.size(); i++){
			voices[i].setMinNote(min);
			voices[i].setMaxNote(max);
		}
	}
	
	fun void playNote(int finger, NoteEvent noteEvent){
		// First, select which voice to play
		Math.min(voices.size() - 1, Math.floor(y * voices.size())) $ int => int whichVoice;
		<<< "VoiceManager.playNote(", finger, ", noteEvent)" >>>;
		spork ~ voices[whichVoice].playNote(finger, noteEvent);
	}
	
	fun void setFrame(float newX, float newY){
		newX => x;
		newY => y;
		for(0 => int i; i < voices.size(); i++){
			voices[i].setFrame(x);
		}
	}
}