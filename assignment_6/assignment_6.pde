/*----------------------------------------------------------------------------------------------------------------------------------------------------------------

 * Diver
 * IMPORTANT: THE PROCESSING SOUND LIBRARY MUST BE INSTALLED FOR THIS PROGRAM TO FUNCTION!
 * 
 * Multiple-object collision bouncy balls adapted from https://processing.org/examples/bouncybubbles.html based on code from Keith Peters
 * Timer adapted from https://openprocessing.org/sketch/391986/
 * Music and sound effects adapted from https://freesound.org
 * 
 * Written by Charlie Trovini & Sam Kaplan

----------------------------------------------------------------------------------------------------------------------------------------------------------------*/

//  INITIALIZE

import processing.sound.*;

//  GSV variable
float pythagscale;

//  Ball variables
int numBalls = 18;
float gravity = 0.0;
float friction = -0.9;
float ballSize;  //  Defined in GSV
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
int Lives = 1500;
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

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/

//  SETUP

void setup() {
  
  /*  Resolution info:
      This program was built to scale properly to any 16:9 aspect ratio. Other aspect ratios will work but are not ideal. Test them at your own risk.
      1280x720 was the resolution used during development as the reference point of the program. As such, I have set 1280x720 as the default size.
      The resolution was increased to 1920x1080 during the project demo. This was done to produce a larger picture that would fill more screen space.
      Listed below are resolutions I have personally tested the program at. I reccommend using these to demonstrate the program's scaling functionality:
  size(512, 288);
  size(640, 360);
  size(1280, 720);
  size(1920, 1080);
  size(2112, 1188);
  */
  size(1280, 720);
  noStroke();  //  Outlines are icky
  
  //  Global Scaling Variable
  GSV();
  
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
  
  //  coinNum Score reset check
  if (Score > 0){
    coinNum = 9;
  }else{
    coinNum = 10;
    song.loop();
  }
  
}  //  END OF SETUP

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/

//  DRAW

void draw() {
  
  background(0,60,75);
  
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
    //  The line below adds lives every time you win:
    //Lives += 500;
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
  text("00", width/26, height/12);
  text(":", width/17, height/12);
  text(countDown, width/16, height/12);
  
  //  Score
  text("SCORE", width*0.9, height/18);
  text(Score, width*0.9, height/12);
  
  //  Kill player if timer reaches 0
  if (countDown == -1){
    Lives = -1;
    GameOver();
  }
  
}  //  END OF DRAW

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*  GLOBAL SCALING VARIABLE
    This variable is our scaling function, based on both width and height, which are both defined in setup.
    Because of this, it cannot be declared as a global variable and must be repeated throughout our code.
    This custom function was written in an effort to circumvent that, but it unfortunately does not work.
    Until now!*/

void GSV() {
  
  pythagscale = (sqrt((width*width + height*height)));
  ballSize = pythagscale/36.7;
  
}

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/

//  GAME OVER STATE

void GameOver() {
  
  /*  GAME OVER text — looks a little jank and was thus removed
  fill(255,255,255);
  textSize(width/24 + height/13.5);
  text("GAME OVER", width/3.55, height/2);*/
  die.play();
  Score = 0;
  Lives += 1501;
  setup();
  song.stop();
  
}  //  END OF GAME OVER STATE

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/
