class power{
  public int ticks=300; // frames left till deactivation, default 3 secs
  public int type=999;
  public power() {
    activate();
  }
  public void activate() {;}; // called when powerup starts
  public void onFrame() {;}; // called each frame while in place
  public void deactivate() {;}; // called when powerup times out
}