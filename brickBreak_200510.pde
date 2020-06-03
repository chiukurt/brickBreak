// Kurt Chiu 2020-05-10

//TODO: Recursive arrayList traversal for render queue
int gameHeight, gameWidth;

ArrayList<ArrayList> gameObjects;
ArrayList<Brick> brickList;
ArrayList<MovingBrick> movingBrickList;
ArrayList<Breaker> breakerList;
ArrayList<BounceEffect> bounceList;

// Used to track remaining amount of bricks
// Dips into negative values during intermission
int roomHP; 

// Once roomHP becomes the negative of intermissionTimer, the next level is created
int intermissionTimer = 100;

//Global velocity of all ball breakers
float breakerSpeed = 14;

// Dictates the layout of the bricks 
// each level is potentially unique
int level = -1;

// Used to track number of main loop cycles (draw())
// Every 100 cycles, disabled objects within arrayLists are removed
int tick;


void setup() {
  size (displayWidth, displayHeight);
  imageMode (CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(20);

  gameHeight = int(displayHeight*0.9);
  gameWidth = int(gameHeight*10/16);

  roomHP = 0;
  tick = 0;
}

// Room HP dictates number of remaining bricks to break
void draw() {
  tick++;
  
  // Level skipping for testing
  if (keyCode == DOWN) {
    roomHP=0;
  }

  if (roomHP > 0) {
    //In level
    levelMain();
  } else if (roomHP > -intermissionTimer) {
    //Level intermission
    roomHP--;
    levelIntro ("Level "+(level+1) + "   -  "+(-roomHP)+"/"+intermissionTimer);
    delay(1);
  } else {
    //Next level
    level++;
    resetScene();
  }
  
}

void debugTextDisplay(){

}
