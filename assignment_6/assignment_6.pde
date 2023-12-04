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
