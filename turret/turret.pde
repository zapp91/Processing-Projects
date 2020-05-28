float angle;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void setup() {
  size(1000,1000);
  rectMode(CENTER);
}

void draw(){
  background(0);
  translate(width/2, height/2);
  angle = atan2(mouseY - height/2, mouseX - width/2);
  
  fill(#FFA908);
  rect(0, 0, 50, 50);
  
  push();
    stroke(#A5A5A5);
    strokeWeight(15);
    rotate(angle);
    line(0, 0, 30, 0);
  pop();
  drawEnemies();
  drawBullets();
}

void mousePressed() {
  if(mouseButton == LEFT){
    bullets.add(new Bullet("ellipse", 30, 0, angle, 10, 10, #0EFF03));
  } else {
    enemies.add(new Enemy());
  }
}
