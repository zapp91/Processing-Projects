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
            "Gravity X: \n" +
            "Gravity Y: \n" +
            "Physics Objects: \n" +
            "Dodge Rams: ",
            width - 70, 20);
            
    text(   Math.round(frameRate) + "\n" +
            nf(box2d.world.getGravity().x, 0, 1) + "\n" +
            nf(box2d.world.getGravity().y, 0, 1) + "\n" +
            physicsObjects.size() + "\n" +
            cars.size()
            ,width - 20, 20);
  pop();
}

void displayHints() {
  push();
    fill(255);
    textAlign(LEFT);
    
    text(   "Press [D] to Delete Objects. \n" +
            "Press [1] for Default Gravity. \n" +
            "Press [2] for Earth Gravity. \n" +
            "Press [3] for No Gravity. \n" +
            "Press [4] for Random Gravity. \n"
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

void changeGravity(float x, float y) {
  box2d.setGravity(x,y);
}
