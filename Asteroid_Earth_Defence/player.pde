class player {
  float x, y, xSpeed, ySpeed, maxV, velocity, rotation, lRotation;
  int lives;
  int score;
  int destroyed;
  boolean slow = false;
  boolean speedUp = false;
  boolean turnLeft = false;
  boolean turnRight = false;
  boolean respawn = false;
  PFont font;
  
  
  //----------------------------------Player Init------------------------------------  
  public player(){
    font = createFont("aliee13.ttf", 32);
    rotation = 0;
    xSpeed = 0;
    ySpeed = 0;
    maxV = 3;
    x = width/2;
    y = height/2;
  }
  //--------------------------------End of Init--------------------------------------
  
  //--------------------------------Display Method----------------------------------- 
  void display(int p){
    fill(#FFFFFF);
    stroke(#FFFFFF);
    pushMatrix();
    translate(x, y);
    rotate(radians(rotation));
    triangle(-10, 10, 0, -10, 10, 10);
    if (p == 1){
      stroke(#FFF80F);
      noFill();
      ellipseMode(CENTER);
      circle(0, 3, 50);
    }
    if (speedUp){
      fill(#FA9D23);
      noStroke();
      triangle(-7, 10, 0, 30, 7, 10);
      fill(#FFFCA2);
      triangle(-6, 10, 0, 25, 6, 10);
    }
    popMatrix();
  }
  //--------------------------------End of display-----------------------------------
  
  //--------------------------------Update Method------------------------------------
  void update(){
    if (speedUp){
      slow = false;
      if (velocity < maxV){
        velocity += 0.1;
      } else{
        velocity = maxV;
      }
    }
    
    if (turnLeft){
      p.rotation += -4;
    }
    
    if (turnRight){
      p.rotation += 4;
    }
    //This stops the ship from turning along a path rather than on its current
    //trajectory when there is no forward input
    if (!slow){
      xSpeed = velocity * (sin(radians(rotation)));
      ySpeed = velocity * -(cos(radians(rotation)));
    } else{
      xSpeed = velocity * (sin(radians(lRotation)));
      ySpeed = velocity * -(cos(radians(lRotation)));
    }
    x += xSpeed;
    y += ySpeed;
    edges();
    if (slow){
      slowDown();
    }
  }
  //--------------------------------End of update------------------------------------
  
  //--------------------------------HUD Method--------------------------------------
  //Seperate method from display to show information such as lives and score
  void HUD(int p, int q){
    textFont(font);
    fill(#FFFFFF);
    textAlign(LEFT);
    text("Lives: " + lives, 10, 790);
    if (p == 1){
      text("S", 10, 750);
    }
    if (q == 1){
      text("I", 40, 750);
    }
    textAlign(CENTER);
    text("Destroyed: " + destroyed, 400, 790);
    textAlign(RIGHT);
    text("Score: " + score, 790, 790);
  }
  //--------------------------------Screen Wrap Method-------------------------------
  void edges(){
    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y > height) y = 0;
    if (y < 0) y = height;
  }
  //-------------------------------End of Screen Wrap--------------------------------
  
  //-------------------------------Deceleration Method-------------------------------
  void slowDown(){
    if (velocity > 0){
      velocity -= 0.05;
    } else{
      velocity = 0;
    }
  }
  //------------------------------End of Deceleration--------------------------------
}//End of player class
