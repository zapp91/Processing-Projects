public enum Box2DBodyType {
    STATIC,
    DYNAMIC,
    KINEMATIC
}


void displayPhysicsObjects() {
  if (po != null) {
    for (PhysicsObject o: po) {
      o.display();
    }
  }
}
