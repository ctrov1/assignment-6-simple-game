/*-------------------------------------------------------------------------------------------------------------------*/

//  BALLS

class Ball {
  
  //  Global Scaling Variable
  //{
  //  GSV();
  //}
  float pythagscale = (sqrt((width*width + height*height)));
  float ballSize = pythagscale/36.7;
  float spring = pythagscale/1400;
  
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
