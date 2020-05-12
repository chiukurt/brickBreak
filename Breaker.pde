
class Breaker extends Renderable {
  int x, y, radius;
  float xvel, yvel;
  Breaker (int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius=radius;
  }

  Breaker (int x, int y, int radius, float xvel, float yvel) {
    this.x = x;
    this.y = y;
    this.radius=radius;
    this.xvel=xvel;
    this.yvel=yvel;
  }

  void render() {
    fill (200);
    stroke (200);
    ellipse (x, y, radius, radius);
  }

  void Main() {
    x+=xvel;
    y+=yvel;

    if (x+xvel>=displayWidth/2+gameWidth/2 || x+xvel<displayWidth/2-gameWidth/2){
          bounceList.add (new BounceEffect (int(x+xvel),int(y+yvel),30));
      xvel=-xvel;}
    if (y+yvel>=displayHeight/2+gameHeight/2 || y+yvel<displayHeight/2-gameHeight/2){
          bounceList.add (new BounceEffect (int(x+xvel),int(y+yvel),30));
      yvel=-yvel;}
  }
}

class BounceEffect extends Renderable {
  int x, y, life;

  BounceEffect (int x, int y, int life) {
    this.x = x;
    this.y = y;
    this.life=life;
  }

  void render() {
    if (true) {
      fill (0, 0, 0, 0);
      stroke (255);
      ellipse (x, y, 30-life, 30-life);
    }
  }

  void Main() {
    life-=7;
    if (life < 0)
      enabled = false;
  }
}
