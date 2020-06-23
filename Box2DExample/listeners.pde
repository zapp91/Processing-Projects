void mousePressed() {
    boxes.add(new Box(mouseX, mouseY, random(5,50), random(5,50), color(int(random(0,255)), int(random(0,255)), int(random(0,255))), Box2DBodyType.DYNAMIC, 1, 0.3, 0.9, randomBool()));
}
