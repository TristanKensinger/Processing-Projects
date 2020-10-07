class Mage implements Collidable {

  float x, y;
  PImage magePic = loadImage("mage.png");
  float mageHP = 5;
  float projectileDelay = 0;
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

  Mage() {
    x = random(-4600, 4600);
    y = random(-4600, 4600);
  }

  void update() {
    //Movement
    if (x+globalX+getWidth() > 0 && x+globalX < 700 && y+globalY+getHeight() > 0 && y+globalY < 700) {
      if (y+globalY > 550) {
        y -= 2;
      }
      if (y+globalY+getHeight() < 150) {
        y += 2;
      }
      if (x+globalX > 150) {
        x -= 2;
      }
      if (x+globalX+getWidth() < 550) {
        x += 2;
      }
      projectileDelay++;
    }

    //Projectile Creation
    if (projectileDelay >= 50) {
      projectileDelay = 0;
      projectiles.add(new Projectile(x, y, (350-(x+globalX))/40.0, (350-(y+globalY))/40.0));
    }

    //Projectile Update
    for (int i=0; i<projectiles.size(); i++) {
      projectiles.get(i).update();
      projectiles.get(i).show();
      if (projectiles.get(i).getX()+globalX < 375 && projectiles.get(i).getX()+projectiles.get(i).getWidth()+globalX > 325 && projectiles.get(i).getY()+globalY < 400 && projectiles.get(i).getY()+projectiles.get(i).getHeight()+globalY > 300) {
        projectiles.remove(i);
        hp--;
      } else if (projectiles.size() > 0) {
        if (projectiles.get(i).getDeathDuration() > 150)
          projectiles.remove(i);
      }
    }
  }

  void show() {
    image(magePic, x+globalX, y+globalY, 50, 100);
    if (adminMode) {
      fill(0);
      line(x+globalX, y+globalY, x+globalX+50, y+globalY);
      line(x+globalX+50, y+globalY, x+globalX+50, y+globalY+100);     
      line(x+globalX+50, y+globalY+100, x+globalX, y+globalY+100);
      line(x+globalX, y+globalY, x+globalX, y+globalY+100);
    }
  }

  void setHP(float hp) {
    mageHP = hp;
  }
  float getHP() {
    return mageHP;
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
    return 100;
  }
}