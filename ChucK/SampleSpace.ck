//
// SampleSpace.ck 
//
// The entry point for the SampleSpace program
//
// Author: Zack Brown <zacharyb@cs.washington.edu>,
// Author: Andrew Smith <andrewrs@cs.washington.edu>
// Modified: 2011-03-04
//

// What We're Implementing
// =======================
// DONE:  Make voices and/or voice selection modulate based on position data
// TODO:  Add some random variance (random ADSR envelopes?) for a more 'human' feel
//		  (or will pressure differences in the real glove be enough?)
// TODO:  Implement looping.  Have another piece of code monitor the NoteEvents
// and record them, then re-send notes and artifical NoteEvents in a loop
// To measure time, you can say "now => time t" to get a timestamp and subtract
// timestamps to yield type "dur"s



// Constants
48888 => int PORT_NUMBER;

// Create glove emulator
GloveEmulator g;
g.setPort(PORT_NUMBER);

// Create OSC Listener
OSCManager osc;
osc.setPort(PORT_NUMBER);

// Initialize voice(s) and VoiceManager
new VoiceManager @=> VoiceManager vm;
5 => vm.columns;

////Development kit
//vm.addVoice(new Drum1Voice);
//vm.addVoice(new Drum2Voice);
//vm.addVoice(new ElectricGuitarVoice);
//vm.addVoice(new PianoVoice);
//vm.addVoice(new PhasorVoice);

////Jazz kit
/*vm.addVoice(new JazzPianoVoice);
vm.addVoice(new JazzBassVoice);
vm.addVoice(new JazzTenorSaxVoice);
vm.addVoice(new JazzDrumKitVoice);*/

////Dubstep kit
vm.addVoice(new DubstepBeat1Voice);
vm.addVoice(new DubstepBeat2Voice);
vm.addVoice(new DubstepBassVoice);
vm.addVoice(new DubstepSynth1Voice);
vm.addVoice(new DubstepSynth2Voice);

//vm.setNoteRange(40, 64);

// Set default position info
.5 => float x;
.5 => float y;
vm.setFrame(x, y);

// Set up limiter (to avoid clipping)
Dyno d;
d.limit();
0.0 => d.slopeAbove;
.4 => d.thresh;

// Add looping and recording
LoopManager loop;
(4, 2) => loop.beats;       // (beats per measure, measures)
120    => loop.setBpm;      // beats per minute

// Throw everything together
vm => loop.chuck => d => dac;


spork ~ handlePosition();

while(true){
	osc.gloveEvent => now;
	if(! osc.gloveEvent.handled){
		//<<< "Glove Event:  " , osc.gloveEvent.startStop >>>;
		1 => osc.gloveEvent.handled;
		if(osc.gloveEvent.startStop == "start"){
			vm.playNote(osc.gloveEvent.finger, osc.gloveEvent.noteEvent);
		}
	}
};


fun void handlePosition(){
	while(true){
		osc.positionEvent => now;
		osc.positionEvent.x => x;
		osc.positionEvent.y => y;
		vm.setFrame(osc.positionEvent.x, osc.positionEvent.y);
	}
}