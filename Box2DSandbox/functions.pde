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
            cars.size()
            , width - 10, 20);
  pop();
}

void displayHints() {
  push();
    fill(255);
    textAlign(LEFT);
    
    text(   "Scroll to change Selected Tool \n" +
            "LEFT CLICK to spawn Selected Tool \n" +
            "Press [E] to Flip Object \n" +
            "Press [D] to Delete Trucks and Physics Objects \n" +
            "Press [R] to Reset Game \n" +
            "Press [S] to Show/Hide Skins \n" +
            "Press [1] for Default Gravity Strength \n" +
            "Press [2] for Earth Gravity Strength \n" +
            "Press [3] for 100 Gravity Strength \n" +
            "Press [4] for No Gravity Strength nor Direction \n" +
            "Press [5] for Random Gravity and Direction \n" +
            "Press UP ARROW or DOWN ARROW to change Gravity Strength \n" +
            "Press LEFT ARROW or RIGHT RIGHT to change Gravity Direction \n"
            , 10, 20);
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

void destroyWindmills() {
  for (Windmill w: windmills) {
    w.destroy();
  }
  windmills.clear();
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
  translate(width/2,100);
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

void adjustSelectedTool(int t) {
  if (selectedToolInt >= selectedToolStrings.length-1 && t >= 1) {
    selectedToolInt = 0;
  } else if (selectedToolInt <= 0 && t <= -1) {
    selectedToolInt = selectedToolStrings.length-1;
  } else {
    selectedToolInt = selectedToolInt + t;
  }
}

void displaySelectedTool() {
  push();
  fill(255);
  textAlign(CENTER);
  
  text(   "Selected Tool: " + selectedToolStrings[selectedToolInt] + "\n" +
          "Reverse Object: " + flipOnX
          ,width/2, 20);
  pop();
}

void dashedCircle(float radius, int dashWidth, int dashSpacing) {
    int steps = 200;
    int dashPeriod = dashWidth + dashSpacing;
    boolean lastDashed = false;
    for(int i = 0; i < steps; i++) {
      boolean curDashed = (i % dashPeriod) < dashWidth;
      if(curDashed && !lastDashed) {
        beginShape();
      }
      if(!curDashed && lastDashed) {
        endShape();
      }
      if(curDashed) {
        float theta = map(i, 0, steps, 0, TWO_PI);
        vertex(cos(theta) * radius, sin(theta) * radius);
      }
      lastDashed = curDashed;
    }
    if(lastDashed) {
      endShape();
    }
}

void displaySelectedObjectSilhouette(color silColor) {
  
  push();
  translate(mouseX,mouseY);
  noFill();
  stroke(silColor);
  strokeWeight(2);

  switch(selectedToolInt){
   case 0: rect(-25,0,40,60);
           ellipse(20,30,30,30);
           triangle(20,-30,0,10,40,10);
           break;
           
   case 1: rect(0,0,60,50);
           break;
           
   case 2: ellipse(0,0,60,60);
           break;
           
   case 3: triangle(0, 30, -30, -30, 30, -30);
           break;
           
   case 4: beginShape();
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
           
   case 5: ellipse(0,0,200,200);
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
   default: println("undefined selectedToolInt");
  }
  pop();
}

void drawPetal(int x_, int y_, color colour, float petalSize){
  push();
  noStroke();
  fill(colour);
  float a = 4;
  beginShape();
  for(int i=0; i<360; i++)
  {
    float x = x_ + cos( radians(i) ) * petalSize;
    //The exponent a controls the shape of the curve
    float y = y_ + sin( radians(i) ) * pow(sin(radians(i)/2), a) * petalSize;
    vertex(x,y);
  }
  endShape();
  pop();
}
