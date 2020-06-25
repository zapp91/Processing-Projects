// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Class to describe a fixed spinning object

class Windmill {

  // Our object is two boxes and one joint
  // Consider making the fixed box much smaller and not drawing it
  RevoluteJoint joint;
  PhysicsObject box1;
  PhysicsObject box2;

  Windmill(float x, float y) {

    // Initialize positions of two boxes
    box1 = new PhysicsObject(x, y, 200, 10, #FC7DC8, #FC7DC8, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.RECTANGLE); 
    box2 = new PhysicsObject(x, y, 20, 10, #3BFF5D, #FC7DC8, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.CIRCLE); 

    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();

    rjd.initialize(box1.body, box2.body, box1.body.getWorldCenter());

    // Turning on a motor (optional)
    rjd.motorSpeed = PI*4*randomPosNeg1();       // how fast?
    rjd.maxMotorTorque = 1000000.0; // how powerful?
    rjd.enableMotor = true;      // is it on?

    // There are many other properties you can set for a Revolute joint
    // For example, you can limit its angle between a minimum and a maximum
    // See box2d manual for more
    

    // Create the joint
    joint = (RevoluteJoint) box2d.world.createJoint(rjd);
  }

  void display() {
    box2.display();
    box1.display();
  }
}
