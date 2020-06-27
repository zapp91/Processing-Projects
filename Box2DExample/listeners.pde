void mousePressed() {
  if (mouseButton == LEFT) {
    physicsObjects.add(new PhysicsObject(mouseX, mouseY, random(5,75), random(5,75), randomColor(), randomColor(), Box2DBodyType.DYNAMIC, 1, 0.3, 0.5, randomShape()));
  } else if (mouseButton == RIGHT) {
    cars.add(new Car(mouseX, mouseY));
  } else {
    println("Mouse clicked but not left or right click.");
  }
}

void keyPressed() {
  if (key == 'd' || key == 'D' ) {
    destroyObjects(physicsObjects);
    destroyCars(cars);
  }
  if (key == 'g' || key == 'G' ) {
    changeGravity(random(40)*randomPosNeg1(), random(40)*randomPosNeg1());
  }
}
