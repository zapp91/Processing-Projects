public enum Box2DBodyType {
    STATIC,
    DYNAMIC,
    KINEMATIC
}

public enum Shape {
    RECTANGLE,
    CIRCLE,
    CARBODY
}

boolean randomBool() {
  int num = -1 + (int)random(2) * 2;
  if (num == 1) {
    return true;
  } else {
    return false;
  }
}

int randomPosNeg1() {
  return -1 + (int)random(2) * 2;
}

Shape randomShape() {
  if (randomBool()){
    return Shape.RECTANGLE;
  } else {
    return Shape.CIRCLE;
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
    
    text(
      "Physics Objects: " + "\n" +
      "Dodge Rams: ",
      width - 70, 20);
      
    text(
      physicsObjects.size() + "\n" +
      cars.size(),
      width - 20, 20);
      
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
