
//
// LoopManager.ck
//
// This attaches a recorder to the output from the synthesizer.
//
// author: Andrew Smith <andrewrs@cs.washington.edu>
// modified: 14 Mar 2011
//

public class LoopManager extends UGen {
    
    // LiSas for recording
    LiSa layers[10];
    
    // Which track are we recording on?
    0 => int currentTrack;
    
    // Are we recording?
    0 => int recording;
    
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
    
    // Length of loop
    dur loopLength;
    
    
    //
    // Setup methods: Determine how long to record and how to set the metronome.
    //
    
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
        
        // Set the end of the recording buffer
        for (0 => int i; i < layers.size(); i++) {
            layers[i] => this;
            loopLength => layers[i].duration;
            loopLength => layers[i].loopEndRec;
            loopLength => layers[currentTrack].loopEnd;
        }
        
        sendOSCLoopLength();
    }
    
    // Send an OSC message about the loop length
    private void sendOSCLoopLength() {
        OscSend osc;
        // TODO: This should be swapped to multicast
        osc.setHost( "localhost", 48888 );
        osc.startMsg( "/announce/loop/duration", "f" );
        (loopLength / 1::samp) / (second / samp) => osc.addFloat;
        
        <<< "Sent OSC message about the loop duration", "" >>>;
    }
    
    
    //
    // Attach to the ChucK pipeline
    //
    
    public UGen chuck(UGen g) {
        // Connections  
        g @=> in;
        g => this;          // Pass-through sound
        metronome => this;  // Add a metronome
        
        // Setup
        for (0 => int i; i < layers.size(); i++) {
            1 => layers[currentTrack].loop;
        }
        
        // OSC
        spork ~ oscListenRecord();
        
        // Connect to the rest of the pipeline
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
    
    
    //
    // Recording methods
    //
    
    // Starts recording the current loop
    public void startRecord() {
        <<< "Starting record", currentTrack >>>;
        layers[currentTrack].play(0);
    
        // Hook up the current input to the recorder
        in => layers[currentTrack];
        
        // Wrap around the loop in recording
        1 => layers[currentTrack].loopRec;
        
        // Find the right place in the buffer
        now % loopLength => layers[currentTrack].recPos;
        
        // Kick off the record
        layers[currentTrack].record(1);
        metronome.start();
        
        1 => recording;
    }
    
    // Stops recording the current loop
    public void stopRecord() {
        if (recording != 0) {
            <<< "Stopping record", currentTrack >>>;
            0 => recording;
        
            metronome.stop();
            layers[currentTrack].record(0);
        
            // Start playing where we left off.
            now % loopLength => layers[currentTrack].playPos;
            layers[currentTrack].play(1);
        
            // Choose the next track to record to
            (1 + currentTrack) % layers.size() => currentTrack;
        }
    }
    
    
    //
    // Playback methods
    //
    
    // Stops recording and all playing tracks
    public void stopAll() {
        stopRecord();
        
        for (0 => int i; i < layers.size(); i++) {
            layers[i].play(0);
        }
    }
}