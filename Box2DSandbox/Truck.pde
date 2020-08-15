class Truck {

  PhysicsObject wheel1;
  PhysicsObject wheel2;
  PhysicsObject p3;
  
  RevoluteJointDef rjd1;
  RevoluteJointDef rjd2;
  RevoluteJoint joint1;
  RevoluteJoint joint2;

  Truck(float x, float y) {
    this(x,y,rand.nextBoolean());
  }
  
  Truck(float x, float y, boolean flipTruck) {

    int posNeg1 = (flipTruck) ? -1 : 1;

    wheel1 = new PhysicsObject(x-70*posNeg1, y+35, 40, 40, 0, #464545, #FC7DC8, false, 0, Box2DBodyType.DYNAMIC, 1, 0.6, 0.5, Shape.CIRCLE, tireImage, flipTruck); 
    wheel2 = new PhysicsObject(x+82*posNeg1, y+35, 40, 40, 0, #464545, #FC7DC8, false, 0, Box2DBodyType.DYNAMIC, 1, 0.6, 0.5, Shape.CIRCLE, tireImage, flipTruck); 
    p3 = new PhysicsObject(x, y, 240, 74, 0, #FFFFFF, #FC7DC8, false, 0, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CARBODY, truckBodyImage, flipTruck);
    
    rjd1 = new RevoluteJointDef();
    rjd2 = new RevoluteJointDef();

    rjd1.initialize(wheel1.body, p3.body, wheel1.body.getWorldCenter());
    rjd2.initialize(wheel2.body, p3.body, wheel2.body.getWorldCenter());

    rjd1.motorSpeed = PI*4*posNeg1;    // how fast?
    rjd1.maxMotorTorque = 100000.0;    // how powerful?
    rjd1.enableMotor = true;           // is it on?
    
    rjd2.motorSpeed = PI*4*posNeg1;    // how fast?
    rjd2.maxMotorTorque = 100000.0;    // how powerful?
    rjd2.enableMotor = true;           // is it on?

    joint1 = (RevoluteJoint) box2d.world.createJoint(rjd1);
    joint2 = (RevoluteJoint) box2d.world.createJoint(rjd2);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    
    Fixture fixture = p3.body.getFixtureList();
    boolean detectedTruckBodyConnection = false;
    while(fixture != null && !detectedTruckBodyConnection) {
      detectedTruckBodyConnection = fixture.testPoint(worldPoint);
      fixture = fixture.getNext();
    }
    
    return (wheel1.body.getFixtureList().testPoint(worldPoint) || wheel2.body.getFixtureList().testPoint(worldPoint) || detectedTruckBodyConnection);
  }

  void display() {
    if (showSkins) p3.displayTrunkShroud();
    wheel1.display();
    wheel2.display();
    p3.display();
  }
  
  void destroy() {
    box2d.destroyBody(wheel1.body);
    box2d.destroyBody(wheel2.body);
    box2d.destroyBody(p3.body);
  }
}
