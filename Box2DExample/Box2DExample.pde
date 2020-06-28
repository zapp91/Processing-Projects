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
import java.util.Random;

Box2DProcessing box2d;  

float gravityDirection;
float gravityStrength;
Vec2 gravity;

PImage carBodyImage;
PImage tireImage;
Random rand;
boolean showSkins;

ArrayList<PhysicsObject> worldStaticObjects;
ArrayList<PhysicsObject> physicsObjects;
ArrayList<Windmill> windmills;
ArrayList<Car> cars;

void setup() {
  fullScreen();
  rectMode(CENTER);
  imageMode(CENTER);
  shapeMode(CENTER);
  
  rand = new Random();
  gravityDirection = 0;
  gravityStrength = 40;
  gravity = gravityVector(gravityDirection, gravityStrength);

  box2d = new Box2DProcessing(this);  
  box2d.createWorld(gravity);
  
  worldStaticObjects = new ArrayList<PhysicsObject>();
  physicsObjects = new ArrayList<PhysicsObject>();
  windmills = new ArrayList<Windmill>();
  cars = new ArrayList<Car>();
  
  //floor
  worldStaticObjects.add(new PhysicsObject(width/2, height, width, 5, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.RECTANGLE));
  //roof
  worldStaticObjects.add(new PhysicsObject(width/2, 0, width, 5, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.RECTANGLE));
  //left wall
  worldStaticObjects.add(new PhysicsObject(2, height/2, 2, height, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.RECTANGLE));
  //right wall
  worldStaticObjects.add(new PhysicsObject(width-2, height/2, 2, height, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.RECTANGLE));
  //platform
  worldStaticObjects.add(new PhysicsObject(width/2, height/1.5, width/4, 10, #FFFFFF, #FFFFFF, Box2DBodyType.STATIC, 1, 0.3, 0.5, Shape.RECTANGLE));
  
  windmills.add(new Windmill(width*0.25, height/2));
  windmills.add(new Windmill(width*0.50, height/2));
  windmills.add(new Windmill(width*0.75, height/2));
  
  carBodyImage = loadImage("dodge3.png");
  tireImage = loadImage("tire.png");
  showSkins = true;
}

void draw() {
  background(0);
  box2d.step(1.0f/60,20,20);
  //box2d.step();

  for (PhysicsObject w: worldStaticObjects) {
    w.display();
  }

  for (PhysicsObject p: physicsObjects) {
    p.display();
  }

  for (Windmill w: windmills) {
    w.display();
  }
  
  for (Car c: cars) {
    c.display();
  }
  
  displayGravityDial();

  displayData();
  displayHints();
  
  if (mousePressed) {
    if (mouseButton == LEFT) mousePressed();
  }
  if (keyPressed) {
    if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT ) keyPressed();
  }
}
