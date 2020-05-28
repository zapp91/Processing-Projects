class Turret {
  boolean isDead = false;
  int size;
  color colour;
  int tier;
  float mouseAngle;
  
  PVector location;
  
  Turret() {
    size = 50;
    colour = #FFA908;
    location = new PVector(random(width), random(height));
  }
  
  void updateTurret() {
    mouseAngle = atan2(mouseY - location.y, mouseX - location.x);
    //acceleration = PVector.random2D();
    
    //velocity.add(acceleration);
    //velocity.limit(topspeed);
    //location.add(velocity);
  }
  
  Bullet fireBullet() {
    return new Bullet(
                  "ellipse",
                  10,
                  #03FF3B,
                  2,
                  2,
                  newPosition(location, mouseAngle, 30),
                  new PVector(mouseX,mouseY),
                  mouseAngle,
                  10,
                  0,
                  20);
  }
  
  void drawTurret() {
    push();
      translate(location.x, location.y);
      fill(colour);
      rect(0, 0, size, size);
    
      push();
        stroke(#A5A5A5);
        strokeWeight(15);
        rotate(mouseAngle);
        line(0, 0, 30, 0);
      pop();
    pop();
  }
  
  
}
