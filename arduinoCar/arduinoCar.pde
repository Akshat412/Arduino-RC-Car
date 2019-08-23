import processing.serial.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;
ControlIO control;

Serial myPort;

float move, turn, speed, turn_s;
char dir;

int intMove, intTurn;

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
  move = cont.getSlider("moveDir").getValue();
  turn = cont.getSlider("turnDir").getValue();
  
  intMove = (int)map(move, -1, 1, 0, 255);
  intTurn = (int)map(turn, -1, 1, 0, 255);
}

void draw()
{
  getUserInput();
  println(int(move));
  if(move < -100) background(-1 * move, turn, 255);
  else if(move > 100) background(move, turn, 255);
  else background(0, turn, 255);
  
  byte out[] = new byte[2];
  out[0] = byte(intMove);
  out[1] = byte(intTurn);
  myPort.write(out);
}
