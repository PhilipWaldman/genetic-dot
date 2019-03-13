Obstacle[] obstacles;
Board board;

void setup() {
  size(500, 500);
  frameRate(30);
  board=new Board();
  obstacles = board.getBoard();
}

void draw() {
  background(255);

  if (mouseX>=0 && mouseX<width && mouseY>=0 && mouseY<height) {
    if (mousePressed && (mouseButton == LEFT)) 
      board.addObstacle(mouseX, mouseY);
    else if (mousePressed && (mouseButton == RIGHT))
      board.removeObstacle(mouseX, mouseY);
  }

  obstacles = board.getBoard();

  for (Obstacle o : obstacles)
    o.show();


  fill(255, 0, 0);
  ellipse(250-5, 10, 10, 10);
  fill(0, 255, 0);
  ellipse(250-5, height-10, 10, 10);
}

void keyPressed() {
  if (key == CODED)
    if (keyCode == UP)
      println("\n\n\n"+board);
}
