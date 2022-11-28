class asteroid {
  float x, y, s, xSpeed, ySpeed;
  float rotation;
  PImage ast;
  
  //---------------------------------Asteroid Init----------------------------------
  //Loads larger 'asteroid' initially
  //Smaller 'sasteroid' loaded if large asteroid destroyed
  //Called 'sasteroid' as abrv of small asteroid, not because of its sassy attitude
  public asteroid(int j, float i, float c, float l){
    if (j == 0){
      ast = loadImage("asteroid.png");
      s = 70;
      int p = int(random(0,10));
      if (p < 5){ //Randomly spawns asteroid either off right or left of screen
        x = -75;
      } else{
        x = 810;
      }
      y = int(random(0, 800));
     } else {
      ast = loadImage("sasteroid.png");
      s = 30;
      x = i;
      y = c;
    }
    xSpeed = random(-l, l);
    ySpeed = random(-l, l);
    rotation = random(0, 360);
  }
  //--------------------------------End of init-------------------------------------
  
  //--------------------------------Display Method----------------------------------
  void display(){
    noStroke();
    noFill();
    pushMatrix();
    translate(x + (s/2), y + (s/2));
    rotate(degrees(rotation));
    imageMode(CORNER);
    image(ast, 0 - (s/2), 0 - (s/2));
    popMatrix();
  }
  //-------------------------------End of Display-----------------------------------
  
  //-------------------------------Update Method------------------------------------
  void update(){
    x = x + xSpeed;
    y = y + ySpeed;
    //-----------------------------X-Axis Wrap Around------------------------------
    if (x > 820){
      x = -70;
    }
    if (x < -80){
      x = 810;
    }
    //-----------------------------Y-Axis Wrap Around-------------------------------
    if (y > 810){
      y = -70;
    }
    if (y < -80){
      y = 800;
    }
  }
  //------------------------------End of Update-------------------------------------
  
}//End of asteroid class
