
// This attaches a recorder to the output from the synthesizer
//
// author: Zachary Brown <zacharyb@cs.washington.edu>
// modified: 8 Mar 2011


public class Looping extends UGen {
    
    // Input to loop
    UGen @ in;
    
    // Number of beats per minute
    120 => int bpm;
    
    // Number of measures
    4 => int measures;
    
    // Number of beats per measure
    4 => int beatsPerMeasure;
    
    // Metronome to keep track of the time
    Metronome metronome;
    
    // Currently recording layer
    LiSa currentLayer => this;
    10::second => currentLayer.duration;
    
    // Length of loop
    dur loopLength;
    
    
    public void setBpm(int bpm) {
        bpm => this.bpm;
        bpm => metronome.setBpm;
        
        setupRecord();
    }
    
    public void beats(int beatsPerMeasure, int measures) {
        beatsPerMeasure => this.beatsPerMeasure;
        measures => this.measures;
        
        setupRecord();
    }
    
    // Sets up the LiSa to record for the specified time
    private void setupRecord() {
        (measures * beatsPerMeasure * (1.0 / bpm) * 60)::second => loopLength;
        loopLength => currentLayer.duration;
        
        <<< loopLength >>>;
    }
    
    
    public UGen chuck(UGen g) {    
        g @=> in;
        
        g => this;          // Pass-through sound
        metronome => this;  // Add a metronome
        
        spork ~ oscListenRecord();
        playLoops();
        
        return this;
    }
    
    public void oscListenRecord() {
        OscRecv recv;
        48888 => recv.port;     // TODO: Move this to configuration
        recv.listen();
        
        recv.event( "/control/loop/playback, i" ) @=> OscEvent oe;
        
        while (oe => now) {
            if (oe.nextMsg() != 0) {
                oe.getInt() => int record;
                
                if (record == 1) {
                    startRecord();
                } else {
                    stopRecord();
                }
            }
        }
    }
    
    // Starts recording the current loop
    private void startRecord() {
        <<< "Starting record" >>>;
    
        // Hook up the current input to the recorder
        in => currentLayer;
        
        // Wrap around the loop in recording
        1 => currentLayer.loopRec;
        
        // Find the right place in the buffer
        now % loopLength => currentLayer.recPos;
        
        // Set the end of the recording buffer
        loopLength => currentLayer.loopEndRec;
        
        // Kick off the record
        currentLayer.record(1);
        
        <<< "Recording" >>>;
    }
    
    // Stops recording the current loop
    private void stopRecord() {
        <<< "Stopping record" >>>;
        
        currentLayer.record(0);
        
        <<< "Stopped" >>>;
    }
    
    
    // Play the currently recorded loop
    public void playLoops() {
        <<< "Playing the loops" >>>;
    
        1 => currentLayer.loop;
        loopLength => currentLayer.loopEnd;
        
        currentLayer.play(1);
    }
}