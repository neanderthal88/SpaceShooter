class Bullet//bullet class
{
  int x;
  int y;
  int speed;
  Bullet(int x, int y)
  {
    this.x = x; 
    this.y = y; 
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
    
    
    
    stroke(255);
    point(x,y);
  }
  void move()
  {
    y -= 2;
  }
}