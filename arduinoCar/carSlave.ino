int in1 = 7; 
int in2 = 4;
int in3 = 6;
int in4 = 5;
int s1 = 10;
int s2 = 11;

int mov, turn;

#define ledPin 7

int state = 0;

void setup() {
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
  Serial.begin(9600); // Default communication rate of the Bluetooth module
}
void loop() {
  if(Serial.available() > 0){ // Checks whether data is comming from the serial port
    state = Serial.read(); // Reads the data from the serial port
 }
 if (state == '0') {
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  state = 0;
 }
 else if (state == '1') {
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  state = 0;
 } 
}
