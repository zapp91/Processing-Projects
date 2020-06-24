class Car {

  PhysicsObject p1;
  PhysicsObject p2;

  float len;
  // Chain constructor
  Car(float x, float y) {
    len = 32;

    p1 = new PhysicsObject(x, y, 30, 1, #FFFFFF, randomColor(), Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, false);
    p2 = new PhysicsObject(x+50, y, 30, 1, #FFFFFF, randomColor(), Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, false);

    DistanceJointDef djd = new DistanceJointDef();
    // Connection between previous particle and this one
    djd.bodyA = p1.body;
    djd.bodyB = p2.body;
    // Equilibrium length
    djd.length = box2d.scalarPixelsToWorld(len);
    
    // These properties affect how springy the joint is 
    djd.frequencyHz = 5;  // Try a value less than 5 (0 for no elasticity)
    djd.dampingRatio = 0.9; // Ranges between 0 and 1 (1 for no springiness)

    // Make the joint.  Note we aren't storing a reference to the joint ourselves anywhere!
    // We might need to someday, but for now it's ok
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  }

  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    push();
    stroke(255);
    strokeWeight(2);
    line(pos1.x,pos1.y,pos2.x,pos2.y);
    pop();
    p1.display();
    p2.display();
  }
}
