int in1 = 4; 
int in2 = 6;
int in3 = 10;
int in4 = 11;

int mov, turn;

int currentValue = 0;
int values[] = {0,0};

int state = 0;

void setup() 
{  
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);

  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);
  
  Serial.begin(9600); // Default communication rate of the Bluetooth module
}

void loop() 
{
  mov = turn = 0;
  
  if(Serial.available())
  {
    int incomingValue = Serial.read();
    
    values[currentValue] = incomingValue;
    currentValue++;
    
    if(currentValue > 1)
    {
      currentValue = 0;
    }
  } 

  mov = values[0];
  turn = values[1];

  if(mov > 100 && mov < 150)
  {
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
  }

  else if(mov > 150)
  {
    digitalWrite(in1, HIGH);
    digitalWrite(in2, LOW);
  }

  else if(mov < 100)
  {
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
  }
}
