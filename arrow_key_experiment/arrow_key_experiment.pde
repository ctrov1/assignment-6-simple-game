int x = 50;
int y = 50;

void setup(){
}

void draw() {
  background(200,200);
  ellipseMode(CENTER);
  ellipse(x,y,5,5);
}

void keyPressed(){
  if (key == CODED){
    if (keyCode == DOWN){
      y += 5;
    }else if (keyCode == UP){
      y -= 5;
    }else if (keyCode == RIGHT){
      x += 5;
    }else if (keyCode == LEFT){
      x -= 5;
    }
  }
}
