/*---------------------------------------------------------------------------------------------------------------------

 *
 * Bouncy Bubbles  
 * based on code from Keith Peters. 
 * 
 * Multiple-object collision.
 * Taken from https://processing.org/examples/bouncybubbles.html
 * 
 * Written by Charlie Trovini & Sam Kaplan
 *

-----------------------------------------------------------------------------------------------------------------------

NEW PSUEDOCODE -- Rip-off Pac-Man  -- CURRENT

1. Obstacle-based game, touching balls kills player
2. Coins scattered around randomly with for statement
3. Collecting coins contributes to score
4. Collecting all coins adds +500 score and resets screen for new level
5. Power-up to increase movement speed
6. Title screen

PSUEDOCODE -- Rip-off Galaga  -- SCRAPPED

1. Player character controlled on screen dodging balls
2. Player character animated with jetpack when moving
3. Screen scroll
4. 3 HP + lives system
5. Player character has gun to explode balls to score points
6. Big balls divide into smaller ones when shot
7. Balls that are small enough explode without dividing
8. Balls display score given when exploded
9. Spawn balls with random color values
10. Redesigned balls to be bubbles
11. Short, quickly decaying smoke trail on jetpack
12. Animated background

---------------------------------------------------------------------------------------------------------------------*/

//  INITIALIZE

int numBalls = 18;
float spring = 0.75;
float gravity = 0.0;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

float moveSpeed = 10;

//  Coin Variables
int coinNum = 9;
int ScoreMath = 1;
int ScoreDisplay = 0;
Coin[] coins = new Coin[coinNum];

//  Player intergers
int player1x;
int player1y;
int player2x;
int player2y;
int playerd;
int Lives;

/*-------------------------------------------------------------------------------------------------------------------*/

//  SETUP

void setup() {
  
  size(1280, 720);
  noStroke();
  
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(40, 50), i, balls);
  }
  
  //  Populates Coin Array
  for (int i = 0; i < coinNum; i++) {
   coins[i] = new Coin(color(#ffeb16),random(width),random(height));
  }
  
  for (Ball ball : balls) {
    ball.moveInit();
  }
  
  //  Player interger setup
  player1x = width/12;
  player1y = height/6;
  player2x = width/8;
  player2y = height/4;
  playerd = 5;
  Lives = 5;
  
}  //  END OF SETUP

/*-------------------------------------------------------------------------------------------------------------------*/

//  DRAW

void draw() {
  
  background(0);
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  DRAW: Bouncy balls setup
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  DRAW: Player setup
  
  //  P1
  for (Ball p1 : balls) {
    p1.collide();
    p1.player1();
  }
  
  //  P2
  for (Ball p2 : balls) {
    p2.collide();
    p2.player2();
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  DRAW: Draw and Remove Coins
  for (int i = 0; i < coinNum; i++) {
  coins[i].displaycoin();
  coins[i].destroycoin();
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  DRAW: Score setup
  if (ScoreMath % 10 == 0){
    setup();
    ScoreMath += 91;
    ScoreDisplay += 91;
    Lives++;
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  DRAW: Text setup
  
  //  Formatting
  fill(255);
  textSize(width/50);
  
  //  Timer
  text("TIME", width/24, height/18);
  text(":", width/17, height/12);
  text(minute(), width/24, height/12);
  text(second(), width/16, height/12);
  
  //  Score
  text("SCORE", width*0.9, height/18);
  text(ScoreDisplay, width*0.9, height/12);
  
  //  Lives
  text("LIVES", width/2, height/18);
  text(Lives, width/2, height/12);
  
}  //  END OF DRAW

/*-------------------------------------------------------------------------------------------------------------------*/

//  COINS

//  Coin Class and Functions
class Coin {
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
   ellipse(cxpos,cypos,10,10);
   }
   void destroycoin(){
     float coindistance = sqrt((cxpos-player1x) * (cxpos-player1x) + (cypos-player1y) * (cypos-player1y));
     if (coindistance <=10){
       cxpos=-1000;
       cypos=-1000;
      
       ScoreMath++;
       ScoreDisplay++;
       println(ScoreMath);
     }
   }
}  //  END OF COINS

/*-------------------------------------------------------------------------------------------------------------------*/

//  BALLS & PLAYERS

class Ball {
  
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
  
  //  BALL: COLLISION
  
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
      if (dist(player1x, player1y, x, y) < diameter-25 || dist(player2x, player2y, x, y) < diameter-25 && Lives >= -1){
        player1x = width/12;
        player1y = height/6;
        player2x = width/8;
        player2y = height/4;
        Lives -= 1;
      }else if (Lives <= -1){
        setup();
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
    ellipse(x, y, diameter, diameter);
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  PLAYER: DISPLAY
  
  //  P1
  void player1() {
    fill(100, 255, 100);
    ellipse(player1x, player1y, playerd, playerd);
  }
  
  //  P2
  void player2() {
    fill(100, 100, 255);
    ellipse(player2x, player2y, playerd, playerd);
  }
  
/*-------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: INITIAL VELOCITY
  
  void moveInit() {
    vy += random(-1,1);
    vx += random(-1,1);
  }
  
}  //  END OF BALLS & PLAYERS

/*-------------------------------------------------------------------------------------------------------------------*/

//  PLAYER MOVEMENT

void keyPressed(){
  
  //  P1
  if (key == CODED){
    if (keyCode == DOWN){
      player1y += moveSpeed;
    }else if (keyCode == UP){
      player1y -= moveSpeed;
    }else if (keyCode == RIGHT){
      player1x += moveSpeed;
    }else if (keyCode == LEFT){
      player1x -= moveSpeed;
    }
  }
  
  //  P2
  if (key == 's' || key == 'S'){
    player2y += moveSpeed;
  }else if (key == 'w' || key == 'W'){
    player2y -= moveSpeed;
  }else if (key == 'd' || key == 'D'){
    player2x += moveSpeed;
  }else if (key == 'a' || key == 'A'){
    player2x -= moveSpeed;
  }
  
}  //  END OF PLAYER MOVEMENT

/*-------------------------------------------------------------------------------------------------------------------*/
