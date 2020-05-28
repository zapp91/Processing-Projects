void drawBullets() {
  if (bullets != null) {
      for (Bullet b: bullets) {
        b.drawBullet();
      }
  }
}

void drawEnemies() {
  if (enemies != null) {
      for (Enemy e: enemies) {
        e.drawEnemy();
      }
  }
}

int randPosNeg() {
  return int(random(2)) == 1 ? 1 : -1;
}
