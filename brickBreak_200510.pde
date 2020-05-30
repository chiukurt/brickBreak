// Kurt Chiu 2020-05-10


//TODO: Recursive arrayList traversal for render queue
int gameHeight, gameWidth;

ArrayList<ArrayList> gameObjects;
ArrayList<Brick> brickList;
ArrayList<MovingBrick> movingBrickList;
ArrayList<Breaker> breakerList;
ArrayList<BounceEffect> bounceList;

int roomHP;

float breakerSpeed = 14;

int level = 0;

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
