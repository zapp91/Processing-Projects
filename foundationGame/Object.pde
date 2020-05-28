static class Countable {
  static int objNum = 0;
}

class Object extends Countable{
  int objectNum;
  String objectType;
  PVector location;
  int size;
  float angle;
  Color c;

  Object() {
    objectNum = objNum++;
    objectType = "rectangle";
    location = new PVector(random(width), random(height));
    size = 100;
    angle = random(5);
    c = Color.white;
  }

  Object(String type, float x, float y, int size, float a, Color col) {
    objectNum = objNum++;
    objectType = type;
    location = new PVector(x,y);
    this.size = size;
    angle = a;
    c = col;
  }

  void drawObject() {
    push();
      translate(location.x + width/2, location.y + height/2);
      rotate(angle);
      fill(c.getRGB(), 200);
      if (objectType == "rectangle") {
        rect(0, 0, size, size);
      } else if (objectType == "ellipse") {
        ellipse(0, 0, size, size);
      }
    pop();
  }
  
}
