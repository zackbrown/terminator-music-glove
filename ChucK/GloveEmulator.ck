// GloveEmulator provides an emulator for the glove, listening to 
// the 1,2,3,4,5 keys and sending OSC messages as it hears them
// Author(s): Zack Brown <zacharyb@cs.washington.edu>
// Revised 2011-03-04

public class GloveEmulator{
	///Pre-constructor:
	[0,0,0,0,0] @=> int playing[];
	
	//Keep track of position values;
	.5 => float x;
	.5 => float y;
	.05 => float sensitivity;
	
	//Default note duration
	500::ms => dur duration;
	
	//Keyboard listener
	KBHit kb;
	
	//OSC sender
	"localhost" => string hostname;
	48888 => int port;
	OscSend xmit;
	xmit.setHost(hostname, port);
	
	<<< "Glove emulator is listening for keystrokes.  Press 1-5 to simulate fingers 0-4", " " >>>;
	
	spork ~ listenForKeys();
	
	///End pre-constructor
	
	fun void setPort(int newPort){
		newPort => port;
	}
	
	fun void setNoteDuration(dur newDur){
		newDur => duration;
	}
	
	//function to be sporked as a keyboard listener
	fun void listenForKeys(){
		while(true){
			kb => now;
			while(kb.more()){
				kb.getchar() => int key;
				if(key == 49){
					emulatePress(0);
				}else if(key == 50){
					emulatePress(1);
				}else if(key == 51){
					emulatePress(2);
				}else if(key == 52){
					emulatePress(3);
				}else if(key == 53){
					emulatePress(4);
				}else if(key == 224){
					//This is an arrow key.
					kb.getchar() => int nextKey;
					//clockwise from top:
					if(nextKey == 72){
						Math.max(0., y - sensitivity) => y;
					}else if(nextKey == 77){
						Math.min(1., x + sensitivity) => x;
					}else if(nextKey == 80){
						Math.min(1., y + sensitivity) => y;
					}else if(nextKey == 75){
						Math.max(0., x - sensitivity) => x;
					}
					xmit.startMsg("/data/camera/glovePosition", "f f");
					xmit.addFloat(x);
					xmit.addFloat(y);
					
				}else{
					<<< key , " not implemented." >>>;
				}
			}
		}
	}
	
	//handles emulating a finger press (sending out start and stop signals.)
	//also enforces that start-stop signals will always be sent in matched pairs
	fun void emulatePress(int finger){
		if(playing[finger]){
			//if this finger is already playing, kill the shred
			//waiting to send a stop msg and then send the stop msg
			//manually before sending a new start message
			//(this ensures a start/stop will always be sent in matching pairs)
			Machine.remove(playing[finger]);
			stopMsg(finger);
		}
		xmit.startMsg("/data/glove/startstop", "i s");
		xmit.addInt(finger);
		xmit.addString("start");
		xmit.startMsg("/data/glove/pressure", "i f");
		xmit.addInt(finger);
		xmit.addFloat(.5);
		(spork ~ stopKey(finger)).id() => playing[finger];
	}
	
	//stopKey waits a specified amount of time (the value of the
	//field 'duration') before sending a stop OSC message
	fun void stopKey(int finger){
		duration => now;
		stopMsg(finger);
	}
	
	//stopMsg immediately sends out the OSC stop signal
	fun void stopMsg(int finger){
		xmit.startMsg("/data/glove/startstop", "i s");
		xmit.addInt(finger);
		xmit.addString("stop");
		0 => playing[finger];
	}
}