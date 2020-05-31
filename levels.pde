
void levelIntro(String message) {
  background (50, 50, 50);
  stroke (255);
  fill (255);
  text (message, displayHeight/2, displayWidth/2);
  delay (100);
}

void resetScene() {

  gameHeight = int(displayHeight*0.9);
  gameWidth = int(gameHeight*10/16);

  gameObjects = new ArrayList<ArrayList>(); //The master arrayList
  brickList = new ArrayList<Brick>();
  movingBrickList = new ArrayList<MovingBrick>();
  breakerList = new ArrayList<Breaker>();
  bounceList = new ArrayList<BounceEffect>();

  switch (level) {
  case 0: 
    levelIntro("Level "+level);
    level0init(); // Change this to the menu
    break;
  case 1: 
    levelIntro("Level "+level);
    level1init();
    break;

  default: 
    println ("default");
    break;
  }

  gameObjects.add (brickList);
  gameObjects.add (movingBrickList);

  gameObjects.add (bounceList);
  gameObjects.add (breakerList);
}

void levelMain() {
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
}

void level0init() {
  roomHP = 77;
  for (int i = 0; i < roomHP; i ++) {
    if (i < 50)
      brickList.add(
        new Brick (
        55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
        60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
        gameWidth/14, 10)
        );
    else
      movingBrickList.add(
        new MovingBrick (
        55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
        60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
        gameWidth/14, 10, 
        100, 100, 0.007)
        );
  }
}

void level1init() {
  roomHP = 10;
  for (int i = 0; i < roomHP; i ++) {
    brickList.add(
      new Brick (
      55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
      60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
      gameWidth/14, 10)
      );
  }
}
