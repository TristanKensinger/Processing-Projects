class Health {

  void show() {
    fill(0);
    for (int i=0; i<maxHp; i++)
      rect(i*20+10, 10, 10, 50);
    fill(255, 0, 0);
    for (int i=0; i<hp; i++)
      rect(i*20+10, 10, 10, 50);
  }
}