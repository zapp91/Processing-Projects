void detectBulletCollision() {
  if (bullets != null) {
      for (Bullet b: bullets) {
        if (enemies != null) {
            for (Enemy e: enemies) {
              if (PVector.dist(b.location, e.location) < (b.size + e.size)/2) {
                e.colour = #FFFFFF;
                e.isDead = true;
                b.bulletHit();
                if (b.armorPiercing < 1) {
                  b.colour = #FFFFFF;
                  b.isDead = true; 
                }
              }
            }
        }
      }
  }
}

void drawEntities() {
  drawTurrets();
  drawEnemies();
  drawBullets();
  drawReticle();
}

void drawReticle() {
  push();
    translate(mouseX, mouseY);
    stroke(255);
    if (enemies != null) {
      for (Enemy e: enemies) {
        if (PVector.dist(e.location,new PVector(mouseX,mouseY)) < e.size/2) {
          rotate(radians(45));
          stroke(#FF0000);
          strokeWeight(2);
        }
      }
    }
    line (0, 0 - 15, 0, 0 - 3);
    line (0, 0 + 15, 0, 0 + 3);
    line (0 - 15, 0, 0 - 3, 0);
    line (0 + 15, 0, 0 + 3, 0);
  pop();
}

void drawEnemies() {
  if (enemies != null) {
      for (Enemy e: enemies) {
        edgeTeleport(e.location);
        e.drawEnemy();
        e.updateEnemy();
      }
  }
}

void drawTurrets() {
  if (turrets != null) {
      for (Turret t: turrets) {
        edgeTeleport(t.location);
        t.drawTurret();
        t.updateTurret();
      }
  }
}

void drawBullets() {
  if (bullets != null) {
      for (Bullet b: bullets) {
        //edgeTeleport(b.location);
        b.drawBullet();
        b.updateBullet();
      }
  }
}

void removeDead() {
  if (bullets != null) {
    for (int i = bullets.size() - 1; i >= 0; i--) {
      if (bullets.get(i).isDead) {
        bullets.remove(i);
      }
    }
  }
  if (enemies != null) {
    for (int i = enemies.size() - 1; i >= 0; i--) {
      if (enemies.get(i).isDead) {
        enemies.remove(i);
      }
    }
  }
}

void edgeTeleport(PVector location) {
  if (location.x > width) location.x = 0;
  if (location.x < 0) location.x = width;
  if (location.y > height) location.y = 0;
  if (location.y < 0) location.y = height;
}

int randPosNegOne() {
  return int(random(2)) == 1 ? 1 : -1;
}

PVector newPosition(PVector initialPosition,float direction,int distance) {
  return new PVector(
    initialPosition.x + (distance * cos(direction)),
    initialPosition.y + (distance * sin(direction))
  );
}
