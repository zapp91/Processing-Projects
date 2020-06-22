class PhysicsObject {
  Vec2 pos;
  color colour;
  int h;
  int w;
  Body body;
  
  PhysicsObject() {
  }
  
  PhysicsObject(Vec2 pos_, color colour_, int h_, int w_, Box2DBodyType bt) {
    
    this.pos = pos_;
    this.colour = colour_;
    this.h = h_;
    this.w = w_;
    
    //step 1: Define Body
    BodyDef bd = new BodyDef();
    switch (bt) {
      case STATIC:    bd.type = BodyType.STATIC;
      case DYNAMIC:   bd.type = BodyType.DYNAMIC;
      case KINEMATIC: bd.type = BodyType.KINEMATIC;
    }
    bd.position.set(box2D.coordPixelsToWorld(pos_.x, pos_.y));
    
    //step 2: Create Body
    body = box2D.createBody(bd);
    
    //step 3: Create Shape
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2D.scalarPixelsToWorld(w_/2), box2D.scalarPixelsToWorld(h_/2));
    
    //step 4: Make Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    //step 5: Attach Shape to Body with Fixture
    body.createFixture(fd);
  }
  
  void display() {
    push();
    translate(box2D.getBodyPixelCoord(body).x, box2D.getBodyPixelCoord(body).y);
    rotate(-body.getAngle());
    rect(0, 0, w, h);
    pop();
  }
}
