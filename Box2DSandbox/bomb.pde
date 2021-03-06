class Bomb {

  PhysicsObject bombBody;
  ArrayList<PhysicsObject> bombParticles = new ArrayList<PhysicsObject>();
  int numOfParticles;
  int blastPower;

  Bomb(float x, float y, int numOfParticles, int blastPower) {
    bombBody = new PhysicsObject(x, y, 30, 30, 0, #ff0000, #E5E5E5, false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, Shape.RECTANGLE, 1, tntImage);
    bombBody.body.setUserData(this);
    this.numOfParticles = numOfParticles;
    this.blastPower = blastPower;
    
  }
  
  void display() {
    display(1, 1);
  }
  
  void display(float darknessFactor) {
    display(darknessFactor, 1);
  }

  void display(float darknessFactor, float opacityFactor) {
    //box2.display(darknessFactor, opacityFactor/20);
    bombBody.display(darknessFactor);
    for (PhysicsObject p: bombParticles) {p.display();}
  }
  
  void destroy() {
    box2d.destroyBody(bombBody.body);
  }

}
