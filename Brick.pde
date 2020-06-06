class Brick extends Renderable {
  int x, y, bh, bw, hp;
  float thp; //thp = total health points
  PVector toBreaker;
  int brickColour=0;

  Brick (int x, int y, int bh, int bw, int hp) {
    this.x = x;
    this.y = y;
    this.bh = bh;
    this.bw = bw;
    this.hp = hp;
    this.thp = hp;
    toBreaker = new PVector (0, 0);
  }

  Brick (int x, int y, int bRadius, int hp) {
    this.x = x;
    this.y = y;
    this.bh = bRadius;
    this.bw = bRadius;
    this.hp = hp;
    this.thp = hp;
    toBreaker = new PVector (0, 0);
  }

  void render() {
    strokeWeight (2);
    fill (brickColour);
    if (thp > 0)
      stroke (0, 200*(hp/thp), 250*(hp/thp));
    else
      stroke (0, 200, 250);
    rect (x, y, bh, bw);
  }

  void Main() {
    if (mousePressed && collision (mouseX, mouseY, x-bh/2, y-bh/2, x+bh/2, y+bh/2)) {
      hp-=1;
    }
    if (brickColour > 0)
      brickColour-=10;

    for (Breaker b : breakerList) {
      if (b.enabled && collision(
        b.x+b.xvel, 
        b.y+b.yvel, 
        x-bw/2-b.radius/2, 
        y-bh/2-b.radius/2, 
        x+bw/2+b.radius/2, 
        y+bh/2+b.radius/2
        )) {


        hp-=1;
        brickColour = 100;

        toBreaker.x = (b.x-x);
        toBreaker.y = (b.y-y);

        float angle = toBreaker.heading()+PI;

        if ((angle >= 5*PI/4 && angle <= 7*PI/4) || (angle >= PI/4 && angle <= 3*PI/4)) {
          bounceList.add (new BounceEffect (int(b.x+b.xvel*2), int(b.y+b.yvel*2), 30, 0.22, 1));
          b.yvel = -b.yvel;
        } else {
          bounceList.add (new BounceEffect (int(b.x+b.xvel*2), int(b.y+b.yvel*2), 30, 0.22, 1));
          b.xvel = -b.xvel;
        }
      }
    }


    if (hp<=0) {
      enabled=false;
      roomHP-=1;
      bounceList.add (new BounceEffect (int(x), int(y), 200, 0.1, 1));
    }
  }
}
