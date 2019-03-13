PVector goal;
Population pop;
Obstacle[] obstacles;
boolean showAll = false, noShow = false;
int showMax = 100;

void setup() {
  size(500, 500);
  frameRate(1000);
  pop = new Population(2500, 400);
  goal = new PVector(width/2-5, 10);
  obstacles = new Obstacle[]{
    new Obstacle(0, 100, 300, 10), 
    new Obstacle(200, 200, 300, 10), 
    new Obstacle(0, 300, 300, 10), 
    new Obstacle(200, 400, 300, 10)};
}

void draw() {
  if (!noShow) {
    background(255);
    for (Obstacle o : obstacles)
      o.show();
    //goal dot
    fill(255, 0, 0);
    ellipse(goal.x, goal.y, 10, 10);

    if (pop.allDotsDead()) 
      pop.naturalSelection(0.01);
    else {
      pop.update();
      pop.show();
    }

    fill(0);
    text("Gen: "+pop.gen, goal.x-18, goal.y+18);
    text("Steps: "+pop.maxSteps, goal.x-30, goal.y+30);
    text((int)frameRate+" FPS", 3, 12);
    if (showAll)
      text("Showing all", 3, 24);
    else
      text("Showing "+showMax+"/"+pop.dots.length, 3, 24);
    text("Brain Size: "+pop.dots[pop.bestDot].brain.directions.length, width-96, 12);
  } else {
    if (pop.allDotsDead()) 
      pop.naturalSelection(0.01);
    else
      pop.update();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)
      showMax = showMax<pop.dots.length ? showMax+=10 : pop.dots.length;
    else if (keyCode == DOWN)
      showMax = showMax>1 ? showMax-=10 : 1;
    else if (keyCode == RIGHT)
      showAll = true;
    else if (keyCode == LEFT)
      showAll = false;
  }

  switch(key) {
  case '0':
    noShow = !noShow;
    break;
  case 'S':
    Table table = new Table();

    table.addColumn("x_acc");
    table.addColumn("y_acc");

    for (PVector dir : pop.dots[pop.bestDot].brain.directions) {
      TableRow newRow = table.addRow();
      newRow.setFloat("x_acc", dir.x);
      newRow.setFloat("y_acc", dir.y);
    }

    saveTable(table, "data/acc.csv");
    break;

  default:
    break;
  }
}
