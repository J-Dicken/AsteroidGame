class menu{
  int state = 0; //Used to control which menu item to display
  int page = 1; //Used to control which page of Pilot training to display
  PImage title;
  PImage page1, page2, page3, page4, page5, page6;
  PImage ast;
  PImage speed;
  PImage invunrable;
  PImage diffSel;
  PImage life;
  PFont font;
  
  int x2 = 0;//Used for pilot training animation
  int y2 = 0;//Page 2 pilot training animation
  int y3 = 0;//Page 3 pilot training animation
  int y4 = -220;//Page 4 pilot training animation
  float rotation = 0;//Page 2 pilot training animation
  int anim = 0;//Used to cycle page 2 animation
  int anim2 = 0;//Used to cycle page 4 animation
  
  public menu(){
    title = loadImage("title.png");
    diffSel = loadImage("diffsel.png");
    page1 = loadImage("page1.png");
    page2 = loadImage("page2.png");
    page3 = loadImage("page3.png");
    page4 = loadImage("page4.png");
    page5 = loadImage("page5.png");
    page6 = loadImage("page6.png");
    speed = loadImage("bulletspeed.png");
    life = loadImage("life.png");
    invunrable = loadImage("invunrable.png");
    ast = loadImage("asteroid.png");
    font = createFont("aliee13.ttf", 64);
  }
  
  void display(){
    if (state == 0){
      title();
    }
    if (state == 1){
      difficulty();
    }
    if (state == 2){
      pilotTraining(page);
    }
  }
  
  void title(){
    int x, y;
    x = 270;
    fill(#FFFFFF);
    textSize(64);
    textFont(font);
    image(title, 0, 0);
    textAlign(CENTER);
    text("Asteroid", 134, 24, 532, 136);
    text("Earth Defence", 134, 104, 532, 136);
    textSize(32);
    text("Play Game", 134, 340, 532, 136);
    text("Pilot Training", 134, 400, 532, 136);
    text("Exit", 134, 460, 532, 136);
    if ((mouseY >= 0) && (mouseY < 400)){
      y = 355;
    }
    else if ((mouseY >= 400) && (mouseY < 460)){
      y = 415;
    }
    else{
      y = 475;
    }
    triangle(x, y, x - 10, y - 10, x - 10, y + 10);
    triangle(x + 260, y, x + 270, y - 10, x + 270, y + 10);
  }
  
  void difficulty(){
    int x, y;
    x = 270;
    background(#000000);
    textFont(font);
    text("Select", 134, 24, 532, 136);
    text("Difficulty", 134, 104, 532, 136);
    textSize(32);
    textAlign(CENTER);
    text("Easy", 134, 340, 532, 136);
    text("Medium", 134, 400, 532, 136);
    text("Hard", 134, 460, 532, 136);
    if ((mouseY >= 0) && (mouseY < 400)){
      y = 355;
    }
    else if ((mouseY >= 400) && (mouseY < 460)){
      y = 415;
    }
    else{
      y = 475;
    }
    triangle(x, y, x - 10, y - 10, x - 10, y + 10);
    triangle(x + 260, y, x + 270, y - 10, x + 270, y + 10);
  }
  
  void pilotTraining(int p){
    background(#000000);
    switch(p){
      case 1:
        imageMode(CORNER);
        image(page1, 0, 0);
        textAlign(LEFT);
        text("Previous", 10, 790);
        textAlign(CENTER);
        text("Menu", 400, 790);
        textAlign(RIGHT);
        text("Next", 790, 790);
        pushMatrix();
        imageMode(CENTER);
        translate(400, 0);
        image(ast, 200, 200);
        image(ast, 100, 100);
        image(ast, 100, 300);
        image(ast, 345, 80);
        popMatrix();
        break;
      case 2:
        imageMode(CORNER);
        image(page2, 0, 0);
        fill(#FFFFFF);
        textAlign(LEFT);
        text("Previous", 10, 790);
        textAlign(CENTER);
        text("Menu", 400, 790);
        textAlign(RIGHT);
        text("Next", 790, 790);
        pushMatrix();
        translate(600, 200);
        rotate(radians(rotation));
        triangle(x2-10, y2+10, x2, y2-10, x2+10, y2+10);
        if (anim == 0){
          fill(#FA9D23);
          noStroke();
          triangle(x2-7, y2+10, x2, y2+30, x2+7, y2+10);
          fill(#FFFCA2);
          triangle(x2-6, y2+10, x2, y2+25, x2+6, y2+10);
          y2--;
          if (y2 <= -180){
            anim = 1;
            y2 = 0;
          }
        }
        else if (anim == 1){
          rotation--;
          if (rotation == -90){
            anim = 2;
            rotation = 0;
          }
        } else{
          rotation++;
          if (rotation == 90){
            anim = 0;
            rotation = 0;
          }
        }
        popMatrix();
        break;
      case 3:
        imageMode(CORNER);
        image(page3, 0, 0);
        fill(#FFFFFF);
        stroke(#FFFFFF);
        textAlign(LEFT);
        text("Previous", 10, 790);
        textAlign(CENTER);
        text("Menu", 400, 790);
        textAlign(RIGHT);
        text("Next", 790, 790);
        pushMatrix();
        translate(600, 200);
        triangle(-10, 10, 0, -10, 10, 10);
        line(x2, y3, x2, y3-10);
        if (y3 > -190){
          y3--;
        } else{
          y3 = 0;
        }
        popMatrix();
        break;
      case 4:
        imageMode(CORNER);
        image(page4, 0, 0);
        fill(#FFFFFF);
        textAlign(LEFT);
        text("Previous", 10, 790);
        textAlign(CENTER);
        text("Menu", 400, 790);
        textAlign(RIGHT);
        text("Next", 790, 790);
        pushMatrix();
        translate(600, 200);
        //Outer ring
        noFill();
        beginShape();
        vertex(x2 + 60, y4);
        vertex(x2 + 20, y4);
        vertex(x2, y4 + 35);
        vertex(x2 + 20, y4 + 70);
        vertex(x2 + 60, y4 + 70);
        vertex(x2 + 80, y4 + 35);
        endShape(CLOSE);        
        //Inner ring
        beginShape();
        vertex(x2 + 55, y4 + 9);
        vertex(x2 + 25, y4 + 9);
        vertex(x2 + 10, y4 + 35);
        vertex(x2 + 25, y4 + 61);
        vertex(x2 + 55, y4 + 61);
        vertex(x2 + 70, y4 + 35);
        endShape(CLOSE);
        imageMode(CENTER);
        if (anim2 == 0){
          image(life, x2 + 40, y4 + 35);
          y4++;
          if (y4 == 0){
            anim2 = 1;
            y4 = -220;
          }
        }
        else if (anim2 == 1){
          image(speed, x2 + 40, y4 + 35);
          y4++;
          if (y4 == 0){
            anim2 = 2;
            y4 = -220;
          }
        } else{
          image(invunrable, x2 + 40, y4 + 35);
          y4++;
          if (y4 == 0){
            anim2 = 0;
            y4 = -220;
          }
        }
        popMatrix();
        break;
      case 5:
        imageMode(CORNER);
        image(page5, 0, 0);
        image(diffSel, 400, 0);
        textAlign(LEFT);
        text("Previous", 10, 790);
        textAlign(CENTER);
        text("Menu", 400, 790);
        textAlign(RIGHT);
        text("Next", 790, 790);
        break;
      case 6:
        imageMode(CORNER);
        image(page6, 0, 0);
        textAlign(LEFT);
        text("Previous", 10, 790);
        textAlign(CENTER);
        text("Menu", 400, 790);
        textAlign(RIGHT);
        text("Next", 790, 790);
        break;
    }
  }
  
  void gameOver(int p, int q){
    int x, y;
    x = 270;
    background(#000000);
    textFont(font);
    text("Game", 134, 24, 532, 136);
    text("Over", 134, 104, 532, 136);
    textSize(32);
    textAlign(CENTER);
    text("Play Again", 134, 400, 532, 136);
    text("Exit", 134, 460, 532, 136);
    textSize(16);
    text("Asteroids Destroyed: " + p, 134, 520, 532, 136);
    text("Score: " + q, 134, 550, 532, 136);
    if (mouseY < 460){
      y = 415;
    }
    else{
      y = 475;
    }
    fill(#FFFFFF);
    triangle(x, y, x - 10, y - 10, x - 10, y + 10);
    triangle(x + 260, y, x + 270, y - 10, x + 270, y + 10);
  }
 
}//End of menu class
