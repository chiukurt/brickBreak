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
    strokeWeight(1);
    fill (200);
    stroke (200);
    ellipse (x, y, radius, radius);
  }

  void Main() {
    if (magnetOn) {
      if (x > mouseX || x < mouseX || y > mouseY || y < mouseY) {
        PVector dVec = new PVector (mouseX-x, mouseY-y);
        PVector bVec = new PVector (xvel,yvel);
        dVec.normalize();
        bVec.normalize();
        bVec.mult(6);
        
        PVector rVec = bVec.add(dVec);
        rVec.normalize();
        rVec.mult(breakerSpeed);
        xvel = rVec.x;
        yvel = rVec.y;
      }
    }

    bounceList.add (new BounceEffect (int(x+random(-2, 2)), int(y+random(-3, 3)), 15, 0.07, -1)); // Trail
    x+=xvel;
    y+=yvel;

    // Border collision
    if (x+xvel>=displayWidth/2+gameWidth/2 || x+xvel<displayWidth/2-gameWidth/2) {
      bounceList.add (new BounceEffect (int(x+xvel), int(y+yvel), 30, 0.22, 1));
      xvel=-xvel;
    }
    if (y+yvel>=displayHeight/2+gameHeight/2 || y+yvel<displayHeight/2-gameHeight/2) {
      bounceList.add (new BounceEffect (int(x+xvel), int(y+yvel), 30, 0.22, 1));
      yvel=-yvel;
    }
  }
}

class BounceEffect extends Renderable {
  int x, y, size, dir;
  float life, lifedrain;

  BounceEffect (int x, int y, int size, float lifedrain, int dir) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.lifedrain=lifedrain;
    this.dir=dir; // If the effect goes small>big (1) or big>small (-1)
    life = 1;
  }

  void render() {
    strokeWeight(1);
    fill (0, 0, 0, 0);
    stroke (255);

    if (dir == 1)
      ellipse (x, y, size-life*size, size-life*size);
    else
      ellipse (x, y, 1-life*size, 1-life*size);
  }

  void Main() {
    life-=lifedrain;
    if (life < 0)
      enabled = false;
  }
}
