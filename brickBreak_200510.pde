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

  resetScene();
}

// Room HP dictates number of remaining bricks to break
void draw() {
  if (roomHP > 0) {
    levelMain();
  } else {
    level=1;
    resetScene();
  }
}
