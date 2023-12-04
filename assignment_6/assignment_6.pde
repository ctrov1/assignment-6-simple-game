/*---------------------------------------------------------------------------------------------------------------------

 *
 * Bouncy Bubbles  
 * based on code from Keith Peters. 
 * 
 * Multiple-object collision.
 * Bouncy balls adapted from https://processing.org/examples/bouncybubbles.html
 * Timer adapted from https://openprocessing.org/sketch/391986/
 * Sounds and music taken from freesound.org
 * 
 * Written by Charlie Trovini & Sam Kaplan
 * Coins, resolution scaling, 

---------------------------------------------------------------------------------------------------------------------*/

//  INITIALIZE

import processing.sound.*;

//  Ball variables
int numBalls = 18;
float spring = 1.5;
float gravity = 0.0;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

//  Coin variables
int coinNum = 10;
int Score = 0;
Coin[] coins = new Coin[coinNum];

//  Player variables
int player1x;
int player1y;
PShape p1_icon;
float p1hboxx;
float p1hboxy;
Player p1 = new Player();
/*  P2
int player2x;
int player2y;
PShape p2_icon;
float p2hboxx;
float p2hboxy;
Player p2 = new Player();*/
float playerd;
int Lives = 1000;
float moveSpeedY;
float moveSpeedX;

/*  Non-functional MoveBoth
boolean MoveP1Down = false;
boolean MoveP1Up = false;
boolean MoveP1Left = false;
boolean MoveP1Right = false;

boolean MoveP2Down = false;
boolean MoveP2Up = false;
boolean MoveP2Left = false;
boolean MoveP2Right = false;*/

//  Timer variables
int timer;
int timerStart;
int countDown;
int countDownStart;

//  SFX variables
SoundFile collect;
SoundFile nextLevel;
SoundFile song;
SoundFile die;

/*-------------------------------------------------------------------------------------------------------------------*/

//  SETUP

