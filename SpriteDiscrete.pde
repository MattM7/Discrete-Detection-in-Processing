class SpriteDiscrete {

  PImage img;
  double dX, dY, dNewX, dNewY;
  double dAttemptMoveX, dAttemptMoveY;
  double dW, dH;
  double dAccel;
  double dVelY, dVelYLimit;
  double dVelX;
  int nNumJumps;

  //Constuctor
  SpriteDiscrete(String sImg_, double dX_, double dY_, double dAccel_, double dVelY_, double dVelYLimit_, double dW_, double dH_) { //if dAccel >= 1 this thing breaks
    img = loadImage(sImg_);

    dX = dX_;
    dY = dY_;
    dW = dW_;
    dH = dH_;
    dAccel = dAccel_;
    dVelY = dVelY_;
    dVelYLimit = dVelYLimit_;
    img.resize((int)dW, (int)dH);
  }

  public void move(ArrayList<Tile> arTiles_) {
    gravity();

    checkMove(arTiles_);
    dY = dNewY;
    dX = dNewX;
  }

  public void checkMove(ArrayList<Tile> arTiles_) {
    dAttemptMoveX = dVelX;
    dAttemptMoveY = dVelY;

    for (int i = 0; i < 5; i++) { //adding a loop here prevents jittering
      checkMoveX(arTiles_);
      checkMoveY(arTiles_);
    }
  }

  public void checkMoveX(ArrayList<Tile> arTiles_) {
    dNewX = dX + dAttemptMoveX;

    for (int i = arTiles_.size() - 1; i >= 0; i--) {
      if (willHit(arTiles_.get(i))) { 

        if (dAttemptMoveX > 0) {
          dAttemptMoveX--;
          dNewX = dX + dAttemptMoveX; // In the java version this line wasn't needed because the recursion always did an extra loop that isn't happening in here for some reason

          if (dAttemptMoveX < 0) {
            dAttemptMoveX = 0;
            checkMoveX(arTiles_);
          }
        } else if (dAttemptMoveX < 0) {
          dAttemptMoveX++;
          dNewX = dX + dAttemptMoveX;

          if (dAttemptMoveX > 0) {
            dAttemptMoveX = 0;
            checkMoveX(arTiles_);
          }
        }
        if (dAttemptMoveX != 0) {
          checkMoveX(arTiles_);
        }
      }
    }
  }

  public void checkMoveY(ArrayList<Tile> arTiles_) {
    dNewY = dY - dAttemptMoveY;
    println("NewY " + dNewY + " Current Y " + dY + "dAttemptMoveX: " + dAttemptMoveX);

    for (int i = arTiles_.size() - 1; i >= 0; i--) {
      if (willHit(arTiles_.get(i))) { //replace with isHit
        dVelY = 0;
        if (dAttemptMoveY > 0) {
          dAttemptMoveY--;
          dNewY = dY - dAttemptMoveY;

          if (dAttemptMoveY < 0) {
            dAttemptMoveY = 0;
            checkMoveY(arTiles_);
          }
        } else if (dAttemptMoveY < 0) {
          dAttemptMoveY++;
          dNewY = dY - dAttemptMoveY;

          if (dAttemptMoveY > 0) {
            dAttemptMoveY = 0;
            checkMoveY(arTiles_);
          }
        }
        if (dAttemptMoveY != 0) {
          checkMoveY(arTiles_);
        }
      }
    }
  }


  public void gravity() {
    dVelY -= dAccel;
    /*if (dVelY >= dVelYLimit) {
     dVelY = dVelYLimit;
     } else if (dVelY <= -dVelYLimit) {
     dVelY = -dVelYLimit;
     }*/
  }

  public void jump() {
    //if (nNumJumps > 0) {
    dVelY = 12;
    nNumJumps--;
    //}
  }

  public void changeDir(double dVelX_) {
    dVelX = dVelX_;
  }

  private boolean willHit(Tile tile) {

    if (
      ( ( (dNewX <= tile.fX) && (dNewX+dW >= tile.fX) ) ||
      ( (dNewX >= tile.fX) && (dNewX <= tile.fX+tile.nW) ) )
      &&
      ( ( (dNewY <= tile.fY) && (dNewY+dH >= tile.fY) ) ||
      ( (dNewY >= tile.fY) && (dNewY <= tile.fY+tile.nH) ) )
      ) {
      return (true) ;
    } else {
      return(false) ;
    }
  }

  public void display() {
    image(img, (float)dX, (float)dY);
  }
}