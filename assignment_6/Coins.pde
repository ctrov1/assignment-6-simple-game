/*-------------------------------------------------------------------------------------------------------------------*/

//  COINS

//  Coin Class and Functions
class Coin {

  //  Global Scaling Variable
  //{
  //  GSV();
  //}
  float pythagscale = (sqrt((width*width + height*height)));
  
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

/*-------------------------------------------------------------------------------------------------------------------*/
