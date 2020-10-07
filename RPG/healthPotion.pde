class HealthPotion implements Collidable {

  float x, y;
  PImage potion = loadImage("healthPotion.png");

  HealthPotion() {
    x = random(-4600, 4600);
    y = random(-4600, 4600);
  }

  void show() {
    image(potion, x+globalX, y+globalY, 50, 50);
    if (adminMode) {
      fill(0);
      line(x+globalX, y+globalY, x+globalX+50, y+globalY);
      line(x+globalX+50, y+globalY, x+globalX+50, y+globalY+50);     
      line(x+globalX+50, y+globalY+50, x+globalX, y+globalY+50);
      line(x+globalX, y+globalY, x+globalX, y+globalY+50);
    }
  }

  //Collidable Methods
  boolean intersects(float i, float j, Collidable c) {
    if (x+globalX+getWidth()+i>=c.getX() && x+globalX+i<=c.getX()+c.getWidth() && y+globalY+getHeight()+j>=c.getY() && y+globalY+j<=c.getY()+c.getHeight())
      return true;
    return false;
  }
  float getX() {
    return x+globalX;
  }
  float getY() {
    return y+globalY;
  }
  float getWidth() {
    return 50;
  }
  float getHeight() {
    return 50;
  }
}