// OSCManager provides a simplified interface to OSC
// events, providing wrapper events on request and
// handling all of the behind-the-scenes work.
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class OSCManager{

	//Default port is 48888
	48888 => int port;
	GloveEvent gloveEvent;
	PositionEvent positionEvent;
	NoteEvent noteEvents[5];
	2.0 => float pressureMult;
	.25 => float pressureOffset;

	////Pre-constructor:
	// OSC stuff
	OscRecv recv;
	port => recv.port;
	recv.listen();
	
	OscSend send;
	send.setHost("localhost", port);
	
	recv.event( "/data/glove/pressure, i f") @=> OscEvent oscGlovePressure;
	recv.event( "/data/glove/startstop, i s") @=> OscEvent oscGloveStartStop;
	recv.event( "/data/camera/glovePosition, f f" ) @=> OscEvent oscGlovePosition;
	
	spork ~ manageGlovePosition();
	spork ~ manageGlovePressure();
	spork ~ manageGloveStartStop();
	////End pre-constructor
	
	fun void setPort(int newPort){
		newPort => port;
	}
	
	fun GloveEvent getGloveEvent(){
		return gloveEvent;
	}
	
	fun PositionEvent getPositionEvent(){
		return positionEvent;
	}
	
	//Handles OSC messages regarding glove pressures,
	//updates the wrapper event, and fires it
	fun void manageGlovePressure(){
		while(true){
			oscGlovePressure => now;
			
				while (oscGlovePressure.nextMsg() != 0 )
				{
					oscGlovePressure.getInt() => int finger;
					oscGlovePressure.getFloat() => float pressure;
					Math.min(1.0, pressureMult * pressure + pressureOffset) => pressure;
					// print
					<<< "pressure finger: ", finger, ",pressure: ", pressure >>>;
					if(gloveEvent.handled){
						finger => gloveEvent.finger;
						pressure => gloveEvent.pressure;
						"pressure" => gloveEvent.startStop;
						gloveEvent.broadcast();
						
						pressure => noteEvents[finger].pressure;
						noteEvents[finger].broadcast();
					}
				}
			
		}
	}
	
	//Handles OSC messages regarding glove starts/stops,
	//updates the wrapper event, and fires it
	fun void manageGloveStartStop(){
		while(true){
			oscGloveStartStop => now;
			while (oscGloveStartStop.nextMsg() != 0 )
			{
				oscGloveStartStop.getInt() => int finger;
				oscGloveStartStop.getString() => string startStop;
				
				// print
				<<< now, startStop, finger >>>;
				
				//Specifically handle "start" case by
				//generating a new note event
				if(startStop == "start"){
					NoteEvent neNew @=> noteEvents[finger];
					0 => neNew.stopMe;
					0. => neNew.pressure;
					neNew @=> gloveEvent.noteEvent;
				}else if(startStop == "stop"){
					1 => noteEvents[finger].stopMe;
					noteEvents[finger].broadcast();
				}
				
				finger => gloveEvent.finger;
				startStop => gloveEvent.startStop;
				//<<< "broadcasting: finger: ", finger, ", startStop: ", startStop >>>;
				0 => gloveEvent.handled;
				gloveEvent.broadcast();
				
			}
		}
	}
	
	//Handles OSC messages regarding glove position,
	//updates the wrapper event, and fires it
	fun void manageGlovePosition(){
		while(true){
			oscGlovePosition => now;
			while (oscGlovePosition.nextMsg() != 0 )
			{
				oscGlovePosition.getFloat() => float x;
				oscGlovePosition.getFloat() => float y;
				
				// print
				<<< "position x: ", x, " y:", y >>>;
				
				x => positionEvent.x;
				y => positionEvent.y;
				positionEvent.broadcast();
			}
		}
	}
	
	//echo glove data for external tools
	fun void echoGlovePosition(float x, float y){
		send.startMsg("/echo/data/camera/glovePosition", "f f");
		send.addFloat(x);
		send.addFloat(y);
	}

	fun void echoGloveStartStop(int finger, string startStop){
		send.startMsg("/echo/data/glove/startstop", "i s");
		send.addInt(finger);
		send.addString(startStop);
	}
}