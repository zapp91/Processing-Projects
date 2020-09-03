class Bomb {

  PhysicsObject bombBody;
  ArrayList<PhysicsObject> bombParticles = new ArrayList<PhysicsObject>();
  int numOfParticles;
  int blastPower;

  Bomb(float x, float y, int numOfParticles, int blastPower) {
    bombBody = new PhysicsObject(x, y, 20, 20, 0, #ff0000, randomColor(), false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, Shape.RECTANGLE, 1);
    this.numOfParticles = numOfParticles;
    this.blastPower = blastPower;
  }

  //void explode() {
  //  for (int i = 0; i < numOfParticles; i++) {
  //    Body body;   
  //    float angle = radians((i / (float)numOfParticles) * 360);
  //    Vec2 rayDir = new Vec2(sin(angle),cos(angle));
  
  //    BodyDef bd = new BodyDef();
  //    bd.type = BodyType.DYNAMIC;
  //    bd.fixedRotation = true; // rotation not necessary
  //    bd.bullet = true; // prevent tunneling at high speed
  //    bd.linearDamping = 10; // drag due to moving through air
  //    bd.gravityScale = 0; // ignore gravity
  //    bd.position = bd.position.set(bombBody.body.getPosition()); // start at blast center
  //    bd.linearVelocity = rayDir.mulLocal(blastPower);
  //    body = box2d.createBody(bd);
  
  //    CircleShape cs = new CircleShape();
  //    cs.m_radius = 0.05; // very small
  
  //    FixtureDef fd = new FixtureDef();
  //    fd.shape = cs;
  //    fd.density = 60 / (float)numOfParticles; // very high - shared across all particles
  //    fd.friction = 0; // friction not necessary
  //    fd.restitution = 0.99f; // high restitution to reflect off obstacles
  //    fd.filter.groupIndex = -2; // particles should not collide with each other
  //    body.createFixture(fd);
  //  }
  //}
  
  void explode() {
    Vec2 bombPosition = box2d.getBodyPixelCoord(bombBody.body);
    this.destroy();
    for (int i = 0; i < numOfParticles; i++) {
      float angle = radians((i / (float)numOfParticles) * 360);
      Vec2 rayDir = new Vec2(sin(angle),cos(angle));
      println(angle, rayDir);
      bombParticles.add(new PhysicsObject(bombPosition.x, bombPosition.y, 10, 10, 0, #ff0000, randomColor(), false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, Shape.CIRCLE, 1));
      bombParticles.get(bombParticles.size() - 1).body.setBullet(true);
      bombParticles.get(bombParticles.size() - 1).body.applyForce(rayDir.mulLocal(blastPower), bombPosition);
    }
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
