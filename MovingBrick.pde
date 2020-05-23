class MovingBrick extends Brick {
  /*
  int x, y, radius;
   float xvel, yvel;
   */
  Point p1, p2;
  float speed; // proportional number from 0 ~ 1. Speed loc changes
  float loc;  // As loc goes from 0 to 1, brick moves from p1 to p2
  float dir; // 1 = >> , -1 = <<

  MovingBrick (int x1, int y1, int bRadius, int hp, int x2, int y2, float speed) {
    super(x1, y1, bRadius, hp);
    p1 = new Point (x1, y1);
    p2 = new Point (x2, y2);
    this.speed = speed;
    loc = 0;
    dir = 1;
  }

  void render() {
    super.render(); //Replace with unique cube
  }

  void Main() {
    if (loc >= 1)
      dir = -1;

    if (loc <= 0)
      dir = 1;

    loc += speed*dir;

    super.x =  round(p1.x + (p1.x-p2.x)*loc); 
    super.y =  round(p1.y + (p1.y-p2.y)*loc); 

    super.Main(); // super checks for collision
  }
}
