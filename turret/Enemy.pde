class Enemy {
  int xPos;
  int yPos;
  float bAngle;
  int size;
  float speed;
  color colour;
  
  Enemy() {
    xPos = int(random(200, 400));
    yPos = 0;
    bAngle = 0;
    size = 50;
    speed = 1 * randPosNeg();
    colour = #FF0000;
  }
  
  void drawEnemy() {
    push();
      bAngle += radians(speed);
      rotate(bAngle);
      translate(xPos, yPos);
      fill(colour);
      ellipse(0, 0, size, size);
    pop();
  }
  
}
