/*-----------------------------------------------------------------------------------------------

 *
 * Bouncy Bubbles  
 * based on code from Keith Peters. 
 * 
 * Multiple-object collision.
 * Taken from https://processing.org/examples/bouncybubbles.html
 * 
 * Written by Charlie Trovini & Sam Kaplan
 *

-------------------------------------------------------------------------------------------------

NEW PSUEDOCODE -- Rip-off Pac-Man  -- CURRENT

1. Obstacle-based game, touching balls kills player
2. Coins scattered around randomly with for statement
3. Collecting coins contributes to score
4. Collecting all coins adds +500 score and resets screen for new level

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

-----------------------------------------------------------------------------------------------*/

int numBalls = 18;
float spring = 0.25;
float gravity = 0.0;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

int player1x = width/2;
int player1y = height/2;
int player2x = width/4;
int player2y = height/4;
int playerd = 5;
float moveSpeed = 10;

//Coin Variables
int coinNum = 10;
int Score = 0;
Coin[] coins = new Coin[coinNum];

void setup() {
  
  size(1280, 720);
  noStroke();
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(40, 50), i, balls);
  }
  //Populates Coin Array
  for (int i = 0; i < coinNum; i++) {
   coins[i] = new Coin(color(#ffeb16),random(width),random(height));
}
  
}

void draw() {
  
  background(0);
  //Draw and Remove Coins
  for (int i = 0; i < coinNum; i++) {
  coins[i].displaycoin();
  coins[i].destroycoin();
  }
  
  //  Bouncy balls setup
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
  
  //  Player 1 setup
  for (Ball p1 : balls) {
    p1.collide();
    p1.player1();
  }
  
  /*  Player 2 setup
  for (Ball p2 : balls) {
    p2.collide();
    p2.player2();
  }*/
  
  //  Text setup
  fill(255);
  textSize(width/50);
  
  //  Timer
  text("TIME", width/24, height/18);
  text(":", width/17, height/12);
  text(minute(), width/24, height/12);
  text(second(), width/16, height/12);
  
  //  Score
  text("SCORE", width*0.9, height/18);
  text(Score, width*0.9, height/12);
  
}

// Coin Class and Functions
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
      
       Score++;
       println(Score);
     }
   }
}
     
class Ball {
  
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
      //  Player 1 collision
      if (dist(player1x, player1y, x, y) < diameter-25){
        setup();
      }
      /*  Player 2 collision
      if (dist(player2x, player2y, x, y) < diameter-25){
        setup();
      }*/
    }
  }
  
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
  
  void display() {
    fill(255, 100, 100, 240);
    ellipse(x, y, diameter, diameter);
  }
  
  //  Player 1 draw
  void player1() {
    fill(100, 255, 100);
    ellipse(player1x, player1y, playerd, playerd);
  }
  
  /*  Player 2 draw
  void player2() {
    fill(100, 100, 255);
    ellipse(player2x, player2y, playerd, playerd);
  }*/
  
}

void keyPressed(){
  
  //  Player 1 movement
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
  
  /*  Player 2 movement
  if (key == 's' || key == 'S'){
    player2y += 5;
  }else if (key == 'w' || key == 'W'){
    player2y -= 5;
  }else if (key == 'd' || key == 'D'){
    player2x += 5;
  }else if (key == 'a' || key == 'A'){
    player2x -= 5;
  }*/
  
}