void setup() {
  
  //  Suggested aspect ratio: 16:9
  size(1280, 720);
  noStroke();
  
  //  Global Scaling Variable
  //GSV();
  float pythagscale = (sqrt((width*width + height*height)));
  float ballSize = pythagscale/36.7;
  
  //  Populates Bouncy Balls
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(i*(width/numBalls), random(height), ballSize, i, balls);
  }
  
  //  Populates Coin Array
  for (int i = 0; i < coinNum; i++) {
   coins[i] = new Coin(color(#ffeb16),random(width),random(height));
  }
  
  //  Ball movement
  for (Ball ball : balls) {
    ball.moveInit();
  }
  
  //  Player interger setup
  player1x = width/12;
  player1y = height/6;
  p1hboxx = width/32;
  p1hboxy = height/27.69231;
  /*  P2
  player2x = width/8;
  player2y = height/4;
  p2hboxx = width/32;
  p2hboxy = height/8.37209;*/
  playerd = pythagscale/100;
  moveSpeedY = height/144;
  moveSpeedX = width/256;
  
  //  P1 graphic
  p1_icon = createShape(GROUP);
  fill(255,255,255);
  PShape p1_outerquad = createShape(QUAD,width/49.23077,height/36,width/23.70370,height/36,width/26.12245,height/18,width/41.29032,height/18);
  fill(0,0,0);
  PShape p1_innerquad = createShape(QUAD,width/42.66667,height/32.72727,width/25.6,height/32.72727,width/27.82609,height/18.94737,width/37.64706,height/18.94737);
  fill(255,255,255);
  PShape p1_circle = createShape(ELLIPSE,width/32,height/24,width/106.66667,height/60);
  fill(221, 94, 221);
  PShape p1_topquad = createShape(QUAD,width/49.23077,height/36,width/23.70370,height/36,width/26.66667,height/60,width/40,height/60);
  p1_icon.addChild(p1_outerquad);
  p1_icon.addChild(p1_innerquad);
  p1_icon.addChild(p1_circle);
  p1_icon.addChild(p1_topquad);
  
  /*  P2 graphic
  p2_icon = createShape(GROUP);
  fill(255,255,255);
  PShape p2_outerquad = createShape(QUAD,width/49.23077,height/9,width/23.70370,height/9,width/26.12245,height/7.2,width/41.29032,height/7.2);
  fill(0,0,0);
  PShape p2_innerquad = createShape(QUAD,width/42.66667,height/8.78049,width/25.6,height/8.78049,width/27.82609,height/7.34694,width/37.64706,height/7.34694);
  fill(255,255,255);
  PShape p2_circle = createShape(ELLIPSE,width/32,height/8,width/106.66667,height/60);
  fill(255, 133, 25);
  PShape p2_topquad = createShape(QUAD,width/49.23077,height/9,width/23.70370,height/9,width/26.66667,height/10,width/40,height/10);
  p2_icon.addChild(p2_outerquad);
  p2_icon.addChild(p2_innerquad);
  p2_icon.addChild(p2_circle);
  p2_icon.addChild(p2_topquad);*/
  
  //  Timer
  timerStart = int(millis()/1000);
  countDown  = countDownStart;
  countDownStart = 15;
  
  //  SFX
  collect = new SoundFile(this, "collect.wav");
  nextLevel = new SoundFile(this, "nextLevel.wav");
  song = new SoundFile(this, "song.wav");
  die = new SoundFile(this, "die.wav");
  
  //  coinNum reset check
  if (Score > 0){
    coinNum = 9;
  }else{
    coinNum = 10;
    song.loop();
  }
  
}  //  END OF SETUP

/*-------------------------------------------------------------------------------------------------------------------*/

//  DRAW

void draw() {
  
  background(0);
  
  //  DRAW: Balls
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
  
  //  DRAW: Players
  p1.displayp1();
  //p2.displayp2();
  
  //  DRAW: Coins
  for (int i = 0; i < coinNum; i++) {
  coins[i].displaycoin();
  coins[i].destroycoin();
  }
  
  //  DRAW: Score
  if (Score % 10 == 0 && Score != 0){
    setup();
    Score += 91;
    Lives += 1000;
    nextLevel.play();
  }
  
  //  DRAW: Text
  //  Formatting
  fill(255);
  textSize(width/50);
  
  //  Timer
  timer = int(millis()/ 1000 - timerStart);     // counts up from the start time (0)
  countDown = int (countDownStart - timer);   // counts down from the start time (15)
  text("TIME", width/24, height/18);
  text("", width/24, height/12);
  text(":", width/17, height/12);
  text(countDown, width/16, height/12);
  
  //  Score
  text("SCORE", width*0.9, height/18);
  text(Score, width*0.9, height/12);
  
  //  Kill player if timer reaches 0
  if (countDown == -1){
    GameOver();
  }
}  //  END OF DRAW

/*-------------------------------------------------------------------------------------------------------------------*/

/*  GLOBAL SCALING VARIABLE  — Non-functional as custom function
    This variable is our scaling function, based on both width and height, it
    is repeated throughout the code because it can't be declared as a global
    variable because it uses width and height which are defined in setup
*/

void GSV() {
  
  float pythagscale = (sqrt((width*width + height*height)));
  float ballSize = pythagscale/36.7;
  
}

/*-------------------------------------------------------------------------------------------------------------------*/

//  GAME OVER STATE

void GameOver() {
  
  fill(255,255,255);
  textSize(width/24 + height/13.5);
  text("GAME OVER", width/3.55, height/2);
  Score = 0;
  Lives = 0;
  Lives += 1000;
  song.stop();
  die.play();
  setup();
  
}  //  END OF GAME OVER STATE

/*-------------------------------------------------------------------------------------------------------------------*/

//  COINS

//  Coin Class and Functions
class Coin {

  //  Global Scaling Variable
  //{
  //  GSV();
  //}
  float pythagscale = (sqrt((width*width + height*height)));
  
  color c;
  float cxpos;
  float cypos;
  
  
  Coin(color c_, float cxpos_, float cypos_) {
   c = c_;
   cxpos = cxpos_;
   cypos = cypos_;
  }
  
   void displaycoin() {
   fill(c);
   noStroke();
   ellipse(cxpos,cypos,pythagscale/90,pythagscale/90);
   }
   void destroycoin(){
     float coindistance = sqrt((cxpos-p1hboxx) * (cxpos-p1hboxx) + (cypos-p1hboxy) * (cypos-p1hboxy));
     if (coindistance <=pythagscale/70){
       cxpos=-10000;
       cypos=-10000;
       countDownStart += 2;
       Score++;
       collect.play();
     }
   }
}  //  END OF COINS

/*-------------------------------------------------------------------------------------------------------------------*/

//  BALLS

class Ball {
  
  //  Global Scaling Variable
  //{
  //  GSV();
  //}
  float pythagscale = (sqrt((width*width + height*height)));
  float ballSize = pythagscale/36.7;
  
  
  //  BALL: Interger setup
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: COLLISION (+ PLAYER)
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
      //  Player collision
      if (dist(p1hboxx, p1hboxy, x, y) < ballSize/1.25 && Lives >= -1){
        background(255,0,0);
        fill(255,255,255);
        text("MELTING!", width/2.1, height/18);
        text("0:", width/1.98, height/12);
        text(Lives, width/1.92, height/12);
        Lives -= 1;
      }else if (Lives <= -1){  //  Kill player when fully melted
        GameOver();
      }
    }
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: MOVEMENT
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: DISPLAY
  
  void display() {
    fill(255, 100, 100, 240);
    ellipse(x, y, ballSize, ballSize);
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: INITIAL VELOCITY
  
  void moveInit() {
    vy += random(-2,2);
    vx += random(-2,2);
  }
  
}  //  END OF BALLS

/*-------------------------------------------------------------------------------------------------------------------*/

//  PLAYERS

class Player {
  
  //  Player 1
  void displayp1() {
    if (keyCode == DOWN && keyPressed == true){
      p1hboxy += moveSpeedY;
      p1_icon.translate(0,height/144);
      //MoveP1Down = true;
    }
    if (keyCode == UP && keyPressed == true){
      p1hboxy -= moveSpeedY;
      p1_icon.translate(0,-height/144);
      //MoveP1Up = true;
    }
    if (keyCode == RIGHT && keyPressed == true){
      p1hboxx += moveSpeedX;
      p1_icon.translate(width/256,0);
      //MoveP1Right = true;
    }
    if (keyCode == LEFT && keyPressed == true){
      p1hboxx -= moveSpeedX;
      p1_icon.translate(-width/256,0);
      //MoveP1Left = true;
    }/*else{
      MoveP1Down = false;
      MoveP1Up = false;
      MoveP1Right = false;
      MoveP1Left = false;
    }*/
    //  P1 Hitbox
    ellipse(p1hboxx,p1hboxy,width/53.33333,height/30);
    //  P1 Player Icon
    shape(p1_icon);
  }
  
  /*  Player 2
  void displayp2() {
    if (key == 's' && keyPressed == true || key == 'S' && keyPressed == true){
    p2hboxy += moveSpeedY;
    p2_icon.translate(0,height/144);
    MoveP2Down = true;
  }else if (key == 'w' && keyPressed == true || key == 'W' && keyPressed == true){
    p2hboxy -= moveSpeedY;
    p2_icon.translate(0,height/144);
    MoveP2Up = true;
  }else if (key == 'd' && keyPressed == true || key == 'D' && keyPressed == true){
    p2hboxx += moveSpeedX;
    p2_icon.translate(width/256,0);
    MoveP2Right = true;
  }else if (key == 'a' && keyPressed == true || key == 'A' && keyPressed == true){
    p2hboxx -= moveSpeedX;
    p2_icon.translate(width/256,0);
    MoveP2Left = true;
  }else{
    MoveP2Down = false;
    MoveP2Up = false;
    MoveP2Right = false;
    MoveP2Left = false;
  }
    //  P2 Hitbox
    ellipse(p2hboxx,p2hboxy,width/53.33333,height/30);
    //  P2 Player Icon
    shape(p2_icon);
  }
  
  void MoveBoth() {
    if (MoveP2Down == true && MoveP1Down == true){
      player2y += moveSpeed;
      player1y += moveSpeed;
    }else if (MoveP2Up == true && MoveP1Up == true){
      player2y -= moveSpeed;
      player1y -= moveSpeed;
    }else if (MoveP2Right == true && MoveP1Right == true){
      player2x += moveSpeed;
      player1x += moveSpeed;
    }else if (MoveP2Left == true && MoveP1Left == true){
      player2x -= moveSpeed;
      player1x -= moveSpeed;
    }
  }*/
  
}  //  END OF PLAYERS

/*-------------------------------------------------------------------------------------------------------------------*/
