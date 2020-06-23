public enum Box2DBodyType {
    STATIC,
    DYNAMIC,
    KINEMATIC
}

boolean randomBool() {
  int num = -1 + (int)random(2) * 2;
  if (num == 1) {
    return true;
  } else {
    return false;
  }
}
