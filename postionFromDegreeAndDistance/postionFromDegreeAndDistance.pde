float angle;
PVector ANewPosition;

void setup() {
  size(1000,1000);
  
}

void draw() {
  background(0);
  
  angle = atan2(mouseY - height/2, mouseX - width/2);
  println(angle);
  println(degrees(angle));
  
  ANewPosition = newPosition(new PVector(width/2, height/2), angle, 100);
  println(ANewPosition);
  
  fill(#FFFFFF);
  ellipse(width/2, height/2, 50, 50);
  
  fill(#D8FF00);
  ellipse(mouseX, mouseY, 10, 10);
  
  fill(#10FF00);
  ellipse(ANewPosition.x,ANewPosition.y,50,50);
  
  pushStyle();
  stroke(#FFB908);
  strokeWeight(5);
  line(width/2, height/2, ANewPosition.x,ANewPosition.y);
  popStyle();

}

PVector newPosition(PVector initialPosition,float direction,int distance) {
  return new PVector(
    initialPosition.x + (distance * cos(direction)),
    initialPosition.y + (distance * sin(direction))
  );
}
