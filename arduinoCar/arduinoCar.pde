import processing.serial.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;
ControlIO control;

Serial myPort;

float move, turn, speed, turn_s;
char dir;

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
  
  move = turn = 0;
  
  myPort = new Serial(this, "COM5", 9600); // Starts the serial communication
  myPort.bufferUntil('\n'); // Defines up to which character the data from the serial port will be read. The character '\n' or 'New Line'
}

public void getUserInput()
{
  move = 1000 * cont.getSlider("moveDir").getValue();
  turn = 1000 * cont.getSlider("turnDir").getValue(); 
  
  if(move > 300)
  {
    dir = '1';  
  }
  
  else if(move > -300 && move < 300)
  {
    dir = '0';
  }
  
  else
  {
    dir = '1'; 
  }
  
}

void draw()
{
  getUserInput();
  println(int(dir));
  if(move < -100) background(-1 * move, turn, 255);
  else if(move > 100) background(move, turn, 255);
  else background(0, turn, 255);
  
  myPort.write(dir);
}
