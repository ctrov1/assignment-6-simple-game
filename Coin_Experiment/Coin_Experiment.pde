float Charx = 50;
float Chary = 50;
Coin[] coins = new Coin[10];
void setup(){
  size(500,500);
  for (int i = 0; i < coins.length; i++) {
   coins[i] = new Coin(color(#ffeb16),random(width),random(height));
}
}

void draw() {
  background(200,200);
  
  for (int i = 0; i < coins.length; i++) {
  coins[i].displaycoin();
  coins[i].destroycoin();
  }
  ellipseMode(CENTER);
  ellipse(Charx,Chary,5,5);
  
}


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
     if (cxpos>Charx-10 && cxpos<Charx+10 && cypos>Chary-10 && cypos<Chary+10){
       noStroke();
       fill(200);
       ellipse(cxpos,cypos,10,10);
       println("it works");
       
     }
    stroke(1);     
}


}



void keyPressed(){

  if (key == CODED){
    if (keyCode == DOWN){
      Chary += 10;
    }else if (keyCode == UP){
      Chary -= 10;
    }else if (keyCode == RIGHT){
      Charx += 10;
    }else if (keyCode == LEFT){
      Charx -= 10;
    }
  }
  
}
