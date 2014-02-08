#include "testApp.h"
using namespace std;

//--------------------------------------------------------------
void testApp::setup(){	 

	ofSetVerticalSync(true);

	bSendSerialMessage = true;
	ofBackground(255,255,255);	
	
	
	//serial.enumerateDevices();
			
	sender.setup( HOST, PORT );
	//----------------------------------- note:
	// < this should be set
	// to whatever com port
	// your serial device is
	// connected to.
	// (ie, COM4 on a pc, /dev/tty.... on linux, /dev/tty... on a mac)
	// arduino users check in arduino app....

	serial.setup("COM8", 19200);  						  // windows example
	//serial.setup("/dev/tty.usbserial-A4001JEC",9600); // mac osx example
	//serial.setup("/dev/ttyUSB0", 9600);			  //linux example

	//serial.startContinuousRead(false);
	//ofAddListener(serial.NEW_MESSAGE,this,&testApp::onNewMessage);

	//----------------------------------- 
	//font.loadFont("DIN.otf",64);
	//nTimesRead = 0;
	//nBytesRead = 0;
	//readTime = 0;
	//memset(bytesReadString, 0, 11);
}


void testApp::onNewMessage(string & message)
{
	//cout << "onNewMessage, message: " << message << "\n";
	vector<string> elems;
	char delim = ' ';
	std::stringstream ss(message);
	std::string item;
	while(std::getline(ss, item, delim)) {
		elems.push_back(item);
	}


	if(elems.size() > 1 && elems.at(0) != ""){
				

		int rawPressure;
		for(int i = 0; i < elems.size(); i++){
			if(elems.at(i) != "")
				rawPressure = atoi(elems.at(i).c_str());
		}
			
		int fingerIndex = atoi(elems.at(0).c_str());

		//handle special cases where "pressure" == 1 or 0
		//(0 means a STOP signal and 1 means a START signal)
		if(rawPressure == 0){
			//Send STOP signal
			ofxOscMessage m;
			m.setAddress( "/data/glove/startstop" );
			m.addIntArg(fingerIndex);
			m.addStringArg( "stop" );
			sender.sendMessage( m );
			//cout<<"STOP!"<<endl;
		}else if(rawPressure == 1){
			//Send START signal
			ofxOscMessage m;
			m.setAddress( "/data/glove/startstop" );
			m.addIntArg(fingerIndex);
			m.addStringArg( "start" );
			sender.sendMessage( m );
			//cout<<"START!"<<endl;

		}else{

			//manipulate pressure as needed
			//taking 1/rawPressure makes the pressure curve more linear
            float PRESSURE_CUTOFF = 140;
			float pressure = 1.0 / ((PRESSURE_CUTOFF + 1) - min(PRESSURE_CUTOFF, rawPressure));
			pressure *= 10.0;


			//the higher maxPressureCoeff, the higher the max supported pressure value
			//(final value will still be between 0-1 regardless)
			float maxPressureCoeff = 1.25;
			pressure = min(maxPressureCoeff, pressure) / maxPressureCoeff;
				
			ofxOscMessage m;
			m.setAddress( "/data/glove/pressure" );
			m.addIntArg(fingerIndex);
			m.addFloatArg( pressure );
			sender.sendMessage( m );
		}
	}
			
}

