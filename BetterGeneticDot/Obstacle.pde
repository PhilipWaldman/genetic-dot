class Obstacle {

  PVector pos;
  PVector dim;

  Obstacle(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dim = new PVector(w, h);
  }

  boolean overlaps(Dot dot) {
    if (dot.pos.x+2>pos.x && dot.pos.x-2<pos.x+dim.x && dot.pos.y+2>pos.y && dot.pos.y-2<pos.y+dim.y)
      return true;
    return false;
  }

  void show() {
    fill(0, 0, 255);
    rect(pos.x, pos.y, dim.x, dim.y);
  }
}
