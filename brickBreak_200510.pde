// Kurt Chiu 2020-05-10
int gameHeight, gameWidth;
int tempMouseX, tempMouseY;

ArrayList<ArrayList> gameObjects;
ArrayList<Brick> brickList;
ArrayList<MovingBrick> movingBrickList;
ArrayList<Breaker> breakerList;
ArrayList<BounceEffect> bounceList;


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

  renderQueuedObjects(gameObjects);

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

void mousePressed() {
  //breakerList.add (new Breaker (mouseX, mouseY, 20));
  tempMouseX=mouseX;
  tempMouseY=mouseY;
  dl = true;
}

void mouseReleased() {
  PVector bVel = new PVector (mouseX-tempMouseX, mouseY-tempMouseY);
  if (bVel.x!=0 || bVel.y!=0) {
    bVel.normalize();
    bVel.mult(breakerSpeed);
    breakerList.add (new Breaker (tempMouseX, tempMouseY, 20, bVel.x, bVel.y));
  }
  dl = false;
}
