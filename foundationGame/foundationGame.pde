import java.awt.Color; //<>//

//int objectNum = 0;

Player player;
ArrayList<Object> objects = new ArrayList<Object>();
ArrayList<Tool> tools = new ArrayList<Tool>();

void setup() {
  size(1200,1200);
  //fullScreen();
  rectMode(CENTER);
  player = new Player(Color.decode("#F7A01B"), 100, 100, 50, 5, 5, "foundation");
  objects.add(new Object("ellipse", 0, 0, 25, 0, Color.red));
  tools.add(new Tool("block", "rectangle", Color.green, 0, 0, 100, 100));
}

void draw() { 
  background(0);

  displayObjects();

  player.movePlayer(); //<>//

  tools.get(0).drawTool();

  player.drawPlayer();

  objectCollisionDetection();
  //player-mouse line
  push();
    stroke(Color.blue.getRGB());
    line(width/2, height/2, mouseX, mouseY);
  pop();
  
  displayData();
}
