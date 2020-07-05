class Player {
  Color pColor;
  PVector location;
  int size;
  float angle;
  int activeSpeed;
  int defaultSpeed;
  int sprintBoost;
  boolean up, down, left, right, sprint = false;
  String activeTool;

  Player(Color pColor,int x,int y,int size,int defaultSpeed,int sprintBoost, String activeTool) {
    this.pColor = pColor;
    this.location = new PVector(x,y);
    this.size = size;
    this.defaultSpeed = defaultSpeed;
    this.sprintBoost = sprintBoost;
    this.activeTool = activeTool;
  }

  void movePlayer() {
    if (sprint == true) {
      activeSpeed = defaultSpeed + sprintBoost;
    } else if (up == true || down == true || left == true || right == true) {
      activeSpeed = defaultSpeed;
    } else {
      activeSpeed = 0;
    }
    if (up == true) {location.y -= activeSpeed;}
    if (down == true) {location.y += activeSpeed;}
    if (left == true) {location.x -= activeSpeed;}
    if (right == true) {location.x += activeSpeed;}
  }
  
  void drawPlayer() {
    push();
      fill(pColor.getRGB());
      ellipse(width/2, height/2, size, size);
    pop();
  }
}
