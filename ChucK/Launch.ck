
//
// Launch.ck
//
// This ChucK script launches the entire application. The main starting point is
// in SampleSpace.ck.
//
// Author: Zachary Brown <zacharyb@cs.washington.edu>
// Modified: 14 Mar 2011
//

// Events
Machine.add("NoteEvent.ck");
Machine.add("GloveEvent.ck");
Machine.add("PositionEvent.ck");

// OSC
Machine.add("OSCManager.ck");

// Voices
Machine.add("Voice.ck");
Machine.add("VoiceManager.ck");
Machine.add("ElectricGuitarVoice.ck");
Machine.add("PianoVoice.ck");
Machine.add("Drum1Voice.ck");
Machine.add("Drum2Voice.ck");
Machine.add("PhasorVoice.ck");
Machine.add("JazzPianoVoice.ck");

// Debugging
Machine.add("GloveEmulator.ck");

// Looping
Machine.add("Metronome.ck");
Machine.add("LoopManager.ck");

// Run it!
Machine.add("SampleSpace.ck");
