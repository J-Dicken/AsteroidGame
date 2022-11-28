//Currently using P2D render which will run program on GPU
//If running this on machine without GPU, delete P2D from size attribute in setup
//Only noticeable difference ive found is on Hard, it starts to get jittery

menu t;
player p;
ArrayList<asteroid> ast = new ArrayList<asteroid>();//List for main asteroids
ArrayList<asteroid> sAst = new ArrayList<asteroid>();//List for smaller, split asteroids
ArrayList<projectile> proj = new ArrayList<projectile>();//List for bullets
ArrayList<power> pwrUp = new ArrayList<power>();//List for power ups

int diff; //Originally intended for difficulty but now just acts as score multiplier
int oldCount = -60; //Frame timer for shoot cooldown
int respawnTimer = 0; //Frame timer for respawn immunity
int flashTimer = 1; //Frame timer for respawn flash animation
int shootSpeed = 0; //Goes into HUD method for display purposes
int shootTimer = 0; //Frame timer for shoot speed power up
int invunrable = 0; //Goes into HUD method for display purposes
int invTimer = 0; //Frame timer for invunrable power up
boolean mouseReset = false; //Prevents multiple steps through menu in one click
boolean gameOver = false; 
boolean respawn = false; //Limits game logic when true


int maxAst; //Max number of large asteroids
int maxPwr; //Max number of power ups on screen at a time
float maxAstSpeed; // Max speed of an asteroid, based on difficulty

void setup(){
  size(800, 800, P2D);
  t = new menu();
  p = new player();
}

