class Obstacle {

  PVector pos;
  PVector dim;

  Obstacle(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dim = new PVector(w, h);
  }

  void show() {
    fill(0, 0, 255);
    rect(pos.x, pos.y, dim.x, dim.y);
  }
}
