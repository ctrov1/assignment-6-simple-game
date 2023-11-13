/**
 * Bouncy Bubbles  
 * based on code from Keith Peters. 
 * 
 * Multiple-object collision.
 * Taken from https://processing.org/examples/bouncybubbles.html
 * 
 * Written by Charlie Trovini & Sam Kaplan
 */


/*-----------------------------------------------------------------------------------------------

PSUEDOCODE -- Rip-off Galaga

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


int numBalls = 12;
float spring = 0.05;
float gravity = 0.03;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

void setup() {
  size(640, 360);
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(30, 70), i, balls);
  }
  noStroke();
  fill(255, 204);
}

void draw() {
  background(0);
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();  
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
    ellipse(x, y, diameter, diameter);
  }
}
