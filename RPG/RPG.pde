float globalX = 350, globalY = 350;
boolean up, right, down, left;
PImage[] grass = new PImage[5];
Player player;
int[][] picture = new int[50][50];
Rock[] rocks = new Rock[100];
ArrayList<HealthPotion> healthPotions = new ArrayList<HealthPotion>();
ArrayList<Slime> slimes = new ArrayList<Slime>();
ArrayList<Mage> mages = new ArrayList<Mage>();
boolean adminMode = false;
boolean faceRight = true;
float hp = 3, maxHp = 3;
float pageCt = 0;
float kills = 3, killCt = 0;
Health healthBar;
boolean attack = false;
float attackDelay = 0;

void setup() {
  size(700, 700);

  //Player Initialization
  player = new Player();

  //Health Initialization
  healthBar = new Health();

  //Grass Initialization
  grass[0] = loadImage("grass0.png");
  grass[1] = loadImage("grass1.png");
  grass[2] = loadImage("grass2.png");
  grass[3] = loadImage("grass3.png");
  grass[4] = loadImage("grass4.png");
  for (int x=0; x<50; x++) {
    for (int y=0; y<50; y++) {
      picture[x][y] = floor(random(grass.length));
    }
  }

  //Rocks Initialization
  for (int i=0; i<100; i++) {
    rocks[i] = new Rock();
  }

  //Slimes
  for (int i=0; i<200; i++) {
    slimes.add(new Slime());
  }

  //Mages
  for (int i=0; i<100; i++) {
    mages.add(new Mage());
  }

  //HealthPotion Initialization
  for (int i=0; i<100; i++) {
    healthPotions.add(new HealthPotion());
  }
}

void draw() {
  if (pageCt == 0) {
    //Background
    fill(0);
    rect(-5350, -5350, 10700, 10700);
    for (int x=0; x<50; x++) {
      for (int y=0; y<50; y++) {
        image(grass[picture[x][y]], (x*200-5000)+globalX, (y*200-5000)+globalY, 200, 200);
      }
    }

    //Rocks
    for (int i=0; i<100; i++) {
      rocks[i].show();
    }

    //HealthPotions
    for (int i=0; i<healthPotions.size(); i++) {
      healthPotions.get(i).show();
      if (player.intersects(0, 0, healthPotions.get(i)) == true && hp < maxHp) {
        hp++;
        healthPotions.remove(i);
      }
    }

    //Slimes
    for (int i=0; i<slimes.size(); i++) {
      slimes.get(i).update();
      slimes.get(i).show();
      if (slimes.get(i).getHP() == 0) {
        slimes.remove(i);
        killCt++;
        if (killCt == kills) {
          killCt = 0;
          kills += 3;
          maxHp++;
        }
      }
    }

    //Mages
    for (int i=0; i<mages.size(); i++) {
      mages.get(i).update();
      mages.get(i).show();
      if (mages.get(i).getHP() == 0) {
        mages.remove(i);
        killCt++;
        if (killCt == kills) {
          killCt = 0;
          kills += 3;
          maxHp++;
        }
      }
    }

    //Player
    player.show();

    //HealthBar
    healthBar.show();

    //Global Movement (Screen)
    if (!attack) {
      if (up && blocked(0, -5) == false) {
        globalY += 5;
      }
      if (right && blocked(5, 0) == false) {
        globalX -= 5;
      }
      if (down && blocked(0, 5) == false) {
        globalY -= 5;
      }
      if (left && blocked(-5, 0) == false) {
        globalX += 5;
      }
    }
    globalX = constrain(globalX, -4625, 5325);
    globalY = constrain(globalY, -4600, 5300);

    //AdminMode
    if (adminMode) {
      text("GlobalX "+globalX, 550, 25);
      text("GlobalY "+globalY, 550, 50);
    }

    //UI
    fill(0, 0, 255);
    textSize(20);
    text("Level "+floor((maxHp-2)), 10, 100);
    if ((kills-killCt) > 1)
      text(floor((kills-killCt))+" more kills to level", 10, 125);
    else
      text(floor((kills-killCt))+" more kill to level", 10, 125);

    //Death
    if (hp < 1)
      pageCt = 1;
  }
  if (pageCt == 1) {
    fill(0);
    rect(0, 0, 700, 700);
    fill(255);
    text("You Lose!", 10, 25);
  }

  if (attack) {
    attackDelay++;
    if (attackDelay == 3) {
      attack = false;
      attackDelay = 0;
    }
  }
}

boolean blocked(float x, float y) {
  for (int i=0; i<100; i++) {
    if (player.intersects(x, y, rocks[i]) == true)
      return true;
  }
  for (int i=0; i<slimes.size(); i++) {
    if (player.intersects(x, y, slimes.get(i)) == true)
      return true;
  }
  for (int i=0; i<mages.size(); i++) {
    if (player.intersects(x, y, mages.get(i)) == true)
      return true;
  }
  return false;
}

void attack() {
  attack = true;
  player.setCurrentPic(2);
  if (faceRight) {
    for (int i=0; i<slimes.size(); i++) {
      if (slimes.get(i).getX()+slimes.get(i).getWidth() >= 375 && slimes.get(i).getX() <= 575 && slimes.get(i).getY()+slimes.get(i).getHeight() >= 250 && slimes.get(i).getY() <= 450)
        slimes.get(i).setHP(slimes.get(i).getHP()-1);
    }
    for (int i=0; i<mages.size(); i++) {
      if (mages.get(i).getX()+mages.get(i).getWidth() >= 375 && mages.get(i).getX() <= 575 && mages.get(i).getY()+mages.get(i).getHeight() >= 250 && mages.get(i).getY() <= 450)
        mages.get(i).setHP(mages.get(i).getHP()-1);
    }
    fill(120, 120, 120, 120);
    rect(375, 250, 200, 200);
  } else {
    for (int i=0; i<slimes.size(); i++) {
      if (slimes.get(i).getX()+slimes.get(i).getWidth() >= 125 && slimes.get(i).getX() <= 325 && slimes.get(i).getY()+slimes.get(i).getHeight() >= 250 && slimes.get(i).getY() <= 450)
        slimes.get(i).setHP(slimes.get(i).getHP()-1);
    }
    for (int i=0; i<mages.size(); i++) {
      if (mages.get(i).getX()+mages.get(i).getWidth() >= 125 && mages.get(i).getX() <= 325 && mages.get(i).getY()+mages.get(i).getHeight() >= 250 && mages.get(i).getY() <= 450)
        mages.get(i).setHP(mages.get(i).getHP()-1);
    }
    fill(120, 120, 120, 120);
    rect(325, 250, -200, 200);
  }
}

void keyPressed() {
  //Global Movement (Screen)
  if (key == 'w')
    up = true;
  if (key == 'd') {
    faceRight = true;
    right = true;
    left = false;
  }
  if (key == 's')
    down = true;
  if (key == 'a') {
    faceRight = false;
    left = true;
    right = false;
  }
  if (key == 'p') { 
    if (adminMode) adminMode = false;
    else adminMode = true;
  }
  if (key == ' ') {
    attack();
  }
}

void keyReleased() {
  //Global Movement (Screen)
  if (key == 'w')
    up = false;
  if (key == 'd')
    right = false;
  if (key == 's')
    down = false;
  if (key == 'a') 
    left = false;
}