class projectile{
  float x, y, speed, rotation;
  int s;
  
  //------------------------------Projectile Init-----------------------------------
  public projectile(float x1, float y1, float rot){
    x = x1;
    y = y1;
    speed = 6;
    rotation = rot;
    s = 10;
  }
  //------------------------------End of Init---------------------------------------
  
  //------------------------------Display Method------------------------------------
  void display(){
    stroke(#FFFFFF);
    strokeWeight(2);
    line(x, y, x + (s * (sin(radians(rotation)))), y + (s * -(cos(radians(rotation)))));
  }
  //-----------------------------End of Display-------------------------------------
  
  //-----------------------------Update Method--------------------------------------
  void update(){
    x = x + (speed * (sin(radians(rotation))));
    y = y + (speed * -(cos(radians(rotation))));
  }
  //-----------------------------End of update--------------------------------------
}//End of projectile class
