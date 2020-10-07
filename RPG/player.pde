class Player implements Collidable {

  PImage player1 = loadImage("player1.png");
  PImage player2 = loadImage("player2.png");
  float currentPic = 1;
  float picDelay = 0;

  void show() {
    if (faceRight && currentPic == 1)
      image(player1, 325, 300, 50, 100);
    else if (currentPic == 1) {
      pushMatrix();
      scale(-1, 1);
      image(player1, -player1.width-325, 300, 50, 100);
      popMatrix();
    }
    if (faceRight && currentPic == 2)
      image(player2, 325, 300, 100, 100);
    else if (currentPic == 2) {
      pushMatrix();
      scale(-1, 1);
      image(player2, -player2.width-275, 300, 100, 100);
      popMatrix();
    }
    if (adminMode) {
      fill(0);
      line(325, 300, 375, 300);
      line(375, 300, 375, 400);
      line(375, 400, 325, 400);
      line(325, 300, 325, 400);
    }
    if (currentPic == 2) {
      picDelay++;
      if (picDelay == 3) {
        picDelay = 0;
        currentPic = 1;
      }
    }
  }

  void setCurrentPic(float currentPic) {
    this.currentPic = currentPic;
  }

  //Collidable Methods
  boolean intersects(float i, float j, Collidable c) {
    if (375+i>=c.getX() && 325+i<=c.getX()+c.getWidth() && 400+j>=c.getY() && 300+j<=c.getY()+c.getHeight())
      return true;
    return false;
  }
  float getX() {
    return 325;
  }
  float getY() {
    return 300;
  }
  float getWidth() {
    return 50;
  }
  float getHeight() {
    return 100;
  }
}