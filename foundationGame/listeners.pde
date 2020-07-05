void mouseWheel(MouseEvent event) {
  tools.get(0).scroll += event.getCount() * 15;
}

void keyPressed() {
  //println(key + " (" + keyCode + ")");
  if (key == 'w' || key == 'W' ) {
    player.up = true;
  }
  if (key == 's'  || key == 'S' ) {
    player.down = true;
  }
  if (key == 'a'  || key == 'A' ) {
    player.left = true;
  }
  if (key == 'd'  || key == 'D' ) {
    player.right = true;
  }
  if (keyCode == 16) {
    player.sprint = true;
  }

  if (key == 'l') {
    if (objects != null) {
      for (Object o : objects) {
        println("Object#: " + o.objectNum + " x: " + o.location.x + " y: " + o.location.y + " angle: " + o.angle);
      }
    }
  }
}

void keyReleased() {
  //println(key + " key released");
  if (key == 'w'  || key == 'W' ) {
    player.up = false;
  }
  if (key == 's'  || key == 'S' ) {
    player.down = false;
  }
  if (key == 'a'  || key == 'A' ) {
    player.left = false;
  }
  if (key == 'd'  || key == 'D' ) {
    player.right = false;
  }
  //if (key == 'x'  || key == 'X' ) {
  //  player.right = false;
  //}
  if (keyCode == 16) {
    player.sprint = false;
  }
}

void mousePressed() {
  //println("mouseX: " + mouseX + " mouseY: " + mouseY + " angle: " + tools.get(0).angle);
  objects.add(new Object( "rectangle", mouseX + player.location.x - width/2, mouseY + player.location.y - height/2, 100, tools.get(0).angle, Color.BLUE));
}
