interface Collidable {

  boolean intersects(float i, float j, Collidable c);

  float getX();

  float getY();

  float getWidth();

  float getHeight();
}