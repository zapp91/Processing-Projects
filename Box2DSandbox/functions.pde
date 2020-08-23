public enum Box2DBodyType {
    STATIC,
    DYNAMIC,
    KINEMATIC
}

public enum Shape {
    RECTANGLE,
    CIRCLE,
    TRIANGLE,
    CARBODY,
    FLOWER
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
  strokeWeight(1);

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
            "Trucks: "
            , width - 60, 20);
            
    text(   Math.round(frameRate) + "\n" +
            nf(gravityDirection, 0, 1) + "\n" +
            nf(gravityStrength, 0, 1) + "\n" +
            physicsObjects.size() + "\n" +
            trucks.size()
            , width - 10, 20);
  pop();
}

void displayHints() {
  push();
    fill(255);
    textAlign(LEFT);
    
    text(   "Scroll to change Selected Tool \n" +
            "LEFT CLICK to use Selected Tool \n" +
            "Press [SHIFT] to toggle the Grab Tool \n" +
            "Press [CTRL] to toggle Delete Tool \n" +
            "Press [E] to Flip Object \n" +
            "Press [D] to Delete Trucks and Physics Objects \n" +
            "Press [R] to Reset Game \n" +
            "Press [S] to Show/Hide Skins \n" +
            "Press [1] for Default Gravity Strength \n" +
            "Press [2] for Earth Gravity Strength \n" +
            "Press [3] for 100 Gravity Strength \n" +
            "Press [4] for Zero Gravity \n" +
            "Press [5] for Random Gravity and Direction \n" +
            "Press UP ARROW or DOWN ARROW to change Gravity Strength \n" +
            "Press LEFT ARROW or RIGHT RIGHT to change Gravity Direction \n" +
            "Press TAB to cancel the Draw Tool \n"
            , 10, 20);
  pop();
}

color randomColor() {
  return color(int(random(0,255)), int(random(0,255)), int(random(0,255)));
}

void destroyClickedEntity() {
  boolean objectClicked = false;
  int objectIndex = 0;
  
  for (int i = 0; physicsObjects.size() > i && !objectClicked; i++) {
    if(physicsObjects.get(i).contains(mouseX, mouseY)) {
      objectClicked = true;
      objectIndex = i;
    }
  };
  if(objectClicked) {box2d.destroyBody(physicsObjects.get(objectIndex).body); physicsObjects.remove(objectIndex);};
  objectClicked = false;
  objectIndex = 0;
  
  for (int i = 0; worldStaticObjects.size() > i && !objectClicked; i++) {
    if(worldStaticObjects.get(i).contains(mouseX, mouseY)) {
      objectClicked = true;
      objectIndex = i;
    }
  };
  if(objectClicked) {box2d.destroyBody(worldStaticObjects.get(objectIndex).body); worldStaticObjects.remove(objectIndex);};
  objectClicked = false;
  objectIndex = 0;
  
  for (int i = 0; windmills.size() > i && !objectClicked; i++) {
    if(windmills.get(i).box1.contains(mouseX, mouseY)) {
      objectClicked = true;
      objectIndex = i;
    }
  };
  if(objectClicked) {windmills.get(objectIndex).destroy(); windmills.remove(objectIndex);};
  objectClicked = false;
  objectIndex = 0;
  
  for (int i = 0; trucks.size() > i && !objectClicked; i++) {
    if(trucks.get(i).contains(mouseX, mouseY)) {
      objectClicked = true;
      objectIndex = i;
    }
  };
  if(objectClicked) {trucks.get(objectIndex).destroy(); trucks.remove(objectIndex);};
}

void destroyEntities() {
  for (PhysicsObject p: physicsObjects) {box2d.destroyBody(p.body);}
  for (Truck t: trucks) {t.destroy();}
  physicsObjects.clear();
  trucks.clear();
}

void destroyStaticObjects() {
  for (PhysicsObject w: worldStaticObjects) {box2d.destroyBody(w.body);}
  worldStaticObjects.clear();
}

void destroyWindmills() {
  for (Windmill w: windmills) {w.destroy();}
  windmills.clear();
}

