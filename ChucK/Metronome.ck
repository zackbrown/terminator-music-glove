
//
// Metronome.ck
//
// Plays a standard metronome pulse to a specified beat.
//
// author: Andrew Smith <andrewrs@cs.washington.edu>
// modified: 14 Mar 2011
//

public class Metronome extends UGen {

    // Rate (beats/minute) of the metronome
    int bpm;

    // Duration between ticks
    dur beat;
    
    // Tick length
    500::samp => dur tick;

    // Metronome sound
    SinOsc osc;
    440 * 2 => osc.freq;


    // default rate on 120
    setBpm(120);
    
    // Shred that holds the running metronome
    Shred @ running;
    
    
    
    // Set the rate of the metronome
    public void setBpm(int bpm) {
         bpm => this.bpm;
         (60.0 / bpm)::second => beat;
    }
    
    // Starts the metronome at the beginning of a tick
    public void start() {
        if (running == null) {
            osc => this;
            spork ~ run() @=> running;
        }
    }
    
    // Stops the metronome
    public void stop() {
        osc =< this;
        Machine.remove(running.id());
        null @=> running;
    }



    private void run() {
        // Start the looping
        while (true) {
            // Turn on the metronome
            0.9 => osc.gain;
    
            tick => now;
    
            // Turn off the metronome
            0.0 => osc.gain;
    
            beat - tick => now;
        }
    }
}