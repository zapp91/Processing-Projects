class Bullet {
  boolean isDead = false;
  String shape;
  int size;
  color colour;
  int armorPiercing;
  float armorPiercingVelocityPenalty;
  
  PVector location;
  PVector targetLocation;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Bullet(String shape, int size, color colour, int armorPiercing, float armorPiercingVelocityPenalty, PVector bLocation, PVector target, float Angle, float bVelocity, float bAcceleration, float bTopSpeed) {
    this.shape = shape;
    this.size = size;
    this.colour = colour;
    this.armorPiercing = armorPiercing;
    this.armorPiercingVelocityPenalty = armorPiercingVelocityPenalty;
    
    this.location = bLocation;
    this.targetLocation = target;
    
    //this.velocity = PVector.sub(targetLocation,bLocation).setMag(bVelocity);
    //this.acceleration = PVector.sub(targetLocation,bLocation).setMag(bAcceleration);
    this.velocity = PVector.fromAngle(Angle).setMag(bVelocity);
    this.acceleration = PVector.fromAngle(Angle).setMag(bAcceleration);
    this.topspeed = bTopSpeed;
  }
  
  void bulletHit() {
    armorPiercing--;
    velocity.div(armorPiercingVelocityPenalty);
  }
  
  void updateBullet() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void drawBullet() {
    push();
      fill(colour);
      if (shape.equals("ellipse")) {
        ellipse(location.x, location.y, size, size);
      } else if (shape.equals("rect")) {
        rect(location.x, location.y, size, size);
      }
    pop();
  }

  
}
