void mousePressed() {
  if(mouseButton == LEFT){
    if (turrets != null) {
      for (Turret t: turrets) {
        bullets.add(t.fireBullet());
      }
    }
  } else {
    enemies.add(new Enemy());
  }
}
