// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A rectangular box
class Box {
  //  Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;      

  float x,y,w,h;
  color colour;

  Box(float x, float y, float w, float h, color colour, Box2DBodyType bt, float density, float friction, float restitution) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colour = colour;

    // Build Body
    BodyDef bd = new BodyDef();      
    switch (bt) {
      case STATIC:    bd.type = BodyType.STATIC;
      break;
      case DYNAMIC:   bd.type = BodyType.DYNAMIC;
      break;
      case KINEMATIC: bd.type = BodyType.KINEMATIC;
      default:        println("Unknown Box2D Body Type!");
    }
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);


    // Define a polygon (this is what we use for a rectangle)
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));
    // Box2D considers the width and height of a rectangle to be the distance from center to the edge (so half of what we normally think of as width or height.)
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;

    // Attach Fixture to Body               
    body.createFixture(fd);
  }

  void display() {
    // We need the Body’s position and angle
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);                // translate and rotate the rectangle
    fill(colour);
    strokeWeight(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }

}
