class Bullet {
  String shape;
  int xPos;
  int yPos;
  float bAngle;
  int size;
  float speed;
  color colour;
  
  Bullet() {
    shape = "ellipse";
    size = 10;
    speed = 20;
    colour = #890B0B;
  }
  
  Bullet(String shape,int xPos,int yPos, float bAngle,int size,float speed,color colour) {
    this.shape = shape;
    this.xPos = xPos;
    this.yPos = yPos;
    this.bAngle = bAngle;
    this.size = size;
    this.speed = speed;
    this.colour = colour;
  }
  
  void drawBullet() {
    push();
      fill(colour);
      rotate(bAngle);
      if (shape.equals("ellipse")) {
        ellipse(xPos, yPos, size, size);
      } else if (shape.equals("rect")) {
        rect(xPos, yPos, size, size);
      }
      xPos += speed;
    pop();
  }

  
}
