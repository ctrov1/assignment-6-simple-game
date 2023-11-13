
int y = 0;

void setup(){
  background(200,200);
}

void draw() {
  ellipseMode(CENTER);
  ellipse(0,y,5,5);
  
 
}
  void keyPressed(){
  if (key == CODED){
    if (keyCode == DOWN){
      y += 5;}
  }
  }
