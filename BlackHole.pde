class BlackHole extends Renderable {
  int x, y, mag, range; // Magnitude

  BlackHole (int x, int y, int mag, int range) {
    this.x = x;
    this.y = y;
    this.mag = mag;
    this.range = range;
  }


  void render() {
    int ringSize = mag + (range-tick*4%range);
    strokeWeight (1);

  //imrpove graphics by adding particle effect
  
    fill(0, 0, 0, 0);
    stroke (255, 255, 255, 50);
    ellipse (x, y, ringSize, ringSize);

    stroke(0, 0, 0, 0);
    fill(0, 0, 0, 50);
    ellipse (x, y, mag*4, mag*4);
    fill(0, 0, 0, 100);
    ellipse (x, y, mag*3, mag*3);
    fill(0, 0, 0, 255);
    ellipse (x, y, mag*2, mag*2);
    
    fill(0,0,0,5);
    stroke(0, 0, 0,50);
    ellipse (x,y,range,range);
    
  }

  void Main() {

//fix the math on range here
    for (Breaker b : breakerList) {
      if (getHyp(x, y, b.x, b.y) < range ) {
        if (b.x > x || b.x < x || b.y > y || b.y < y) {
          PVector dVec = new PVector (x-b.x, y-b.y);
          PVector bVec = new PVector (b.xvel, b.yvel);
          dVec.normalize();
          bVec.normalize();
          bVec.mult(mag);

          PVector rVec = bVec.add(dVec);
          rVec.normalize();
          rVec.mult(breakerSpeed);
          b.xvel = rVec.x;
          b.yvel = rVec.y;
        }
      }
    }
  }
}
