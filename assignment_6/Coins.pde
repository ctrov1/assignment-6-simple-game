//  COINS: Coin Class and Functions

class Coin {
  
  //  COIN: Interger setup
  {
    GSV();  //  Global Scaling Variable
  }
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
    ellipse(cxpos,cypos,pythagscale/90,pythagscale/90);
  }
  void destroycoin(){
    float coindistance = sqrt((cxpos-p1hboxx) * (cxpos-p1hboxx) + (cypos-p1hboxy) * (cypos-p1hboxy));
    if (coindistance <=pythagscale/70){
      cxpos=-10000;
      cypos=-10000;
      countDownStart += 2;
      Score++;
      collect.play();
    }
  }
}  //  END OF COINS
