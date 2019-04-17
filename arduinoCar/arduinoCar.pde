import processing.serial.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import cc.arduino.*;
import org.firmata.*;

ControlDevice cont;
ControlIO control;

Arduino arduino;

float move, turn;

int in1 = 2; 
int in2 = 3;
int in3 = 7;
int in4 = 8;

void setup()
{
  size(360, 200);
  
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice("XB1C");
  
  if(cont == null)
  {
    println("No Controller Found");
    System.exit(-1);
  }
  
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  arduino.pinMode(in1, Arduino.OUTPUT);
  arduino.pinMode(in2, Arduino.OUTPUT);
  arduino.pinMode(in3, Arduino.OUTPUT);
  arduino.pinMode(in4, Arduino.OUTPUT);
  
  //Control for motor 1
  arduino.digitalWrite(in1, Arduino.LOW);
  arduino.digitalWrite(in2, Arduino.LOW);
     
  //Control for motor 2
  arduino.digitalWrite(in3, Arduino.LOW);
  arduino.digitalWrite(in4, Arduino.LOW);
  
  move = turn = 0;
}

public void getUserInput()
{
  move = 1024 * cont.getSlider("moveDir").getValue();
  turn = 1024 * cont.getSlider("turnDir").getValue();
  
  if(move < 100 && move > -100)
  {
    //Control for motor 1
    arduino.digitalWrite(in1, Arduino.LOW);
    arduino.digitalWrite(in2, Arduino.LOW);
     
    //Control for motor 2
    arduino.digitalWrite(in3, Arduino.LOW);
    arduino.digitalWrite(in4, Arduino.LOW);
  }
  
  else if(move > 100)
  {
    //Control for motor 1
    arduino.digitalWrite(in1, Arduino.LOW);
    arduino.digitalWrite(in2, Arduino.HIGH);
     
    //Control for motor 2
    arduino.digitalWrite(in3, Arduino.LOW);
    arduino.digitalWrite(in4, Arduino.HIGH);
  }
  
  else if(move < 100)
  {
    //Control for motor 1
    arduino.digitalWrite(in1, Arduino.HIGH);
    arduino.digitalWrite(in2, Arduino.LOW);
     
    //Control for motor 2
    arduino.digitalWrite(in3, Arduino.HIGH);
    arduino.digitalWrite(in4, Arduino.LOW);
  }
}

void draw()
{
  getUserInput();
  println(move);
  if(move < -100) background(-1 * move, turn, 255);
  if(move > 100) background(move, turn, 255);
}
