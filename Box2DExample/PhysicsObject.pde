class PhysicsObject {
  //Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;      

  float x,y,w,h;
  color colour1;
  color colour2;
  Shape shape;

  PhysicsObject(float x, float y, float w, float h, color colour1, color colour2, Box2DBodyType bt, float density, float friction, float restitution, Shape shape) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.shape = shape;

    // Build Body
    BodyDef bd = new BodyDef();      
    switch (bt) {
      case STATIC:    bd.type = BodyType.STATIC;
                      break;
      case DYNAMIC:   bd.type = BodyType.DYNAMIC;
                      break;
      case KINEMATIC: bd.type = BodyType.KINEMATIC;
                      break;
      default:        println("Unknown Box2D Body Type!");
    }
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);

    FixtureDef fd = new FixtureDef();

    switch (shape){
      case RECTANGLE:
                      PolygonShape ps = new PolygonShape();
                      ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));
                      fd.shape = ps;
                      break;
      case CIRCLE:
                      CircleShape cs = new CircleShape();
                      cs.m_radius = box2d.scalarPixelsToWorld(w/2);
                      fd.shape = cs;
                      break;
      case CARBODY:
                      Vec2[] vertices = new Vec2[5];  // An array of 4 vectors
                      vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-w/2+5, -h/2+6));
                      vertices[1] = box2d.vectorPixelsToWorld(new Vec2(w/2-20, -h/2+6));
                      vertices[2] = box2d.vectorPixelsToWorld(new Vec2(w/2, h/2-10));
                      vertices[3] = box2d.vectorPixelsToWorld(new Vec2(w/2, h/2));
                      vertices[4] = box2d.vectorPixelsToWorld(new Vec2(-w/2, h/2));
                      //ArrayList<Vec2> vertices = new ArrayList<Vec2>();
                      //vertices.add(box2d.vectorPixelsToWorld(new Vec2(-w/2+5, -h/2+6)));
                      //vertices.add(box2d.vectorPixelsToWorld(new Vec2(w/2-20, -h/2+6)));
                      //vertices.add(box2d.vectorPixelsToWorld(new Vec2(w/2, h/2-10)));
                      //vertices.add(box2d.vectorPixelsToWorld(new Vec2(w/2, h/2)));
                      //vertices.add(box2d.vectorPixelsToWorld(new Vec2(-w/2, h/2)));
                      
                      PolygonShape carS = new PolygonShape();
                      carS.set(vertices, vertices.length);
                      fd.shape = carS;
                      break;
      default:        println("Unknown Shape!");
    }

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

    push();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);                // translate and rotate the rectangle
    fill(colour1);
    switch (shape){
      case RECTANGLE:
                      rect(0,0,w,h);
                      //setGradient(-int(w/2),-int(h/2),w,h, colour1, colour2, 2);
                      break;
      case CIRCLE:
                      ellipse(0,0,w,w);
                      stroke(0);
                      strokeWeight(2);
                      line(0,0,0,w/2);
                      break;
      case CARBODY:
                      //Fixture f = body.getFixtureList();
                      //PolygonShape ps = (PolygonShape) f.getShape();
                      //beginShape();
                      //for (int i = 0; i < ps.getVertexCount(); i++) {
                      //  Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
                      //  vertex(v.x,v.y);
                      //}
                      //endShape(CLOSE);
                      image(img, 0, 0, w, h);
                      break;
      default:        println("Unknown Shape!");
    }
    pop();
  }

}
