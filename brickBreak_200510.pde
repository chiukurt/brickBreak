// Kurt Chiu 2020-05-10

//TODO: Recursive arrayList traversal for render queue
// Ball counter
// Timer bar
// Score multiplier inversely proportional on how many breakers
int gameHeight, gameWidth;

ArrayList<ArrayList> gameObjects;
ArrayList<Brick> brickList;
ArrayList<MovingBrick> movingBrickList;
ArrayList<Breaker> breakerList;
ArrayList<BounceEffect> bounceList;
ArrayList<BlackHole> blackHoleList;

// Used to track remaining amount of bricks
// Dips into negative values during intermission
int roomHP; 

// Once roomHP becomes the negative of intermissionTimer, the next level is created
int intermissionTimer = 20;

//Global velocity of all ball breakers
float breakerSpeed = 14;

// Dictates the layout of the bricks 
// each level is potentially unique
int level;

// Used to track number of main loop cycles (draw())
// Every 100 cycles, disabled objects within arrayLists are removed
int tick;
int breakerCount;
int score;

// used to time doubleclick. Turns on breaker magnet to mouse if clicked twice within 10 ticks
int clickTimer;

// 
int maxLevel = 2;

boolean magnetOn = false;
boolean gameOn=true;

void setup() {
  size (displayWidth, displayHeight);
  imageMode (CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(20);

  gameHeight = int(displayHeight*0.9);
  gameWidth = int(gameHeight*10/18);

  frameRate(60);

  resetGame();
}

//Rendering
// Room HP dictates number of remaining bricks to break
void draw() {
  if (gameOn)
    gameScene();
  else
    gameOverScene();
}

void Render() {
  //mainOn=true;
  //while (roomHP > 0)
  objectListTraverseRender(gameObjects);

  //mainOn = false;
}

void gameOverScene() {
  background (0);

  stroke (255);
  fill (255);
  text ( "You win!", displayWidth/2, displayHeight/2);
  text ( "Score: "+(score*10000000/tick/breakerCount), displayWidth/2, displayHeight/2.3);
  text ( "Click here to play again.", displayWidth/2, displayHeight/2+displayHeight/10);
println (displayWidth,displayHeight);

  if (mousePressed && collision(mouseX, mouseY, displayWidth/2.34146, displayHeight/1.8, displayWidth/1.745, displayHeight/1.59)) {
    resetGame();
  }
}


void resetGame() {
  breakerCount = 0;
  level = -1;
  roomHP = 0;
  score = 0;
  tick = 0;
  gameOn = true;
}

void gameScene() {
  tick++;
  clickTimer--;

  // Level skipping for testing
  if (keyCode == DOWN) {
    roomHP=0;
  }

  if (roomHP > 0) {
    //In level
    //if (!mainOn)
    //thread ("Render");
    levelMain();
  } else if (roomHP > - intermissionTimer) {
    //Level intermission
    roomHP--;
    levelIntro ("Level "+(level+1) + "   -  "+(-roomHP)+"/"+intermissionTimer);
    delay(1);
  } else {
    //Next level
    if (level + 1 <= maxLevel) {
      level++;
      resetScene();
    } else
      gameOn=false;
  }
}
