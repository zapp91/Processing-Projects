float mouseAngle;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Turret> turrets = new ArrayList<Turret>();

void setup() {
  size(1000,1000);
  noCursor();
  rectMode(CENTER);
  while (turrets.size() < 10) {
    turrets.add(new Turret());
  } //<>//
}

void draw(){
  background(0);
  //mouseAngle = atan2(mouseY - height/2, mouseX - width/2);
  
  drawEntities();
  detectBulletCollision();
  removeDead();
  if (mousePressed) {
    mousePressed();
  }
}
