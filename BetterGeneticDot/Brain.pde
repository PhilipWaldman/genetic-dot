class Brain {

  PVector[] directions;
  int step = 0;

  Brain(int size) {
    directions = new PVector[size];
    randomize();
  }

  void randomize() {
    for (int i=0; i<directions.length; i++)
      directions[i]=PVector.fromAngle(random(2*PI));
  }

  void mutate(float mutationRate) {
    for (int i =0; i< directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate)
        directions[i] = PVector.fromAngle(random(2*PI));
    }
  }

  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i=0; i<directions.length; i++)
      clone.directions[i] = directions[i].copy();
    return clone;
  }

  String toString() {
    String str = "[";
    for (PVector v : directions)
      str+="("+v.x+", "+v.y+"), ";
    return str+"]";
  }
}
