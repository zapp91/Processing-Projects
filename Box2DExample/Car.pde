class Car {

  RevoluteJoint joint1;
  RevoluteJoint joint2;
  PhysicsObject p1;
  PhysicsObject p2;
  PhysicsObject p3;
  int randomNum;

  Car(float x, float y) {
    
    randomNum = randomPosNeg1();
    
    //p1 = new PhysicsObject(x-36, y+20, 20, 10, #FC7DC8, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CIRCLE); 
    //p2 = new PhysicsObject(x+40, y+20, 20, 10, #3BFF5D, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CIRCLE); 
    //p3 = new PhysicsObject(x-1, y+5, 120, 37, #FFFFFF, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CARBODY); 
    p1 = new PhysicsObject(x-72, y+40, 40, 20, #464545, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CIRCLE); 
    p2 = new PhysicsObject(x+80, y+40, 40, 20, #464545, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CIRCLE); 
    p3 = new PhysicsObject(x-2, y+5, 240, 74, #FFFFFF, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.CARBODY);
    
    RevoluteJointDef rjd1 = new RevoluteJointDef();
    RevoluteJointDef rjd2 = new RevoluteJointDef();

    rjd1.initialize(p1.body, p3.body, p1.body.getWorldCenter());
    rjd2.initialize(p2.body, p3.body, p2.body.getWorldCenter());

    rjd1.motorSpeed = PI*4*randomNum;  // how fast?
    rjd1.maxMotorTorque = 100000.0;    // how powerful?
    rjd1.enableMotor = true;           // is it on?
    
    // Turning on a motor (optional)
    rjd2.motorSpeed = PI*4*randomNum;  // how fast?
    rjd2.maxMotorTorque = 100000.0;    // how powerful?
    rjd2.enableMotor = true;           // is it on?

    // There are many other properties you can set for a Revolute joint
    // For example, you can limit its angle between a minimum and a maximum
    // See box2d manual for more

    joint1 = (RevoluteJoint) box2d.world.createJoint(rjd1);
    joint2 = (RevoluteJoint) box2d.world.createJoint(rjd2);
  }

  void display() {
    p1.display();
    p2.display();
    p3.display();
  }
  
  void destroy() {
    box2d.destroyBody(p1.body);
    box2d.destroyBody(p2.body);
    box2d.destroyBody(p3.body);
    //box2d.destroyJoint();
  }
}
