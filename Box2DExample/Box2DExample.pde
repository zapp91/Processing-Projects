// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

ArrayList<PhysicsObject> physicsObjects;
ArrayList<Windmill> windmills;
ArrayList<Car> cars;

Box2DProcessing box2d;    

void setup() {
  fullScreen();
  rectMode(CENTER);
  
  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  
  physicsObjects = new ArrayList<PhysicsObject>();
  windmills = new ArrayList<Windmill>();
  cars = new ArrayList<Car>();
  
  //floor
  physicsObjects.add(new PhysicsObject(width/2, height, width, 5, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //roof
  physicsObjects.add(new PhysicsObject(width/2, 0, width, 5, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //left wall
  physicsObjects.add(new PhysicsObject(2, height/2, 2, height, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //right wall
  physicsObjects.add(new PhysicsObject(width-2, height/2, 2, height, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //platform
  physicsObjects.add(new PhysicsObject(width/2, height/1.5, width/4, 10, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  
  windmills.add(new Windmill(width*0.25, height/2));
  windmills.add(new Windmill(width*0.50, height/2));
  windmills.add(new Windmill(width*0.75, height/2));
}

void draw() {
  background(0);

  // We must always step through time!
  box2d.step();

  // Display all the boxes
  for (PhysicsObject p: physicsObjects) {
    p.display();
  }
  
  // Display all the windmills
  for (Windmill w: windmills) {
    w.display();
  }
  
  for (Car c: cars) {
    c.display();
  }

  displayData();
  
  if (mousePressed) {
    mousePressed();
  }
}
