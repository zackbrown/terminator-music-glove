// Voice acts as the base class for any 'instrument' voice,
// whether it's built on samples or generators or anything
// in between
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class Voice extends UGen{
	//deprecated
	int minSupportedNote;
	int maxSupportedNote;
	int minSetNote;
	int maxSetNote;
	
	int columns;
	
	static int killNoteImmediately;
	float frame;
	float lastPressures[3];
	.75::second => dur release;
	
	// Set this voice's minimum supported note (0-127) a la MIDI
	fun void setMinNote(int min){
		min => minSetNote;
	}
	
	// Set this voice's maximum supported note (0-127) a la MIDI
	fun void setMaxNote(int max){
		max => maxSetNote;
	}
	
	// Play this specified note (0-4) from the glove
	fun void playNote(int finger, NoteEvent noteEvent){
		//x-position (0 to 1) is "frame"
		(5.0 * Math.floor(Math.min(.999, frame) * (columns $ float)) + (finger $ float)) $ int => int noteArrayIndex;
		
		spork ~ handlePreviousPressures(noteEvent);
		playRawNote(noteArrayIndex, noteEvent);
		
		
		/*maxSetNote - minSetNote => int totalNotes;
		((frame * (totalNotes - 5) + note) + (minSetNote - minSupportedNote)) $ int => int playThisNote;
		
		if(playThisNote + minSetNote >= minSupportedNote && playThisNote + minSetNote <= maxSupportedNote){
			spork ~ handlePreviousPressures(noteEvent);
			playRawNote(playThisNote, noteEvent);
		}*/
	}
	
	fun void handlePreviousPressures(NoteEvent noteEvent){
		while(true){
			noteEvent => now;
			if(!noteEvent.stopMe){
				//shift array elements one to the left
				for(0 => int i; i < lastPressures.size() - 1; i++){
					lastPressures[i + 1] => lastPressures[i];
				}
				noteEvent.pressure => lastPressures[lastPressures.size() - 1];
			}
		}
	}
	
	fun float getAveragePressure(){
		0 => int count;
		0. => float runningTotal;
		for(0 => int i; i < lastPressures.size(); i++){
			if(lastPressures[i] != 0){
				count++;
				runningTotal + lastPressures[i] => runningTotal;
			}
		}
		if(count == 0){
			return 0.;
		}
		return runningTotal / (count $ float);
	}
	
	//Kill note gradually instead of abruptly
	fun int killNote(Shred killShred, UGen b){
		100 => int steps;
		getAveragePressure() => float avgPressure;
		for(1 => int i; i <= steps; i++){
			if(killNoteImmediately){
				steps + 1 => i;
			}else{
				avgPressure - (((i $ float) / (steps $ float)) * avgPressure) => b.gain;
				release / (steps $ float) => now;
			}
		}
		0. => b.gain;
		return 1;
	}
	
	fun void playRawNote(int playThisNote, NoteEvent noteEvent){
	
	}
	
	fun void setFrame(float newFrame){
		newFrame => frame;
	}
}