PShape p1_icon;
PShape p2_icon;

void setup(){
  size (1280, 720);
  p1_icon = createShape(GROUP);
  PShape p1_outerquad = createShape(QUAD,100,100,300,100,250,200,150,200);
  PShape p1_innerquad = createShape(QUAD,125,125,275,125,225,175,175,175);
  p1_icon.addChild(p1_outerquad);
  p1_icon.addChild(p1_innerquad);
}

void draw(){
  shape(p1_icon);
}
