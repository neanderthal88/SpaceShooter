class SpaceShip
{
  int x;
  int y; 
  int player;
  
  SpaceShip(int x, int y, int player)
  {
    this.x = x; 
    this.y = y; 
    this.player = player; 
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
    if(player == 1)
    {
      fill(0,255,0);
    }
    else
    {
      fill(255,255,0); 
    }
    noStroke(); 
    rect(x, y, 50, 50);
  }
  
}