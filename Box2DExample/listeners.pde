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
    destroyEntities();
  }
  if (key == 's' || key == 'S' ) {
    if (showSkins)
      showSkins = false;
    else
      showSkins = true;
  }
  if (key == '1') {
    //setGravityStrength(40);
    gravityStrength = 40;
    setGravity(gravityVector(gravityDirection,gravityStrength));
    wakeUpBodies(physicsObjects);
  }
  if (key == '2') {
    //setGravityStrength(9.8);
    gravityStrength = 9.8;
    setGravity(gravityVector(gravityDirection,gravityStrength));
    wakeUpBodies(physicsObjects);
  }
  if (key == '3') {
    //setGravityStrength(100);
    gravityStrength = 100;
    setGravity(gravityVector(gravityDirection,gravityStrength));
    wakeUpBodies(physicsObjects);
  }
  if (key == '4') {
    //setGravityDirection(0);
    //setGravityStrength(0);
    gravityDirection = 0;
    gravityStrength = 0;
    setGravity(gravityVector(gravityDirection,gravityStrength));
    wakeUpBodies(physicsObjects);
  }
  if (key == '5') {
    //setGravityDirection(random(360));
    //setGravityStrength(random(100));
    gravityDirection = random(360);
    gravityStrength = random(100);
    setGravity(gravityVector(gravityDirection,gravityStrength));
    wakeUpBodies(physicsObjects);
  }
  if (keyCode == UP) {
    adjustGravityStrength(1);
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
  if (keyCode == DOWN) {
    adjustGravityStrength(-1);
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
  if (keyCode == RIGHT) {
    adjustGravityDirection(1);
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
  if (keyCode == LEFT) {
    adjustGravityDirection(-1);
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
}
