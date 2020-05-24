// Kurt Chiu 2020-05-10


//TODO: Recursive arrayList traversal for render queue
int gameHeight, gameWidth;
int tempMouseX, tempMouseY;

ArrayList<ArrayList> gameObjects;
ArrayList<Brick> brickList;
ArrayList<MovingBrick> movingBrickList;
ArrayList<Breaker> breakerList;
ArrayList<BounceEffect> bounceList;

boolean mouseDown = false;
boolean dl = false;
int roomHP;

float breakerSpeed = 14;

void setup() {
  size (displayWidth, displayHeight);
  imageMode (CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(20);

  resetGame();
}

void draw() {
  background (30);
  stroke (50);
  fill (50);
  rect (displayWidth/2, displayHeight/2, gameWidth, gameHeight);

  objectListTraverse(gameObjects);
  if (mouseDown)
    rayTrace();

  if (dl) {
    stroke(255);
    fill(0, 0, 0, 0);
    ellipse (tempMouseX, tempMouseY, 
      getHyp(mouseX, mouseY, tempMouseX, tempMouseY)*2, 
      getHyp(mouseX, mouseY, tempMouseX, tempMouseY)*2);
    line (mouseX, mouseY, tempMouseX, tempMouseY);
    ellipse (mouseX, mouseY, 5, 5);
    ellipse (tempMouseX, tempMouseY, 15, 15);
  }
  if (roomHP <= 0) {
    resetGame();
  }
}

void rayTrace() {
  float xvel, yvel;
  PVector pVec = new PVector (mouseX-tempMouseX, mouseY-tempMouseY);

  pVec.normalize();
  pVec.mult(breakerSpeed);

  xvel = pVec.x;
  yvel = pVec.y;

  float x = tempMouseX, y = tempMouseY;
  PVector toBreaker = new PVector();



  for ( int i = 0; i < 125; i ++) {
    stroke (255, 255, 255, 255-i*2);
    x+=xvel;
    y+=yvel;

    if (x+xvel>=displayWidth/2+gameWidth/2 || x+xvel<displayWidth/2-gameWidth/2) {
      xvel=-xvel;
    }
    if (y+yvel>=displayHeight/2+gameHeight/2 || y+yvel<displayHeight/2-gameHeight/2) {
      yvel=-yvel;
    }

    for (Brick b : brickList) {
      if (b.enabled && collision(x+xvel, y+yvel, b.x-b.bh/2, b.y- b.bw, b.x+b.bh/2, b.y+ b.bw)) {
        toBreaker.x = (x-b.x);
        toBreaker.y = (y-b.y);
        float angle = toBreaker.heading()+PI;
        if ((angle >= 5*PI/4 && angle <= 7*PI/4) || (angle >= PI/4 && angle <= 3*PI/4)) {
          yvel=-yvel;
        } else {
          xvel = -xvel;
        }
      }
    }
    
     for (MovingBrick b : movingBrickList) {
      if (b.enabled && collision(x+xvel, y+yvel, b.x-b.bh/2, b.y- b.bw, b.x+b.bh/2, b.y+ b.bw)) {
        toBreaker.x = (x-b.x);
        toBreaker.y = (y-b.y);
        float angle = toBreaker.heading()+PI;
        if ((angle >= 5*PI/4 && angle <= 7*PI/4) || (angle >= PI/4 && angle <= 3*PI/4)) {
          yvel=-yvel;
        } else {
          xvel = -xvel;
        }
      }
    }
    


    strokeWeight (3);
    point (x, y);
    strokeWeight(1);
  }
}

void mousePressed() {
  tempMouseX=mouseX;
  tempMouseY=mouseY;
  dl = true;
  mouseDown = true;
}

void mouseReleased() {
  mouseDown = false;
  PVector bVel = new PVector (mouseX-tempMouseX, mouseY-tempMouseY);
  if (bVel.x!=0 || bVel.y!=0) {
    bVel.normalize();
    bVel.mult(breakerSpeed);
    breakerList.add (new Breaker (tempMouseX, tempMouseY, 20, bVel.x, bVel.y));
  }
  dl = false;
}
