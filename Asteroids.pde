class Asteriod
{
  int x; 
  int y=0; 
  int speed; 
  int size; 
  Asteriod(int x, int speed, int size)
  {
    this.x = x; 
    this.speed = speed; 
    this.size = size; 
  }
    //getter and setters 
  int getX()
  {
    return this.x; 
  }
  
  void setX(int x)
  {
    this.x = x; 
  }
  
  int getY()
  {
    return this.y; 
  }
  
  void setY(int y)
  {
    this.y = y; 
  }
  
  void display()
  {
    image(enemy,x,y);
    enemy.resize(0,40);
  }
  
  void move() 
  {
    y += speed; 
  }
  
}