void draw(){
  if (gameOver){
    t.gameOver(p.destroyed, p.score);
  }
  else if (t.state == 3){
    //--------------------------------------Beginning of gameplay logic-------------------------------------
    background(#000000);
    populateAst();
    //--------------------------------------Power Up logic--------------------------------------------------
    if (frameCount % (600 * diff) == 0){ //Chance to spawn power up based on diff
      //Easy - Chance every 10 seconds
      //Medium - Chance every 20 seconds
      //Hard - Chance every 50 seconds
      int dice = int(random(0, 101)); //Gives number between 0 - 100
      if (dice >= (100 - (10 / diff))){
        //Easy - 10% chance of spawn
        //Medium - 5% chance of spawn
        //Hard - 2% chance of spawn
        if (pwrUp.size() < maxPwr){
          pwrUp.add(new power());
        }
      }
    }
    //------------------------------------Power up reset logic--------------------------------------------
    if (shootSpeed == 1){
      if (frameCount - shootTimer > 300){
        shootSpeed = 0;
      }
    }
    if (invunrable == 1){
      if (frameCount - invTimer > 300){
        invunrable = 0;
      }
    }
    //--------------------------------------End of power up logic-------------------------------------------
    //--------------------------------------Asteroid Display Loop---------------------------------------
    for (asteroid e : ast){
      e.update();
      e.display();
    }
    
    for (asteroid e : sAst){
      e.update();
      e.display();
    }
    //--------------------------------------End of Asteroid Display-----------------------------------------
    //--------------------------------------Player draw functions-------------------------------------------
    if (!respawn){
      p.update();
      p.display(invunrable);
    } else{
      if ((frameCount - respawnTimer) >= 180){
        respawn = false;
      }
      if (frameCount % 30 == 0){
        flashTimer = flashTimer * -1;
      }
      if (flashTimer == 1){
        p.display(invunrable);
      }
    }
    p.HUD(shootSpeed, invunrable);
    //--------------------------------------End of player display---------------------------------
    //--------------------------------------Projectile Display Loop--------------------------------------
    for (projectile p : proj){ //Local variable p for enhanced loop, not player ID
      p.update();
      p.display();
    }
    projOff();
    //--------------------------------------End of Projectile Display-------------------------------
    //-------------------------------------Power up Display-------------------------------------------------
    for (power p : pwrUp){ //Local variable p for enhanced loop, not player ID
      p.update();
      p.display();
    }
    //-------------------------------------Collision Logic-------------------------------------------------
    projCollision();
    if (!respawn){
      if (invunrable == 0){
        shipCollision();
      }
      pwrCollision();
    }
    //--------------------------------------End of Collision Logic----------------------------------------
  } else{
    t.display();
  }
}//----------------------------------------End of Draw Function---------------------------------------

//-----------------------------Projectile & Asteroid Collision---------------------------------------------
void projCollision(){
  for (int j = 0; j < proj.size(); j++){
    float x1 = proj.get(j).x;
    float y1 = proj.get(j).y;
    
    for (int i = 0; i < ast.size(); i++){
      float x = ast.get(i).x;
      float y = ast.get(i).y;
      float s = ast.get(i).s;
      if ((x1 >= x) && (x1 <= (x + s)) && (y1 >= y) && (y1 <= (y + s))){
        aSplit(x, y);
        ast.remove(i);
        p.destroyed++;
        p.score += diff*2;
        if (proj.size() > 1){
          proj.remove(j);
        }
        else if (proj.size() == 1){
          proj.remove(0);
        }
        break;
      }
    }
    for (int i = 0; i < sAst.size(); i++){
      float x = sAst.get(i).x;
      float y = sAst.get(i).y;
      float s = sAst.get(i).s;
      if ((x1 >= x) && (x1 <= (x + s)) && (y1 >= y) && (y1 <= (y + s))){
        sAst.remove(i);
        p.destroyed++;
        p.score += diff;
        if (proj.size() > 1){
          proj.remove(j);
        }
        else if (proj.size() == 1){
          proj.remove(0);
        }
        break;
      }
    }
  }
}
//--------------------------------End of proj collision----------------------------------------

//--------------------------------Power up collision-------------------------------------------
void pwrCollision(){
  for (int i = 0; i < pwrUp.size(); i++){
    int x = pwrUp.get(i).x;
    int y = pwrUp.get(i).y;
    if ((p.x >= x) && (p.x <= x + 80) && (p.y >= y) && (p.y <= y + 70)){
      switch(pwrUp.get(i).type) {
        case 0:
          p.lives++;
          break;
        case 1:
          shootSpeed = 1;
          shootTimer = frameCount;
          break;
        case 2:
          invunrable = 1;
          invTimer = frameCount;
          break;
      }
      pwrUp.remove(i);
    }
  }
}
//---------------------------------End of power collision---------------------------------------

//---------------------------------Asteroid and Ship collision------------------------------------
void shipCollision(){
  //First make sure ship is on screen to avoid off screen collision
  if ((p.x > 0) && (p.x < width) && (p.y > 0) && (p.y < height)){
    //Loop through large asteroids
    for (int i = 0; i < ast.size(); i++){
      float x = ast.get(i).x;
      float y = ast.get(i).y;
      float s = ast.get(i).s;
      if ((p.x >= x) && (p.x <= x + s) && (p.y >= y) && (p.y <= y + s)){
        //print("Player hit");      //Just to check it works
        if (p.lives > 1){
          p.lives--;
          p.x = 400;
          p.y = 400;
          p.rotation = 0;
          p.xSpeed = 0;
          p.ySpeed = 0;
          p.velocity = 0;
          respawn = true;
          respawnTimer = frameCount;
          break;
        } else{
          gameOver = true;
          t.state = 4;
          break;
        }
      }
    }
    //Loop through small asteroids
    for (int i = 0; i < sAst.size(); i++){
      float x = sAst.get(i).x;
      float y = sAst.get(i).y;
      float s = sAst.get(i).s;
      if ((p.x >= x) && (p.x <= x + s) && (p.y >= y) && (p.y <= y + s)){
        //print("Player hit");      //Just to check it works
        if (p.lives > 1){
          p.lives--;
          p.x = 400;
          p.y = 400;
          p.rotation = 0;
          p.xSpeed = 0;
          p.ySpeed = 0;
          p.velocity = 0;
          respawn = true;
          respawnTimer = frameCount;
          break;
        } else{
          gameOver = true;
          t.state = 4;
          break;
        }
      }
    }
  }
}
//---------------------------------End of Ship Collision---------------------------------------

//----------------------------Function to fill asteroid list-----------------------------------
void populateAst(){
  if(ast.size() < maxAst){
    ast.add(new asteroid(0, 0.0, 0.0, maxAstSpeed));
  }
}
//-----------------------------------End of populateAst----------------------------------------

//------------------------------Function to remove offscreen projectiles-----------------------
void projOff(){
  for (int j = 0; j < proj.size(); j++){
    float x = proj.get(j).x;
    float y = proj.get(j).y;
    if ((x < -100) || (x > 900) || (y < -100) || (y > 900)){
      if (proj.size() > 1){
          proj.remove(j);
        }
        else if (proj.size() == 1){
          proj.remove(0);
        }
    }
  }
}
//---------------------------------End of proj remove------------------------------------------

//----------------------------------Asteroid Split Function------------------------------------
void aSplit(float q, float p){
  float i = q;
  float c = p;
  sAst.add(new asteroid(1, i, c, maxAstSpeed/2));
  sAst.add(new asteroid(1, i, c, maxAstSpeed/2));
}
//----------------------------------End of Asteroid Split--------------------------------------

void mousePressed(){
  //Quick function to stop it rushing through menu select and bugging
  if (mouseButton == LEFT){
    mouseReset = false;
  }
}

void mouseReleased(){
  if (mouseButton == LEFT){
    //-------------------------------------Menu Navigation Logic-------------------------------
    //-------------------------------------Title Page Logic------------------------------------
    if ((t.state == 0) && (!mouseReset)){
      //----------------------------------Play Game--------------------------------------------
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 340) && (mouseY < 400)){
        t.state = 1;
        mouseReset = true;
      }
      //----------------------------------How to Play------------------------------------------
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 400) && (mouseY < 460)){
        t.state = 2;
        mouseReset = true;
      }
      //------------------------------------Exit-----------------------------------------------
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 460) & (mouseY <= 520)){
        exit();
      }
    }
    //-------------------------------------End of title Logic----------------------------------
    //-------------------------------------Difficulty Select Logic-----------------------------
    if ((t.state == 1) && (!mouseReset)){
      //-----------------------------------Easy------------------------------------------------
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 340) && (mouseY < 400)){
        maxAst = 5;
        maxPwr = 3;
        maxAstSpeed = 2.0;
        t.state = 3;
        p.lives = 5;
        diff = 1;
      }
      //---------------------------------Medium------------------------------------------------
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 400) && (mouseY < 460)){
        maxAst = 10;
        maxPwr = 2;
        maxAstSpeed = 4.0;
        t.state = 3;
        p.lives = 3;
        diff = 2;
      }
      //----------------------------------Hard-------------------------------------------------
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 460) && (mouseY < 520)){
        maxAst = 20;
        maxPwr = 1;
        maxAstSpeed = 5.0;
        t.state = 3;
        p.lives = 1;
        diff = 5;
      }       //<>//
    }
    //----------------------------------End of Difficulty Logic--------------------------------
    //-----------------------------------Pilot training logic---------------------------------------
    if (t.state == 2){
      if ((mouseX >= 10) && (mouseX <= 130) && (mouseY >= 750) && (mouseY <= 800) && (t.page != 1)){
        t.page--;
      }
      if ((mouseX >= 720) && (mouseX <= 790) && (mouseY >= 750) && (mouseY<= 800) && (t.page < 6)){
        t.page++;
      }
      if ((mouseX >= 400) && (mouseX <= 470) && (mouseY >= 750) && (mouseY <= 800)){
        t.state = 0;
      }
    }
    //----------------------------------Game Over Screen Logic---------------------------------
    if (t.state == 4){
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 400) && (mouseY < 460)){
        t.state = 1;
        gameOver = false;
        p.x = 400;
        p.y = 400;
        p.rotation = 0;
        p.xSpeed = 0;
        p.ySpeed = 0;
        p.velocity = 0;
        p.score = 0;
        p.destroyed = 0;
        ast.clear();
        sAst.clear();
      }
      if ((mouseX >= 134) && (mouseX <= 666) && (mouseY >= 460) && (mouseY <= 520)){
        exit();
      }
    }
    //----------------------------------Projectile Logic---------------------------------------
    if (t.state == 3){
      int x = 60;
      if (shootSpeed == 1){
        x = 30;
      }
      if ((frameCount - oldCount) >= x){
        proj.add(new projectile(p.x, p.y, p.rotation));
        oldCount = frameCount;
      }
    }
  }
}

//--------------------------------------Player Control Logic-----------------------------------
void keyPressed(){  
  if (keyCode == 'W'){
    p.speedUp = true;
  }
  
  if (keyCode == 'A'){
    p.turnLeft = true;
  }
  
  if (keyCode == 'D'){
    p.turnRight = true;
  }  
}

void keyReleased(){
  if (keyCode == 'W'){
    p.speedUp = false;
    p.slow = true;
    p.lRotation = p.rotation;
  }
  
  if (keyCode == 'A'){
    p.turnLeft = false;
  }
  
  if (keyCode == 'D'){
    p.turnRight = false;
  }
}
//--------------------------------------End of player control logic----------------------------
