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

PImage truckBodyImage;
PImage tireImage;
PImage handImage;
PImage tntImage;
PImage explosionImage;

Random rand;
boolean invertDarknessScaling;
boolean disableDarknessScaling;
boolean showSkins;
boolean flipOnX;
int flipOnXInt;
boolean deleteMode;
boolean grabMode;
String currentTool;

int numOfDisplayLevels = 12;
float scaleFactor = 0.998;

int selectedToolInt;
String[] selectedToolStrings = {"Spawn Random Shapes", "Spawn Rectangle", "Spawn Circle", "Spawn Triangle", "Spawn Truck", "Spawn Windmill", "Draw Line", "Draw Square", "Draw Circle", "Spawn Bomb"};
Vec2 mouseClickCords;

ArrayList<PhysicsObject> boundaries;
ArrayList<PhysicsObject> worldStaticObjects;
ArrayList<PhysicsObject> physicsObjects;
ArrayList<Windmill> windmills;
ArrayList<Truck> trucks;
ArrayList<Bomb> bombs;
ArrayList<PhysicsObject> bombParticles;
ArrayList<BombExplosionAnimation> bombExplosionAnimations;

Spring spring;

void setup() {
  //fullScreen();
  fullScreen(P2D);
  //fullScreen(FX2D);
  //size(2000,1000, P2D);  
  smooth(4);
  
  rectMode(CENTER);
  imageMode(CENTER);
  shapeMode(CENTER);
  
  rand = new Random();
  gravityDirection = 0;
  gravityStrength = 40;
  gravity = gravityVector(gravityDirection, gravityStrength);

  box2d = new Box2DProcessing(this);  
  box2d.createWorld(gravity);
  box2d.listenForCollisions();
  
  boundaries = new ArrayList<PhysicsObject>();
  worldStaticObjects = new ArrayList<PhysicsObject>();
  physicsObjects = new ArrayList<PhysicsObject>();
  windmills = new ArrayList<Windmill>();
  trucks = new ArrayList<Truck>();
  bombs = new ArrayList<Bomb>();
  bombParticles = new ArrayList<PhysicsObject>();
  bombExplosionAnimations = new ArrayList<BombExplosionAnimation>();
  
  spring = new Spring();
  
  //floor, roof, left wall, right wall
  boundaries.add(new PhysicsObject(width/2, height, width+10, 10, 0, #FFFFFF, #FFFFFF, false, 0, Box2DBodyType.STATIC, 1, 0.4, 0.5, Shape.RECTANGLE, -1));
  boundaries.add(new PhysicsObject(width/2, 0, width+10, 10, 0, #4BFF00, #FFFFFF, false, 0, Box2DBodyType.STATIC, 1, 0.4, 0.5, Shape.RECTANGLE, -1));
  boundaries.add(new PhysicsObject(0, height/2, 10, height+10, 0, #00FFF9, #FFFFFF, false, 0, Box2DBodyType.STATIC, 1, 0.4, 0.5, Shape.RECTANGLE, -1));
  boundaries.add(new PhysicsObject(width, height/2, 10, height+10, 0, #7A08FF, #FFFFFF, false, 0, Box2DBodyType.STATIC, 1, 0.4, 0.5, Shape.RECTANGLE, -1));

  truckBodyImage = loadImage("dodge4.png");
  tireImage = loadImage("tire2.png");
  handImage = loadImage("hand-cursor-inverted.png");
  tntImage = loadImage("tnt.png");
  explosionImage = loadImage("explosion.png");
  
  invertDarknessScaling  = false;
  disableDarknessScaling  = false;
  showSkins = true;
  selectedToolInt = 0;
  flipOnX = false;
  flipOnXInt = 1;
  deleteMode = false;
  grabMode = false;
}

void draw() {
  background(0);
  //box2d.step(1.0f/60,20,20);
  box2d.step();
  spring.update(mouseX,mouseY);
  destroyBombParticlesAfterMilliseconds(1000);
  destroyBombExplosionsAfterMilliseconds(400);
  
  flipOnXInt = (flipOnX) ? -1 : 1;

  updateCurrentToolVar();
  
  displayObjects();
  displayGravityDial();
  displayToolBar();
  displayData();
  displayHints();
  push();
  translate(mouseX,mouseY);
  displaySelectedObjectSilhouette(#9FFFFF, 1.0, false);
  pop();
  displayCancelInstructions();
  spring.display();
 
  

  if ((selectedToolInt == 0 || grabMode || deleteMode) && mousePressed) {
    if (mouseButton == LEFT) mousePressed();
  } else if(spring.mouseJoint != null) {
    spring.destroy();
  }
  
  if (keyPressed) {
    if (keyCode == UP || 
        keyCode == DOWN || 
        keyCode == LEFT || 
        keyCode == RIGHT || 
        key == '-' || key == '_' || 
        key == '=' || key == '+' || 
        key == '[' || key == '{' || 
        key == ']' || key == '}'
        ) keyPressed();
  }
}
