// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A list for all of our rectangles
ArrayList<Box> boxes;

Box2DProcessing box2d;    

void setup() {
  fullScreen();
  rectMode(CENTER);
  
  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  
  boxes = new ArrayList<Box>();
  //floor
  boxes.add(new Box(width/2, height, width, 5, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //left wall
  boxes.add(new Box(2, height/2, 2, height, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //right wall
  boxes.add(new Box(width-2, height/2, 2, height, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
  //platform
  boxes.add(new Box(width/2, height/1.5, width/4, 10, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, true));
}

void draw() {
  background(0);

  // We must always step through time!
  box2d.step();

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }
  
  if (mousePressed) {
    mousePressed();
  }
}
