class Rock implements Collidable {

  float x, y;
  PImage rock = loadImage("rock.png");

  Rock() {
    x = random(-4600, 4600);
    y = random(-4600, 4600);
  }

  void show() {
    image(rock, x + globalX, y + globalY, 100, 100);
    if (adminMode) {
      fill(0);
      line(x+globalX, y+globalY, x+globalX+100, y+globalY);
      line(x+globalX+100, y+globalY, x+globalX+100, y+globalY+100);     
      line(x+globalX+100, y+globalY+100, x+globalX, y+globalY+100);
      line(x+globalX, y+globalY, x+globalX, y+globalY+100);
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
    return 100;
  }
  float getHeight() {
    return 100;
  }
}