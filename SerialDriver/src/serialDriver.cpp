#include "serialDriver.h"
using namespace std;

//--------------------------------------------------------------
void serialDriver::setup(){	 

	ofSetVerticalSync(true);

	bSendSerialMessage = true;
	ofBackground(255,255,255);	
			
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

}


void serialDriver::onNewMessage(string & message)
{
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
void serialDriver::update(){
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
    }
  }
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
void serialDriver::draw(){

}


//--------------------------------------------------------------
void serialDriver::keyPressed  (int key){ 
	
}

//--------------------------------------------------------------
void serialDriver::keyReleased(int key){ 
	
}

//--------------------------------------------------------------
void serialDriver::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void serialDriver::mouseDragged(int x, int y, int button){
	
}

//--------------------------------------------------------------
void serialDriver::mousePressed(int x, int y, int button){
	//bSendSerialMessage = true;
}

//--------------------------------------------------------------
void serialDriver::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void serialDriver::windowResized(int w, int h){

}

