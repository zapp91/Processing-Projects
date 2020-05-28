class Enemy {
  boolean isDead = false;
  int size;
  color colour;
  
  PVector location;
  PVector targetLocation;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Enemy() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 5;
    size = 50;
    colour = #FFCD03;
  }
  
  void updateEnemy() {
    acceleration = PVector.random2D();
    
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void drawEnemy() {
    push();
      fill(colour);
      ellipse(location.x, location.y, size, size);
    pop();
  }
  
}
