class Population {

  Dot[] dots;
  float fitnessSum;
  int gen=1, bestDot=0, maxSteps=Integer.MAX_VALUE;

  Population(int size, int initialBrainSize) {
    dots = new Dot[size];
    for (int i = 0; i< size; i++) 
      dots[i] = new Dot(initialBrainSize);
  }

  void naturalSelection(float mutationRate) {
    calculateFitness();
    Dot[] newDots = new Dot[dots.length];

    setBestDot();
    calculateFitnessSum();
    newDots[0] = dots[bestDot].clone();
    newDots[0].isBest = true;

    for (int i=1; i<newDots.length; i++) {
      Dot parent1 = selectParent();
      Dot parent2 = selectParent();
      newDots[i] = crossover(parent1, parent2);
    }

    dots = newDots.clone();
    mutate(mutationRate);
    gen++;
  }

  Dot crossover(Dot parent1, Dot parent2) {
    PVector[] childDir = new PVector[maxSteps<dots[bestDot].brain.directions.length ? maxSteps : dots[bestDot].brain.directions.length];
    for (int i=0; i<childDir.length; i++) {
      if (random(2)<1)
        childDir[i] = parent1.brain.directions[i];
      else
        childDir[i] = parent2.brain.directions[i];
    }
    Dot child = new Dot(0);
    child.brain.directions = childDir.clone();
    return child;
  }

  Dot selectParent() {
    float rand = random(fitnessSum);
    float runningSum=0;
    for (Dot d : dots) {
      runningSum+=d.fitness;
      if (runningSum>rand)
        return d;
    }
    return null; //shouldn't happen
  }

  void mutate(float mutationRate) {
    for (int i=1; i<dots.length; i++)
      dots[i].brain.mutate(mutationRate);
  }

  void update() {
    for (Dot d : dots) {
      if (d.brain.step > maxSteps)
        d.dead = true;
      else
        d.update();
    }
  }

  boolean allDotsDead() {
    for (Dot d : dots)
      if (!d.dead && !d.reachedGoal)
        return false;
    return true;
  }

  void calculateFitness() {
    for (Dot d : dots)
      d.calculateFitness();
  }

  void calculateFitnessSum() {
    fitnessSum=0;
    for (Dot d : dots)
      fitnessSum+=d.fitness;
  }

  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< dots.length; i++)
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    bestDot = maxIndex;

    if (dots[bestDot].reachedGoal)
      maxSteps=dots[bestDot].brain.step;
  }

  void show() {
    if (showAll)
      for (int i=1; i<dots.length; i++)
        dots[i].show();
    else
      for (int i=1; i<showMax; i++)
        dots[i].show();
    dots[0].show();
  }
}
