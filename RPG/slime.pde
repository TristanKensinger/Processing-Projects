class Slime implements Collidable {

  float x, y;
  PImage slime = loadImage("slime.png");
  boolean move = false;
  float attackCt = 20;
  float slimeHP = 3;

  Slime() {
    x = random(-4600, 4600);
    y = random(-4600, 4600);
  }

  void update() {
    if (x+globalX+getWidth() > 50 && x+globalX < 650 && y+globalY+getHeight() > 50 && y+globalY < 650) {
      move = false;
      if (y+globalY > 405) {
        y -= 2;
        move = true;
      }
      if (y+globalY+getHeight() < 295) {
        y += 2;
        move = true;
      }
      if (x+globalX > 380) {
        x -= 2;
        move = true;
      }
      if (x+globalX+getWidth() < 320) {
        x += 2;
        move = true;
      }
      if (attackCt == 20 && move == false) {
        hp--;
        attackCt = 0;
      } 
      if (!move) {
        move = true;
        attackCt++;
      }
    }
  }

  void show() {
    image(slime, x + globalX, y + globalY, 50, 50);
    if (adminMode) {
      fill(0);
      line(x+globalX, y+globalY, x+globalX+50, y+globalY);
      line(x+globalX+50, y+globalY, x+globalX+50, y+globalY+50);     
      line(x+globalX+50, y+globalY+50, x+globalX, y+globalY+50);
      line(x+globalX, y+globalY, x+globalX, y+globalY+50);
    }
  }

  void setHP(float hp) {
    slimeHP = hp;
  }
  float getHP() {
    return slimeHP;
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