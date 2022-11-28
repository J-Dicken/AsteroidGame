class power{
  int x, y;
  float xSpeed, ySpeed;
  int type;
  
  PImage speed;
  PImage invunrable;
  PImage life;
  //------------------------------Power Up Init-------------------------------------
  public power(){
    speed = loadImage("bulletspeed.png");
    life = loadImage("life.png");
    invunrable = loadImage("invunrable.png");
    xSpeed = random(1, 5);
    ySpeed = random(1, 5);
    x = int(random(-100, 900));
    type = int(random(0, 3));
    int z = int(random(0, 11));
    if (z >= 5){
      y = 900;
    } else{
      y = -100;
    }
  }
 //--------------------------------End of init-------------------------------------- 
 //--------------------------------Display Method---------------------------------- 
  void display(){
    stroke(#FFFFFF);
    noFill();
    strokeWeight(2);
    
    //Outer ring
    beginShape();
    vertex(x + 60, y);
    vertex(x + 20, y);
    vertex(x, y + 35);
    vertex(x + 20, y + 70);
    vertex(x + 60, y + 70);
    vertex(x + 80, y + 35);
    endShape(CLOSE);
    
    //Inner ring
    beginShape();
    vertex(x + 55, y + 9);
    vertex(x + 25, y + 9);
    vertex(x + 10, y + 35);
    vertex(x + 25, y + 61);
    vertex(x + 55, y + 61);
    vertex(x + 70, y + 35);
    endShape(CLOSE);
    imageMode(CENTER);
    switch(type){
      case 0:
          //Lives
          image(life, x + 40, y + 35);
          break;
        case 1:
          //Shoot speed
          image(speed, x + 40, y + 35);
          break;
        case 2:
          //Invunrable
          image(invunrable, x + 40, y + 35);
          break;
    }
  }
 //--------------------------------End of Display Method---------------------------
 //---------------------------------Start of Update Method-------------------------
  void update(){
    x += xSpeed;
    y += ySpeed;
    
    //-----------------------------X-Axis Wrap Around------------------------------
    if (x > 1000){
      x = -70;
    }
    if (x < -200){
      x = 810;
    }
    //-----------------------------Y-Axis Wrap Around-------------------------------
    if (y > 1000){
      y = -70;
    }
    if (y < -200){
      y = 800;
    }
  }
}// End of power class