//--------------------------------------------------------------
void testApp::update(){
	const int chunk = 10;
    unsigned char bytesReturned[chunk];

    // if we've got new bytes
	if(serial.available() >= 10)
	{
	   // we wil keep reading until nothing is left
		while (serial.available() >= 10)
		{
		   // we'll put the incoming bytes into bytesReturned
		   serial.readBytes(bytesReturned, chunk);
		
           string s = string();
           for(int i = 0; i < chunk; i++){
                s.push_back(bytesReturned[i]);
           }
           //cout << s << endl;
           onNewMessage(s);
		   // if we find the splitter we put all the buffered messages 
		   //   in the final message, stop listening for more data and 
		   //   notify a possible listener
		   // else we just keep filling the buffer with incoming bytes. 
		   /*if(*bytesReturned == '\n')
			{
			   message = messageBuffer;
			   messageBuffer = "";
			   ofRemoveListener(ofEvents.update, this, &ofxSimpleSerial::update);
			   ofNotifyEvent(NEW_MESSAGE,message,this);
			   
			   break;
			}
			else 
			{
			   if(*bytesReturned != '\r')
				   messageBuffer += *bytesReturned;
			}
		    //cout << "  messageBuffer: " << messageBuffer << "\n";
		}
	   
		// clear the message buffer
		memset(bytesReturned,0,NUM_BYTES);*/
	    }
    }
	//serial.sendRequest();

	// (1) write the letter "a" to serial:
	//serial.writeByte('a');
		
	// (2) read
	// now we try to read 3 bytes
	// since we might not get them all the time 3 - but sometimes 0, 6, or something else,
	// we will try to read three bytes, as much as we can
	// otherwise, we may have a "lag" if we don't read fast enough
	// or just read three every time. now, we will be sure to 
	// read as much as we can in groups of three...

	//nTimesRead = 0;
	//nBytesRead = 0;
	//int nRead  = 0;  // a temp variable to keep count per read
		
	//unsigned char bytesReturned[10];

	//memset(bytesReadString, 0, 11);
	//memset(bytesReturned, 0, 10);

	/*string output = "";
		
	char byteReturned;
	
	while( (byteReturned = serial.readByte()) > 0){
		nTimesRead++;

		if(byteReturned == '|'){
			//handle current output string
			vector<string> elems;
			char delim = ' ';
			std::stringstream ss(output);
			std::string item;
			while(std::getline(ss, item, delim)) {
				elems.push_back(item);
			}

			if(elems.size() > 1 && elems.at(0) != ""){
				

				int rawPressure;
				for(int i = 0; i < elems.size(); i++){
					if(elems.at(i) != "")
						rawPressure = atoi(elems.at(i).c_str());
				}
			
				int fingerIndex = atoi(elems.at(0).c_str());

				//handle special cases where "pressure" == 1 or 0
				//(0 means a STOP signal and 1 means a START signal)
				if(rawPressure == 0){
					//Send STOP signal
					ofxOscMessage m;
					m.setAddress( "/data/glove/startstop" );
					m.addIntArg(fingerIndex);
					m.addStringArg( "stop" );
					sender.sendMessage( m );
					cout<<"STOP!"<<endl;
				}else if(rawPressure == 1){
					//Send START signal
					ofxOscMessage m;
					m.setAddress( "/data/glove/startstop" );
					m.addIntArg(fingerIndex);
					m.addStringArg( "start" );
					sender.sendMessage( m );
					cout<<"START!"<<endl;

				}else{

					//manipulate pressure as needed
					//taking 1/rawPressure makes the pressure curve more linear
					float pressure = 1.0 / (141 - min(140, rawPressure));
					pressure *= 10.0;


					//the higher maxPressureCoeff, the higher the max supported pressure value
					//(final value will still be between 0-1 regardless)
					float maxPressureCoeff = 1.25;
					pressure = min(maxPressureCoeff, pressure) / maxPressureCoeff;
				
					ofxOscMessage m;
					m.setAddress( "/data/glove/pressure" );
					m.addIntArg(fingerIndex);
					m.addFloatArg( pressure );
					//m.addStringArg( "hello" );
					//m.addFloatArg( ofGetElapsedTimef() );
					sender.sendMessage( m );
				}

				//printf("%i %6f", fingerIndex, val);

			}
			output = "";
		}else{
			output.push_back(byteReturned);
		}
		//output.append(
		//printf(bytesReadString);
	};
	//cout << output << endl;

	//memcpy(bytesReadString, bytesReturned, 8);
		
	//cout<<output<<endl;

	//bSendSerialMessage = false;
	//readTime = ofGetElapsedTimef();
	*/
}

std::vector<std::string> &split(const std::string &s, char delim, std::vector<std::string> &elems) {
    std::stringstream ss(s);
    std::string item;
    while(std::getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}


std::vector<std::string> split(const std::string &s, char delim) {
    std::vector<std::string> elems;
    return split(s, delim, elems);
}


//--------------------------------------------------------------
void testApp::draw(){

	/*char tempStr[1024];
	sprintf(tempStr, "click to test serial:\nnBytes read %i\nnTimes read %i\nread: %s\n(at time %0.3f)", nBytesRead, nTimesRead, bytesReadString, readTime);
	
	if (nBytesRead > 0 && ((ofGetElapsedTimef() - readTime) < 0.5f)){
		ofSetColor(0x000000);
	} else {
		ofSetColor(0xdddddd);
	}
	font.drawString(tempStr, 50,100);*/

}


//--------------------------------------------------------------
void testApp::keyPressed  (int key){ 
	
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){ 
	
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
	
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
	//bSendSerialMessage = true;
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}

