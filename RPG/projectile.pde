class Projectile implements Collidable {

  float x, y;
  float xV, yV;
  float duration = 0;

  Projectile(float x, float y, float xV, float yV) {
    this.x = x;
    this.y = y;
    this.xV = xV;
    this.yV = yV;
  }

  void update() {
    x += xV;
    y += yV;
    duration++;
  }

  void show() {
    fill(255, 0, 0);
    ellipse(x+globalX, y+globalY, 15, 15);
  }

  float getDeathDuration() {
    return duration;
  }

  boolean intersects(float i, float j, Collidable c) {
    if (x+globalX+getWidth()+i>=c.getX() && x+globalX+i<=c.getX()+c.getWidth() && y+globalY+getHeight()+j>=c.getY() && y+globalY+j<=c.getY()+c.getHeight())
      return true;
    return false;
  }
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getWidth() {
    return 15;
  }
  float getHeight() {
    return 15;
  }
}