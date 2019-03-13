class Board {

  boolean[][] board;

  Board() {
    board = new boolean[height/10][width/10];
  }

  void addObstacle(int r, int c) {
    board[r/10][c/10] = true;
  }

  void removeObstacle(int r, int c) {
    board[r/10][c/10] = false;
  }

  Obstacle[] getBoard() {
    int count=0;
    for (boolean[] booArr : board)
      for (boolean boo : booArr)
        if (boo)
          count++;
    Obstacle[] arr = new Obstacle[count];

    count=0;
    for (int r=0; r<board.length; r++)
      for (int c=0; c<board[0].length; c++)
        if (board[r][c]) {
          arr[count] = new Obstacle(r*10, c*10, 10, 10);
          count++;
        }

    return arr;
  }

  String toString() {
    Obstacle[] arr = getBoard();

    String str = "{";
    for (Obstacle o : arr)
      str += "new Obstacle("+o.pos.x+", "+o.pos.y+", 10, 10), ";
    str += "}";

    return str;
  }
}
