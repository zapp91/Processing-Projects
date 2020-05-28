PVector center;
float angle;
float radius;

void setup() {
  size(500, 500);
  center = new PVector(width/2, height/2);

  //get the initial point
  //for you, this would be the initial location of the object
  PVector point = new PVector(random(width), random(height));

  //find the angle between the points
  float deltaX = center.x - point.x;
  float deltaY = center.y - point.y;
  angle = atan2(deltaX, deltaY);

  //find the radius of the circle
  radius = dist(center.x, center.y, point.x, point.y);

}

void draw() {
  background(0);

  //draw the center point
  ellipse(center.x, center.y, 20, 20);

  //find the point based on the angle
  float x = center.x + cos(angle)*radius;
  float y = center.y + sin(angle)*radius;

  //draw the traveling point
  ellipse(x, y, 20, 20);

  //increment the angle to move the point
  angle += PI/360;
}
