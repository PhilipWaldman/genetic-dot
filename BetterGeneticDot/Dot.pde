class Dot {

  PVector pos;
  PVector vel;
  PVector acc;
  boolean dead = false, reachedGoal = false, isBest = false;
  Brain brain;
  float fitness = 0;

  Dot(int brainSize) {
    brain = new Brain(brainSize);
    pos = new PVector(width/2-5, height-10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x<2 || pos.x>width-2 || pos.y<2 || pos.y>height-2 || overlapsObstacle())
        dead=true;
      else if (dist(pos.x, pos.y, goal.x, goal.y)<5)
        reachedGoal=true;
    }
  }

  void move() {
    if (brain.directions.length>brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else
      dead=true;

    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }

  boolean overlapsObstacle() {
    for (Obstacle o : obstacles)
      if (o.overlaps(this))
        return true;
    return false;
  }

  void calculateFitness() {
    if (reachedGoal)
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    else {
      float distToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distToGoal*distToGoal);
    }
  }

  void show() {
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  Dot clone() {
    Dot newDot = new Dot(0);
    newDot.brain = brain.clone();
    return newDot;
  }
}
