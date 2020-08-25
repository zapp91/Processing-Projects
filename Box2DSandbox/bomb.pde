//class Bomb {

//  Body body;
  
//  float x,y,w,h,angle;
//  color colour1;
//  int numRays = 50;

//  Bomb() {
    
//  }

//  void createRayParticles() {
//    for (int i = 0; i < numRays; i++) {
//      float angle = radians((i / (float)numRays) * 360);
//      Vec2 rayDir( sinf(angle), cosf(angle) );
  
//      BodyDef bd = new BodyDef();
//      bd.type = BodyType.DYNAMIC;
//      bd.fixedRotation = true; // rotation not necessary
//      bd.bullet = true; // prevent tunneling at high speed
//      bd.linearDamping = 10; // drag due to moving through air
//      bd.gravityScale = 0; // ignore gravity
//      bd.position = center; // start at blast center
//      bd.linearVelocity = blastPower * rayDir;
//      this.body = box2d.createBody(bd);
  
//      CircleShape cs = new CircleShape();
//      cs.m_radius = 0.05; // very small
  
//      b2FixtureDef fd;
//      fd.shape = cs;
//      fd.density = 60 / (float)numRays; // very high - shared across all particles
//      fd.friction = 0; // friction not necessary
//      fd.restitution = 0.99f; // high restitution to reflect off obstacles
//      fd.filter.groupIndex = -1; // particles should not collide with each other
//      body.CreateFixture(fd);
//    }
//  }
  
//  void display() {
    
//  }

//}
