class Spring {

  MouseJoint mouseJoint;
  PhysicsObject object = null;
  
  Spring() {
    mouseJoint = null;
  }

  void update(float x, float y) {
    if (mouseJoint != null) {
      
      //Make spring stronger the further the mouse is from the jointed object
      
      //Vec2 anchorBCords = new Vec2(0,0);
      //mouseJoint.getAnchorB(anchorBCords);
      
      //float mouseDistance = dist(mouseJoint.getTarget().x, mouseJoint.getTarget().y, anchorBCords.x, anchorBCords.y);
      //println(mouseDistance);
      //println(mouseJoint.getMaxForce());
      //println((1000.0 * mouseJoint.getBodyB().m_mass) * (mouseDistance/100 + 1));
      
      //mouseJoint.setMaxForce( (1000.0 * mouseJoint.getBodyB().m_mass) * (mouseDistance/10 + 1));
      mouseJoint.setTarget(box2d.coordPixelsToWorld(x,y));
    }
  }

  void display() {
    push();
    if (mouseJoint != null) {
      Vec2 v1 = new Vec2(0,0);
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = new Vec2(0,0);
      mouseJoint.getAnchorB(v2);
      v1 = box2d.coordWorldToPixels(v1);
      v2 = box2d.coordWorldToPixels(v2);
      stroke(#FFEE6C);
      strokeWeight(2);
      line(v1.x,v1.y,v2.x,v2.y);
    }
    pop();
  }

  void bind(float x, float y, PhysicsObject box) {
    if (mouseJoint == null) {
      object = box;
      object.strokeWeight = 2;
      
      MouseJointDef md = new MouseJointDef();
      md.bodyA = box2d.getGroundBody();
      md.bodyB = box.body;
      Vec2 mp = box2d.coordPixelsToWorld(x,y);
      md.target.set(mp);
      
      md.maxForce = 1000.0 * box.body.m_mass;
      md.frequencyHz = 5.0;
      md.dampingRatio = 0.9;
  
      mouseJoint = (MouseJoint) box2d.world.createJoint(md);
    }
  }
  
  void bind(float x, float y, Truck truck) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    if (truck.wheel1.body.getFixtureList().testPoint(worldPoint)) {bind(x, y, truck.wheel1);};
    if (truck.wheel2.body.getFixtureList().testPoint(worldPoint)) {bind(x, y, truck.wheel2);};
    
    Fixture fixture = truck.p3.body.getFixtureList();
    boolean detectedTruckBodyConnection = false;
    while(fixture != null && !detectedTruckBodyConnection) {
      if(fixture.testPoint(worldPoint)) {
        bind(x, y, truck.p3);
      };
      fixture = fixture.getNext();
    }
  }

  void destroy() {
    if (mouseJoint != null) {
      object.strokeWeight = 0;
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }

}
