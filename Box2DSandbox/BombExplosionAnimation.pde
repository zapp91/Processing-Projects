class BombExplosionAnimation {

  Vec2 loc;
  int timeCreated;
  
  float angle;
  int size;
  int opacity;
  

  BombExplosionAnimation(Vec2 loc, int timeCreated) {
    this.loc = loc;
    this.timeCreated = timeCreated;
    
    this.angle = random(2*PI);
    this.size = 0;
    this.opacity = 255;
  }
  
  void updateAnimation() {
    angle = angle + 0.005;
    size = size + 1;
    opacity = opacity - 1;
  }
  
  void display() {
    push();
      tint(255, opacity);
      translate(loc.x-width/2, loc.y-height/2);    // Using the Vec2 position and float angle to
      rotate(-angle);
      image(explosionImage, 0, 0, size, size);
      scale(0.5);
      rotate(2*angle);
      image(explosionImage, 0, 0, size, size);
    pop();
  }
}
