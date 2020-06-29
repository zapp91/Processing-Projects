class Car {

  PhysicsObject wheel1;
  PhysicsObject wheel2;
  PhysicsObject p3;
  
  RevoluteJointDef rjd1;
  RevoluteJointDef rjd2;
  RevoluteJoint joint1;
  RevoluteJoint joint2;
  boolean flipCar;
  int posNeg1;

  Car(float x, float y) {
    
    flipCar = rand.nextBoolean();
    posNeg1 = (flipCar) ? -1 : 1;

    wheel1 = new PhysicsObject(x-70*posNeg1, y+35, 40, 40, #464545, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CIRCLE, tireImage, flipCar); 
    wheel2 = new PhysicsObject(x+82*posNeg1, y+35, 40, 40, #464545, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CIRCLE, tireImage, flipCar); 
    p3 = new PhysicsObject(x, y, 240, 74, #FFFFFF, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CARBODY, carBodyImage, flipCar);
    
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

  void display() {
    if (showSkins) p3.displayTrunkShroud();
    wheel1.display();
    wheel2.display();
    p3.display();
  }
  
  void destroy() {
    box2d.world.destroyJoint(joint1);
    box2d.world.destroyJoint(joint2);
    box2d.destroyBody(wheel1.body);
    box2d.destroyBody(wheel2.body);
    box2d.destroyBody(p3.body);
  }
}
