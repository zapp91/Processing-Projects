public enum Box2DBodyType {
    STATIC,
    DYNAMIC,
    KINEMATIC
}

public enum Shape {
    RECTANGLE,
    CIRCLE,
    TRIANGLE,
    CARBODY
}

int randomPosNeg1() {
  return -1 + (int)random(2) * 2;
}

Shape randomShape() {
  int num = rand.nextInt(3);
  if (num == 0){
    return Shape.RECTANGLE;
  } else if (num == 1) {
    return Shape.CIRCLE;
  } else {
    return Shape.TRIANGLE;
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == 2) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

void displayData() {
  push();
    fill(255);
    textAlign(RIGHT);
    
    text(   "Frame Rate: \n" +
            "Gravity Direction: \n" +
            "Gravity Strength: \n" +
            "Physics Objects: \n" +
            "Trucks: ",
            width - 70, 20);
            
    text(   Math.round(frameRate) + "\n" +
            nf(gravityDirection, 0, 1) + "\n" +
            nf(gravityStrength, 0, 1) + "\n" +
            physicsObjects.size() + "\n" +
            cars.size()
            ,width - 20, 20);
  pop();
}

void displayHints() {
  push();
    fill(255);
    textAlign(LEFT);
    
    text(   "LEFT CLICK to spawn Objects \n" +
            "RIGHT CLICK to spawn Truck \n" +
            "Press [D] to Delete Objects \n" +
            "Press [S] to Show/Hide Skins \n" +
            "Press [1] for Default Gravity Strength \n" +
            "Press [2] for Earth Gravity Strength \n" +
            "Press [3] for 100 Gravity Strength \n" +
            "Press [4] for No Gravity Strength nor Direction \n" +
            "Press [5] for Random Gravity and Direction \n" +
            "Press UP ARROW or DOWN ARROW to change Gravity Strength \n" +
            "Press LEFT ARROW or RIGHT RIGHT to change Gravity Direction \n"
            ,20, 20);
  pop();
}

color randomColor() {
  return color(int(random(0,255)), int(random(0,255)), int(random(0,255)));
}

void destroyEntities() {
  for (PhysicsObject p: physicsObjects) {
    box2d.destroyBody(p.body);
  }
  for (Car c: cars) {
    c.destroy();
  }
  physicsObjects.clear();
  cars.clear();
}

void wakeUpBodies(ArrayList<PhysicsObject> po) {
  for (PhysicsObject p: po) {
    p.body.setAwake(true);
  }
}

void setGravity(Vec2 v) {
  box2d.setGravity(v.x, v.y);
}

Vec2 gravityVector(float gravityAngle,float gravityStrength) {
  return new Vec2(
    (-1*gravityStrength * cos((gravityAngle+90)*PI/180)),
    (-1*gravityStrength * sin((gravityAngle+90)*PI/180))
  );
}

void displayGravityDial() {
  Vec2 g = box2d.world.getGravity();
  push();
  translate(width/2,60);
  ellipse(0,0,8,8);
  noFill();
  stroke(#FFFFFF);
  strokeWeight(2);
  ellipse(0,0,100,100);
  stroke(#FF0000);
  
  if (g.x == 0 && g.y == 0) {
    ellipse(0,0,40,40);
  } else {
    line(0,0,g.x/2,-1*g.y/2);
    translate(g.x/2,-1*g.y/2);
    rotate(atan2(-1*g.y/2,g.x/2));
    fill(#FF0000);
    beginShape();
    vertex(3,0);
    vertex(-9,6);
    vertex(-7,0);
    vertex(-9,-6);
    endShape(CLOSE);
  }
  pop();
}

void adjustGravityDirection(float d) {
  if (gravityDirection >= 360 && d >= 1) {
    gravityDirection = 0;
  } else if (gravityDirection <= 0 && d <= -1) {
    gravityDirection = 360;
  } else {
    gravityDirection = gravityDirection + d;
  }
}

void adjustGravityStrength(float s) {  
  if (gravityStrength >= 150 && s >= 1) {
    gravityStrength = 150;
  } else if (gravityStrength <= 0 && s <= -1) {
    gravityStrength = 0;
  } else {
    gravityStrength = gravityStrength + s;
  }
}
