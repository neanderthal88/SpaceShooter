
class powerup {
  public float x,y;
  public float radius;
  public boolean collision;
  public int type;
  public int ticks=300;
  
  private color[] cols=new color[]{
    color(255),
    color(255,0,0),
    color(0,0,255),
    color(0,255,255),
    color(255,255,0)
  };
  
  public powerup() {
    x=random(0,4);
    y=random(0,4);
    radius=40.0;
    collision=false;
    this.type=(int)random(0,5);
    this.ticks=255; // last 3 secs
  }
    
  public void onFrame() {
    if (ticks>0) ticks-=1;
  }
  
  public void draw() {
    if (mag(x-px,y-py)<radius) collision=true;
    if (ticks>0) {
      ellipseMode(CENTER);
      fill(cols[type]);
      ellipse(x,y,radius,radius);
      fill(0);
      ellipse(x,y,radius-20,radius-20);
    }
  }
 
}