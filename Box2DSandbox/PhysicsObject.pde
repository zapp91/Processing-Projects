class PhysicsObject {
  //Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;      

  float x,y,w,h,angle;
  color colour1;
  color colour2;
  boolean noFill;
  int strokeWeight;
  ArrayList<ArrayList<Vec2>> vecArrays = new ArrayList<ArrayList<Vec2>>();
  Shape shape;
  PImage img;
  boolean flipImageOnX;
  int posNeg1;
  int collisionGroup;
  
  PhysicsObject(float x, float y, float w, float h, float angle, color colour1, color colour2, boolean noFill, int strokeWeight, Box2DBodyType bt, float density, float friction, float restitution, Shape shape, int collisionGroup) {
    this(x,y,w,h,angle,colour1,colour2,noFill,strokeWeight,bt,density,friction,restitution,shape,collisionGroup,null,false);
  }
  
  PhysicsObject(float x, float y, float w, float h, float angle, color colour1, color colour2, boolean noFill, int strokeWeight, Box2DBodyType bt, float density, float friction, float restitution, Shape shape, int collisionGroup, PImage img) {
    this(x,y,w,h,angle,colour1,colour2,noFill,strokeWeight,bt,density,friction,restitution,shape,collisionGroup,img,false);
  }

  PhysicsObject(float x, float y, float w, float h, float angle, color colour1, color colour2, boolean noFill, int strokeWeight, Box2DBodyType bt, float density, float friction, float restitution, Shape shape, int collisionGroup, PImage img, boolean flipImageOnX) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.angle = angle;
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.noFill = noFill;
    this.strokeWeight = strokeWeight;
    this.shape = shape;
    this.img = img;
    this.flipImageOnX = flipImageOnX;
    this.posNeg1 = (flipImageOnX) ? -1 : 1;

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
    bd.angle = -angle;
    this.body = box2d.createBody(bd);

    FixtureDef fd = new FixtureDef();
    ArrayList<Vec2> vertices = new ArrayList<Vec2>();

    switch (shape) {
      case RECTANGLE:
                      PolygonShape ps = new PolygonShape();
                      ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));
                      fd.shape = ps;
                      fd.density = density;
                      fd.friction = friction;
                      fd.restitution = restitution;   
                      fd.filter.groupIndex = collisionGroup;
                      body.createFixture(fd);
                      break;
      case CIRCLE:
                      CircleShape cs = new CircleShape();
                      cs.m_radius = box2d.scalarPixelsToWorld(w/2);
                      fd.shape = cs;
                      fd.density = density;
                      fd.friction = friction;
                      fd.restitution = restitution;     
                      fd.filter.groupIndex = collisionGroup;
                      body.createFixture(fd);
                      break;
      case TRIANGLE:
                      vertices.add(box2d.vectorPixelsToWorld(new Vec2(0, h/2)));
                      vertices.add(box2d.vectorPixelsToWorld(new Vec2(-w/2, -h/2)));
                      vertices.add(box2d.vectorPixelsToWorld(new Vec2(w/2, -h/2)));
                      
                      PolygonShape t = new PolygonShape();
                      t.set(vertices.toArray(new Vec2[0]), vertices.size());
                      fd.shape = t;
                      fd.density = density;
                      fd.friction = friction;
                      fd.restitution = restitution; 
                      fd.filter.groupIndex = collisionGroup;
                      body.createFixture(fd);
                      break;
      case CARBODY:
                      ArrayList<Vec2> body1 = new ArrayList<Vec2>(); 
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(110*posNeg1, 33))); //0
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(120*posNeg1, 30))); //1
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(116*posNeg1, -7))); //2
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(110*posNeg1, -10))); //3
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(65*posNeg1, -15))); //4
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(-37*posNeg1, -15)));
                      body1.add(box2d.vectorPixelsToWorld(new Vec2(-37*posNeg1, 33))); 
                      vecArrays.add(body1); 
                
                      ArrayList<Vec2> body2 = new ArrayList<Vec2>(); 
                      body2.add(box2d.vectorPixelsToWorld(new Vec2(-37*posNeg1, -15))); //7
                      body2.add(box2d.vectorPixelsToWorld(new Vec2(65*posNeg1, -15)));
                      body2.add(box2d.vectorPixelsToWorld(new Vec2(32*posNeg1, -35))); //5
                      body2.add(box2d.vectorPixelsToWorld(new Vec2(-33*posNeg1, -37))); //6
                      vecArrays.add(body2); 
                
                      ArrayList<Vec2> body3 = new ArrayList<Vec2>(); 
                      body3.add(box2d.vectorPixelsToWorld(new Vec2(-37*posNeg1, 33)));
                      body3.add(box2d.vectorPixelsToWorld(new Vec2(-37*posNeg1, 15)));
                      body3.add(box2d.vectorPixelsToWorld(new Vec2(-118*posNeg1, 15)));
                      body3.add(box2d.vectorPixelsToWorld(new Vec2(-118*posNeg1, 27))); //8
                      vecArrays.add(body3);     
                      
                      ArrayList<Vec2> body4 = new ArrayList<Vec2>(); 
                      body4.add(box2d.vectorPixelsToWorld(new Vec2(-118*posNeg1, 15))); //10
                      body4.add(box2d.vectorPixelsToWorld(new Vec2(-110*posNeg1, 15)));
                      body4.add(box2d.vectorPixelsToWorld(new Vec2(-110*posNeg1, -13))); //9
                      body4.add(box2d.vectorPixelsToWorld(new Vec2(-118*posNeg1, -13)));
                      vecArrays.add(body4);     
                      
                      for (ArrayList<Vec2> b: vecArrays) {
                        PolygonShape pShape = new PolygonShape();
                        pShape.set(b.toArray(new Vec2[0]), b.size());
                        fd.shape = pShape;
                        fd.density = density;
                        fd.friction = friction;
                        fd.restitution = restitution;
                        fd.filter.groupIndex = collisionGroup;
                        body.createFixture(fd);
                      } 
                      break;
      case FLOWER:
      default:        println("Unknown Shape!");
    }
  }

  boolean contains(float x, float y) {
    return body.getFixtureList().testPoint(box2d.coordPixelsToWorld(x, y));
  }

  void display() {
    display(1, 1);
  }
  
  void display(float darknessScaleFactor) {
    display(darknessScaleFactor, 1);
  }
  
  void display(float darknessScaleFactor, float opacityScaleFactor) {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();

    push();
    translate(pos.x-width/2,pos.y-height/2);    // Using the Vec2 position and float angle to
    rotate(-a);                // translate and rotate the rectangle
    //fill(colour1, 255*opacityScaleFactor);
    fill(lerpColor(0, lerpColor(#000000, colour1, darknessScaleFactor), opacityScaleFactor));
    if (noFill == true) noFill();
    stroke(colour2);
    strokeWeight(strokeWeight);
    if (strokeWeight == 0) noStroke();
    
    
    switch (shape){
      case RECTANGLE:
 
                      rect(0,0,w,h);
                      //setGradient(-int(w/2),-int(h/2),w,h, colour1, colour2, 2); //generate this as a Graphic variable instead and add a showGraphic boolean.
                      break;
      case CIRCLE:
                      ellipse(0,0,w,w);
                      stroke(0);
                      strokeWeight(2);
                      //line(0,0,0,w/2);
                      break;
      case TRIANGLE:
                      PolygonShape ps = (PolygonShape) body.getFixtureList().getShape();
                      beginShape();
                      for (int i = 0; i < ps.getVertexCount(); i++) {
                        Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
                        vertex(v.x,v.y);
                      }
                      endShape(CLOSE);
                      break;
      case CARBODY: 
                      if (!showSkins) {
                        for (ArrayList<Vec2> b: vecArrays) {
                          beginShape();
                          for (int i = 0; i < b.size(); i++) {
                            Vec2 v = box2d.vectorWorldToPixels(b.get(i));
                            vertex(v.x,v.y);
                          }
                          endShape(CLOSE);
                        }
                      }
                      break;
      default:        println("Unknown Shape!");
    }
    
    if(showSkins && img != null) {
      if (flipImageOnX) scale(-1,1);
      image(img, 0, 0, w, h);
    }
    
    pop();
  }
  
  void displayTrunkShroud() {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();

    push();
    translate(pos.x -width/2, pos.y -height/2);
    rotate(-a);
    fill(#000000);
    rect(-73*posNeg1,13,70,30);
    pop();
  }

}
