void mousePressed() {
  if (mouseButton == LEFT) {
    switch(selectedToolInt) {
       case 0: physicsObjects.add(new PhysicsObject(mouseX, mouseY, random(5,75), random(5,75), 0, randomColor(), randomColor(), false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, randomShape()));
               break;
       case 1: physicsObjects.add(new PhysicsObject(mouseX, mouseY, 60, 50, 0, randomColor(), randomColor(), false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, Shape.RECTANGLE));
               break;
       case 2: physicsObjects.add(new PhysicsObject(mouseX, mouseY, 60, 60, 0, randomColor(), randomColor(), false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, Shape.CIRCLE));
               break;
       case 3: physicsObjects.add(new PhysicsObject(mouseX, mouseY, 60, 60, 0, randomColor(), randomColor(), false, 0, Box2DBodyType.DYNAMIC, 1, 0.4, 0.5, Shape.TRIANGLE));
               break;
       case 4: trucks.add(new Truck(mouseX, mouseY, flipOnX));
               break;
       case 5: windmills.add(new Windmill(mouseX, mouseY, flipOnX));
               break;
       case 6: mouseClickCords = new Vec2(mouseX, mouseY);
               break;
       case 7: for (PhysicsObject p: physicsObjects) {if (p.contains(mouseX, mouseY)) {spring.bind(mouseX, mouseY, p);}};
               for (Truck t: trucks) {if (t.contains(mouseX, mouseY)) {spring.bind(mouseX, mouseY, t);}};
               for (Windmill w: windmills) {if (w.box1.contains(mouseX, mouseY)) {spring.bind(mouseX, mouseY, w.box1);}};
               break;
       case 8: destroyClickedEntity();
               break;
       case 9: mouseClickCords = new Vec2(mouseX, mouseY);
               break;
       default: println("undefined selectedToolInt");
    }
  } else if (mouseButton == RIGHT) {
    
  } else {
    println("Mouse clicked but not left or right click.");
  }
}

void mouseReleased() {
  if(mouseClickCords != null) {
    switch(selectedToolInt) {
       case 6: worldStaticObjects.add(new PhysicsObject(
                                    mouseClickCords.x+(mouseX-mouseClickCords.x)/2, 
                                    mouseClickCords.y+(mouseY-mouseClickCords.y)/2, 
                                    dist(mouseClickCords.x, mouseClickCords.y, mouseX, mouseY), 
                                    10, 
                                    atan2(mouseY - mouseClickCords.y, mouseX - mouseClickCords.x),
                                    #FFFFFF, 
                                    #FFFFFF, 
                                    false, 
                                    0, 
                                    Box2DBodyType.STATIC, 
                                    1, 
                                    0.6, 
                                    0.5, 
                                    Shape.RECTANGLE));
               break;
       case 9: if (!(abs(mouseClickCords.x - mouseX) == 0 || abs(mouseClickCords.y - mouseY) == 0)) {
                 physicsObjects.add(new PhysicsObject(
                                          mouseClickCords.x+(mouseX-mouseClickCords.x)/2, 
                                          mouseClickCords.y+(mouseY-mouseClickCords.y)/2, 
                                          abs(mouseClickCords.x - mouseX), 
                                          abs(mouseClickCords.y - mouseY), 
                                          0,
                                          randomColor(), 
                                          randomColor(), 
                                          false, 
                                          0, 
                                          Box2DBodyType.DYNAMIC, 
                                          1, 
                                          0.6, 
                                          0.5, 
                                          Shape.RECTANGLE));
               }
               break;
       default: println("undefined selectedToolInt");
    }
  }
  mouseClickCords = null;
  spring.destroy();
}

void keyPressed() {
  wakeUpBodies(physicsObjects);
  if (key == 'd' || key == 'D' ) {
    destroyEntities();
  }
  if (key == 'r' || key == 'R' ) {
    destroyEntities();
    destroyStaticObjects();
    destroyWindmills();
  }
  if (key == 'e' || key == 'E' ) {
    flipOnX = !flipOnX;
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
  }
  if (key == '2') {
    //setGravityStrength(9.8);
    gravityStrength = 9.8;
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
  if (key == '3') {
    //setGravityStrength(100);
    gravityStrength = 100;
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
  if (key == '4') {
    //setGravityDirection(0);
    //setGravityStrength(0);
    gravityDirection = 0;
    gravityStrength = 0;
    setGravity(gravityVector(gravityDirection,gravityStrength));
  }
  if (key == '5') {
    //setGravityDirection(random(360));
    //setGravityStrength(random(100));
    gravityDirection = random(360);
    gravityStrength = random(100);
    setGravity(gravityVector(gravityDirection,gravityStrength));
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
  if (keyCode == TAB) {
    mouseClickCords = null;
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) {
    adjustSelectedTool(1);
  } else if (event.getCount() < 0) {
    adjustSelectedTool(-1);
  }
  
  if (selectedToolInt == 7) {
    cursor(HAND);
  } else if (selectedToolInt == 8) {
    cursor(CROSS);
  } else {
    cursor(ARROW);
  }
}
