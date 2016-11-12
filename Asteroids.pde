class Asteriod
{
  int x; 
  int y=0; 
  int z;
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
  int getZ(){
  return this.z;
  
  }
  void setZ(int z)
  {
  this.z = z;
  }
  
  void display()
  {
    shape(enemy,x,y);
    
  }
  
  void move() 
  {
    y += speed; 
  }
  
}