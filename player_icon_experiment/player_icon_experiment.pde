PShape p1_icon;
PShape p2_icon;

void setup(){
  
  noStroke();
  size (1280, 720);
  
  /*  Original coordinates scaled to 6400 x 3600:
  
  PShape p1_outerquad = createShape(QUAD,130,100,270,100,245,200,155,200);
  PShape p1_innerquad = createShape(QUAD,150,110,250,110,230,190,170,190);
  PShape p1_circle = createShape(ELLIPSE,200,150,60,60);
  PShape p1_topquad = createShape(QUAD,130,100,270,100,240,60,160,60);
  
  PShape p2_outerquad = createShape(QUAD,130,400,270,400,245,500,155,500);
  PShape p2_innerquad = createShape(QUAD,150,410,250,410,230,490,170,490);
  PShape p2_circle = createShape(ELLIPSE,200,450,60,60);
  PShape p2_topquad = createShape(QUAD,130,400,270,400,240,360,160,360);
  
  */
  
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
  p2_icon.addChild(p2_topquad);
  
}

void draw(){
  background(0);
  //scale(0.2);
  shape(p1_icon);
  shape(p2_icon);
  //ellipse(200,130,120,120);
}