void wakeUpBodies(ArrayList<PhysicsObject> po) {
  for (PhysicsObject p: po) {p.body.setAwake(true);}
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
  translate(width/2,170);
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

void displayToolBar() {
  push();
  translate(width/2, 45);
  textAlign(CENTER);
  text(currentTool + "\n" + "Reverse Object: " + flipOnX , 0, 50);
  
  for (int i = 1; i >= 5; i++) {
    
  }
  fill(0);
  stroke(#FF0000);
  rect(0,0, 70, 70);
  //scale(0.5);
  fill(255);
  displaySelectedObjectSilhouette(#9FFFFF, 0.5, true);
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

void adjustSelectedTool(int t) {
  if (selectedToolInt >= selectedToolStrings.length-1 && t >= 1) {
    selectedToolInt = 0;
  } else if (selectedToolInt <= 0 && t <= -1) {
    selectedToolInt = selectedToolStrings.length-1;
  } else {
    selectedToolInt = selectedToolInt + t;
  }
}

void displaySelectedObjectSilhouette(color silColor, float scalingFactor, boolean isDynamic) {
  
  push();
  //translate(mouseX,mouseY);
  noFill();
  stroke(silColor);
  strokeWeight(2);
  
  if(!deleteMode && !grabMode) {
    switch(selectedToolInt){
     case 0: if (isDynamic) scale(scalingFactor);
             rect(-25,0,40,60);
             ellipse(20,30,30,30);
             triangle(20,-30,0,10,40,10);
             break;
             
     case 1: rect(0,0,60,50);
             break;
             
     case 2: ellipse(0,0,60,60);
             break;
             
     case 3: triangle(0, 30, -30, -30, 30, -30);
             break;
             
     case 4: if (isDynamic) scale(scalingFactor/2);
             beginShape();
             vertex(110*flipOnXInt,33);
             vertex(120*flipOnXInt,30);
             vertex(116*flipOnXInt,-7);
             vertex(110*flipOnXInt,-10);
             vertex(65*flipOnXInt,-15);
             vertex(32*flipOnXInt,-35);
             vertex(-33*flipOnXInt,-37);
             vertex(-37*flipOnXInt,-15);
             vertex(-118*flipOnXInt,-15);
             vertex(-118*flipOnXInt,27);
             vertex(-37*flipOnXInt,33);
             endShape(CLOSE);
             ellipse(-70*flipOnXInt,35,40,40);
             ellipse(82*flipOnXInt,35,40,40);
             break;
             
     case 5: if (isDynamic) scale(scalingFactor/2);
             ellipse(0,0,200,200);
             arc(0, 0, 100, 100, radians(270), radians(360));
             arc(0, 0, 100, 100, PI / 2, 2 * PI / 2);
             fill(silColor);
             if (flipOnX) {
               triangle(10, 50, -10, 40, -10, 60);
               triangle(-10, -50, 10, -40, 10, -60);
             } else {
               triangle(50, 10, 40, -10, 60, -10);
               triangle(-50, -10, -40, 10, -60, 10);
             }
             break;
             
     case 6: if (isDynamic) scale(1/scalingFactor);
             fill(silColor);
             ellipse(0,0,10,10);
             strokeWeight(10);
             strokeCap(SQUARE);
             if(mouseClickCords != null && !isDynamic) {
               line(mouseClickCords.x-mouseX, mouseClickCords.y-mouseY, 0, 0);
             }
             break;        
     case 7: if (isDynamic) scale(1/scalingFactor);
             rect(0,0,10,10);
             if(!(mouseClickCords == null || abs(mouseClickCords.x-mouseX) == 0 || abs(mouseClickCords.y-mouseY) == 0 || isDynamic)) {
               rect((mouseClickCords.x-mouseX)/2, (mouseClickCords.y-mouseY)/2, abs(mouseClickCords.x-mouseX), abs(mouseClickCords.y-mouseY));
             }
             break;
             
     case 8: if (isDynamic) scale(1/scalingFactor);
             ellipse(0,0,10,10);
             if(!(mouseClickCords == null || abs(mouseClickCords.x-mouseX) == 0 || abs(mouseClickCords.y-mouseY) == 0 || isDynamic)) {
               ellipse((mouseClickCords.x-mouseX)/2, (mouseClickCords.y-mouseY)/2, dist(mouseClickCords.x, mouseClickCords.y, mouseX, mouseY), dist(mouseClickCords.x, mouseClickCords.y, mouseX, mouseY));
             }
             break;
     default: println("undefined selectedToolInt (silhouette function)");
    }
  } else if (deleteMode) {
    if (isDynamic) scale(scalingFactor * 2);
    stroke(#FF0000);
    ellipse(0,0,30,30);
    if (isDynamic) { 
      stroke(#FFFFFF);
      line(-10,0,10,0);
      line(0,-10,0, 10);
    }
  } else if (grabMode && isDynamic) {
    scale(scalingFactor/2);
    image(handImage, 0, 0);
  }
  pop();
}

void updateCurrentToolVar() {
  if (grabMode) {
    currentTool = "Grab Tool";
  } else if (deleteMode) {
    currentTool = "Delete Tool";
  } else {
    currentTool = selectedToolStrings[selectedToolInt];
  }
}

void displayCancelInstructions() {
  if(mouseClickCords != null) {
    push();
        textAlign(CENTER);
        fill(#FF0000);
        text( "Press [TAB] to cancel", width/2, height - 20);
    pop();
  }
}

void displayObjects() {
  push();
  translate(width/2, height/2);
  float scaleValue = 0;
  
  for (int i = numOfDisplayLevels - 1; i >= 1; i--) {
    push();
    scaleValue = (float)Math.pow(scaleFactor, i);
    scale(scaleValue);           //changes objects size and location
    scaleValue = scaleValue/1.5; //changes objects darkness and opacity.
    for (Windmill w: windmills) {w.display(scaleValue, scaleValue);}
    for (PhysicsObject b: boundaries) {b.display(scaleValue);}
    for (PhysicsObject w: worldStaticObjects) {w.display(scaleValue);}
    for (PhysicsObject p: physicsObjects) {p.display(scaleValue);}
    for (Truck t: trucks) {t.display(scaleValue);}
    pop();
  }
  
  for (Windmill w: windmills) {w.display();}
  for (PhysicsObject b: boundaries) {b.display();}
  for (PhysicsObject w: worldStaticObjects) {w.display();}
  for (PhysicsObject p: physicsObjects) {p.display();}
  for (Truck t: trucks) {t.display();}
  pop();
}
