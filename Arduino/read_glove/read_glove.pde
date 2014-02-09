#include <stdio.h>

int analogPins[] = {0, 1, 2, 3, 4};
int pressureValues[] = {0, 0, 0, 0, 0};
int onOff[] = {0, 0, 0, 0, 0};

void setup()
{
  Serial.begin(9600); 
}

void loop()
{
  
  for(int i = 0; i < 5; i++){
    pressureValues[i] = analogRead(analogPins[i]);
    //char printMe[] = {' ',' ',' ',' ',' ',' ',' ',' '};
    if(pressureValues[i] > 6){
      if(onOff[i] == 0){
        onOff[i] = 1;
        //send START signal 
        char out[9];
        sprintf(out, "%i %6i", i, 1);
        Serial.println(out);
      }
      
      char out[9];
      sprintf(out, "%i %6i", i, pressureValues[i]);
      Serial.println(out);
    }else if(pressureValues[i] < 2 ){
      if(onOff[i] == 1){
        onOff[i] = 0;
        //send STOP signal 
        char out[9];
        sprintf(out, "%i %6i", i, 0);
        Serial.println(out);
      }
    }
  }
}
