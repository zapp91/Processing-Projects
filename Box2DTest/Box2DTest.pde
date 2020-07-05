import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2D;

ArrayList<PhysicsObject> po;

void setup() {
  size(1000, 1000);
  rectMode(CENTER);
  shapeMode(CENTER);
  box2D = new Box2DProcessing(this);
  box2D.createWorld();
  
  po = new ArrayList<PhysicsObject>();
}

void draw() {
  box2D.step();
  background(0);
  
  displayPhysicsObjects();
  
}
