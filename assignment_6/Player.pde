//  PLAYERS

class Player {
  
  //  Player 1
  void displayp1() {
    if (keyCode == DOWN && keyPressed == true){
      p1hboxy += moveSpeedY;
      p1_icon.translate(0,height/144);
      //MoveP1Down = true;
    }
    if (keyCode == UP && keyPressed == true){
      p1hboxy -= moveSpeedY;
      p1_icon.translate(0,-height/144);
      //MoveP1Up = true;
    }
    if (keyCode == RIGHT && keyPressed == true){
      p1hboxx += moveSpeedX;
      p1_icon.translate(width/256,0);
      //MoveP1Right = true;
    }
    if (keyCode == LEFT && keyPressed == true){
      p1hboxx -= moveSpeedX;
      p1_icon.translate(-width/256,0);
      //MoveP1Left = true;
    }/*else{
      MoveP1Down = false;
      MoveP1Up = false;
      MoveP1Right = false;
      MoveP1Left = false;
    }*/
    //  P1 Hitbox
    ellipse(p1hboxx,p1hboxy,width/53.33333,height/30);
    //  P1 Player Icon
    shape(p1_icon);
  }
  
  /*  Player 2
  void displayp2() {
    if (key == 's' && keyPressed == true || key == 'S' && keyPressed == true){
    p2hboxy += moveSpeedY;
    p2_icon.translate(0,height/144);
    MoveP2Down = true;
  }else if (key == 'w' && keyPressed == true || key == 'W' && keyPressed == true){
    p2hboxy -= moveSpeedY;
    p2_icon.translate(0,height/144);
    MoveP2Up = true;
  }else if (key == 'd' && keyPressed == true || key == 'D' && keyPressed == true){
    p2hboxx += moveSpeedX;
    p2_icon.translate(width/256,0);
    MoveP2Right = true;
  }else if (key == 'a' && keyPressed == true || key == 'A' && keyPressed == true){
    p2hboxx -= moveSpeedX;
    p2_icon.translate(width/256,0);
    MoveP2Left = true;
  }else{
    MoveP2Down = false;
    MoveP2Up = false;
    MoveP2Right = false;
    MoveP2Left = false;
  }
    //  P2 Hitbox
    ellipse(p2hboxx,p2hboxy,width/53.33333,height/30);
    //  P2 Player Icon
    shape(p2_icon);
  }
  
  void MoveBoth() {
    if (MoveP2Down == true && MoveP1Down == true){
      player2y += moveSpeed;
      player1y += moveSpeed;
    }else if (MoveP2Up == true && MoveP1Up == true){
      player2y -= moveSpeed;
      player1y -= moveSpeed;
    }else if (MoveP2Right == true && MoveP1Right == true){
      player2x += moveSpeed;
      player1x += moveSpeed;
    }else if (MoveP2Left == true && MoveP1Left == true){
      player2x -= moveSpeed;
      player1x -= moveSpeed;
    }
  }*/
  
}  //  END OF PLAYERS
