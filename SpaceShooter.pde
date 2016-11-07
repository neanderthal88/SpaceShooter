import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


import controlP5.*;

ControlP5 cp5;
//Interfaz de usuario Processing


Minim minim;
FFT fft;
AudioInput in;
float[] angle;
float[] x,y,z;



PImage player;
PImage bullet;
PImage enemy;

SpaceShip s1 = new SpaceShip(250,750, 1); 
SpaceShip s2 = new SpaceShip(100, 750, 2); 
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Asteriod> asteriods = new ArrayList();


void setup()
{
  size(500,800,P3D); 
  asteriodsAssemble();
  bullet = loadImage("bala.gif");
  player = loadImage("a11.png");
  //player.resize(width/4,height/8);  
   enemy = loadImage("C1.png");
   
   
   //Control
   
   cp5 = new ControlP5(this);
  
   
   
   
   //Universo creado con ruido
   minim = new Minim(this);
   in = minim.getLineIn(Minim.STEREO,2048,192000.0);
   in = minim.getLineIn();
   fft = new FFT(in.bufferSize(), in.sampleRate());
   
   
   y = new float[fft.specSize()];
   x = new float[fft.specSize()];
   z = new float[fft.specSize()];
   
   angle = new float[fft.specSize()];
   
   
}

void draw()
{
  background(0); 
  image(player,mouseX-20,mouseY);
  player.resize(0,32);
  
  
  
  //player.display();
  //keepSpaceShipsInCanvas(s1); 
  
  /* For Player 2  */
  //s2.display(); 
  //keepSpaceShipsInCanvas(s2); 
  
  /* Bullet bookkepping code */
  removeToBulletLimit(500);
  moveAllBullets();
  displayAllBullets();
  
  /* Asteriod book keeping code */
  moveAllAsteriods(); 
  displayAllAsteriods(); 
  
  /* Effects of the bullets */
  pushBack();
  //destroyAsteriod();
  
  /* Game Conditions */
  loseCondition();
  winCondition(); 
  
  //universo creadoc on musica
  fft.forward(in.mix);
  doubleAtomicSprocket();

}

void mousePressed()//add a new bullet if mouse is clicked
{
  Bullet temp = new Bullet(mouseX,mouseY);
  bullets.add(temp);
}

///gives the spaceship movement
//void keyPressed()
//{
//  if(key == CODED){
//    switch(keyCode)
//    {
//      case RIGHT:
//        s1.x +=20; 
//        break;
//      case LEFT:
//        s1.x-=20; 
//        break;
//      default:
//        break;
//    }
//  }
//  else if(keyPressed) //space is not special key 
//  {
//    if(key == ' ' )
//    {
//      Bullet temp = new Bullet(s1.x+25,s1.y);
//      bullets.add(temp);
//    }
//    else if(key == 'a' || key =='A')
//    {
//      s2.x -=20; 
//    }
//    else if(key == 'd' || key == 'D')
//    {
//      s2.x +=20; 
//    }
//  }
//} 

void keepSpaceShipsInCanvas(SpaceShip s)
{
  if(s.getX() < 0 )
  {
    s.setX(0); 
  }
  else if(s.getX() > 450)
  {
    s.setX(450); 
  }
}


void displayAllAsteriods()
{
  for(Asteriod temp : asteriods)
  {
    temp.display();
  }
}

void asteriodsAssemble()
{

  for(int x = 0; x <=400; x+=50)
  {
    Asteriod b = new Asteriod(x,(int)random(3)+1,(int)random(100)+1); 
    asteriods.add(b); 
  }
}

void moveAllAsteriods()
{
  for(Asteriod temp : asteriods)
  {
    temp.move();
  }
}

void pushBack()
{
  for(Asteriod a : asteriods)
  {
    for(Bullet b : bullets)
    {
      if((int)b.getX() >= a.getX() && (int)b.getX() <= (a.getX() +50) && (int)b.getY() >= a.getY() && (int)b.getY() <= a.getY()+a.size)
      {
        //push spaceships back 
        a.setY(a.getX() -50); 
        bullets.remove(b); 
        break;
      }
    }

  }
}

void destroyAsteriod()
{
  boolean hit = false; 
  for(Asteriod a : asteriods)
  {
    for(Bullet b : bullets)
    {
      if((int)b.getX() >= a.getX() && (int)b.getX() <= (a.getX() +50) && (int)b.getY() >= a.getY() && (int)b.getY() <= a.getY()+a.size)
      {
        bullets.remove(b); 
        hit = true; 
        break;
      }
    }
    if(hit == true)
    {
      asteriods.remove(a);
      break; 
    }
  }
}
  

void loseCondition()
{
  for(Asteriod a : asteriods)
  {
    if(a.y >= 800)
    {
      fill(255, 0, 0);
      textSize(32);
      text("YOU LOSE", 200, 400); 

    }
  }
}

void winCondition()
{
  if (asteriods.size() == 0)
  {
      fill(0, 102, 153);
      textSize(32);
      text("YOU WIN", 200, 400); 
  }
    
}


void doubleAtomicSprocket() {
  noStroke();
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + fft.getBand(i)/2048;
    x[i] = x[i] + fft.getFreq(i)/2048;
    z[i] = z[i] + fft.getBand(i)/2048;
    angle[i] = angle[i] + fft.getFreq(i)/2000;
    rotateX(sin(angle[i]/2));
    rotateY(cos(angle[i]/2));
    rotateZ(tan(angle[i]));
    stroke(fft.getFreq(i)*19,fft.getBand(i)*191,fft.getBand(i)*190);
    fill(fft.getFreq(i)*18, fft.getBand(i)*168, fft.getBand(i)*30);
    pushMatrix();
    translate((x[i]+50)%width/3, (y[i]+50)%height/3, (z[i]+50)%width+height/9);
    box(fft.getBand(i)/20+fft.getFreq(i)/44);
    popMatrix();
  }
  popMatrix();
  noStroke();
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[i] = y[i] + fft.getBand(i)/2048;
    x[i] = x[i] + fft.getFreq(i)/2048;
    z[i] = z[i] + fft.getBand(i)/2048;
    angle[i] = angle[i] + fft.getFreq(i)/2000000000;
    rotateX(sin(angle[i]/2));
    rotateY(cos(angle[i]/2));
    rotateZ(tan(angle[i]));
    stroke(fft.getFreq(i)/19,fft.getBand(i)*191,fft.getBand(i)*190);
    fill(fft.getFreq(i)/18, fft.getBand(i)*168, fft.getBand(i)*30);
    pushMatrix();
    translate((x[i]+50)%width/3, (y[i]+50)%height/3, (z[i]+50)%width+height/9);
    box(fft.getBand(i)/20+fft.getFreq(i)/33);
    popMatrix();
  }
  popMatrix();

}
void stop()
{
  // No olvidar cerrar Minim con estas dos ultimas clases
  //jingle.close();
  minim.stop();

  super.stop();
}