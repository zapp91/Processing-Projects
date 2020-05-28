void displayData() {
  push();
    textAlign(RIGHT);
    
    text(
      "Frames: \n" +
      "PlayerX: \n" +
      "PlayerY: \n" +
      "PlayerSpeed: \n" +
      "Objects: ",
      width - 70, 20);
      
    text(
      Math.round(frameRate) + "\n" +
      player.location.x + "\n" +
      player.location.y + "\n" +
      player.activeSpeed + "\n" +
      objects.size(),
      width - 20, 20);
      
  pop();
}

void displayObjects() {
  push();
    //move objects on screen relational to player location
    translate(-player.location.x, -player.location.y);
    if (objects != null) {
      for (Object o: objects) {
        o.drawObject();
      }
    }
  pop();
}

void objectCollisionDetection() {
  if (objects != null) {
    player.pColor = Color.orange;
    for (Object o: objects) {
      if (PVector.dist(o.location,player.location) < (o.size+player.size)/2) {
        player.pColor = Color.white;
      }
    }
  }
}
