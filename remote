#include <RCSwitch.h> //this connects to the library of the RC switch used for the transmitter

RCSwitch mySwitch = RCSwitch(); //initialising new RC switch

int buttonPin = 9; //specifying button and LED pin
int ledPin = 7;

int buttonState = 0;         // current state of the button
int lastButtonState = 0;     // previous state of the button
// the follow variables are long's because the time, measured in miliseconds,
// will quickly become a bigger number than can be stored in an int.
long time_down = 0;         // the last time the output pin was toggled
long debounce = 300;   // the debounce time, increase if the output flickers

void setup() {
  Serial.begin(9600);
  // Transmitter is connected to Atmega Pin #10
  mySwitch.enableTransmit(10);


  // Optional set protocol (default is 1, will work for most outlets)
  mySwitch.setProtocol(1);
  // Optional set pulse length.
  //mySwitch.setPulseLength(140);

  // Optional set number of transmission repetitions.
  //mySwitch.setRepeatTransmit(10);

  // initialize the button pin as a input:
  pinMode(buttonPin, INPUT_PULLUP);
  // initialize the LED as an output:
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // read the pushbutton input pin:
  buttonState = digitalRead(buttonPin);

  if (buttonState == LOW && millis() - time_down > debounce) {
    // if the pushbutton has been pressed, write HIGH the LED pin
    digitalWrite(ledPin, HIGH);
    // send a value of 1 using 8 bits (doesnt really matter what number, but be careful about the number of bits
    mySwitch.send(1, 8);
    delay(3000);   //wait 3 seconds before turning the LED off
    digitalWrite(ledPin, LOW);
    time_down = millis();
  }
}
