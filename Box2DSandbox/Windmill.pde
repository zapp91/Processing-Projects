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
    this(x,y,rand.nextBoolean());
  }

  Windmill(float x, float y, boolean reverseSpin) {
    
    // Initialize positions of two boxes
    box1 = new PhysicsObject(x, y, 200, 10, 0, #FC7DC8, #FC7DC8, false, 0, Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, Shape.RECTANGLE); 
    box2 = new PhysicsObject(x, y, 200, 10, 0, #FC7DC8, #FC7DC8, true, 0, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.CIRCLE); 

    box2.body.getFixtureList().setSensor(true);
    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();

    rjd.initialize(box1.body, box2.body, box1.body.getWorldCenter());
    // Turning on a motor (optional)
    rjd.motorSpeed = 12*(reverseSpin == false ? 1 : -1);       // how fast?
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
  
  void destroy() {
    box2d.world.destroyJoint(joint);
    box2d.destroyBody(box1.body);
    box2d.destroyBody(box2.body);
  }
}
