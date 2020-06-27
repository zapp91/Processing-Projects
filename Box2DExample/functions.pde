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
            "Press [G] to Change Gravity. \n"
            ,20, 20);
  pop();
}

color randomColor() {
  return color(int(random(0,255)), int(random(0,255)), int(random(0,255)));
}

void destroyObjects(ArrayList<PhysicsObject> po) {
  for (PhysicsObject p: po) {
    box2d.destroyBody(p.body);
  }
  po.clear();
}

void destroyCars(ArrayList<Car> car) {
  for (Car c: car) {
    c.destroy();
  }
  car.clear();
}

void changeGravity(float x, float y) {
  box2d.setGravity(x,y);
}
