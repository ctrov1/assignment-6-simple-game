//  BALLS

class Ball {
  
  //  BALL: Interger setup
  {
    GSV();  //  Global Scaling Variable
  }
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  float spring = pythagscale/1400;
  int id;
  Ball[] others;
  
  Ball(float xin, float yin, float din, int idin, Ball[] oin){
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  }
  
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
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
      if (dist(p1hboxx, p1hboxy, x, y) < ballSize/1.25 && Lives >= 0){
        background(255,0,0);
        fill(255,255,255);
        text("DANGER!", width/2.1, height/18);
        text("0:", width/2.05, height/12);
        text(Lives, width/1.99, height/12);
        Lives -= 1;
      }else if (Lives <= 0){  //  Kill player after running out of lives
        GameOver();
      }
    }
  }
  
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
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
  
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: DISPLAY
  
  void display() {
    fill(255, 100, 100, 240);
    ellipse(x, y, ballSize, ballSize);
  }
  
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
  //  BALL: INITIAL VELOCITY
  
  void moveInit() {
    vy += random(-2,2);
    vx += random(-2,2);
  }
  
}  //  END OF BALLS
