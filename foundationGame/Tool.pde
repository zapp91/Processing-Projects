class Tool {
  String type;
  String shape;
  Color tColor;
  int xPos;
  int yPos;
  int tWidth;
  int tHeight;
  
  float angle;
  int scroll = 0;
  

  Tool(String type, String shape, Color tColor, int xPos, int yPos, int tWidth, int tHeight) {
    this.type = type;
    this.shape = shape;
    this.tColor = tColor;
    this.xPos = xPos;
    this.yPos = yPos;
    this.tWidth = tWidth;
    this.tHeight = tHeight;
  }

  void drawTool() { 
    angle = atan2(mouseY - height/2, mouseX - width/2) + radians(scroll);
    push();
      translate(mouseX, mouseY);
      rotate(angle);
      fill(tColor.getRGB(), 100);
      rect(0, 0, 100, 100);
    pop();
  }
}
