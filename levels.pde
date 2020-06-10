

void levelIntro(String message) {
  background (50, 50, 50);
  stroke (255);
  fill (255);
  text (message, displayWidth/2, displayHeight/2);
}

void resetScene() {
  gameObjects = new ArrayList<ArrayList>(); //The master arrayList


  blackHoleList = new ArrayList<BlackHole>();
  brickList = new ArrayList<Brick>();
  movingBrickList = new ArrayList<MovingBrick>();
  breakerList = new ArrayList<Breaker>();
  bounceList = new ArrayList<BounceEffect>();

  //Populate arrayLists based on level
  switch (level) {
  case 0: 
    level0init(); // Change this to the menu
    break;
  case 1: 
    level1init();
    break;
  case 2: 
    level2init();
    break;
  default: 
    //levelinit();
    level = -2;
    break;
  }

  magnetOn=false;

  gameObjects.add (blackHoleList);
  gameObjects.add (brickList);
  gameObjects.add (movingBrickList);
  gameObjects.add (bounceList);
  gameObjects.add (breakerList);
}

void levelMain() {
  //Draw borders
  background (30);
  stroke (50);
  fill (50);
  rect (displayWidth/2, displayHeight/2, gameWidth, gameHeight);

  //Main loop for rendering and code of objects within arrayLists
  objectListTraverseMain(gameObjects);
  objectListTraverseRender(gameObjects);

  //Draw aiming graphic reticule and trajectory prediction
  if (mouseDown)
    aimGraphic();

  //Every 100 ticks, clean disabled items within arrayLists
  if (tick%100==0) 
    for (ArrayList objectTypeList : gameObjects) 
      objectTypeList = CleanObjectList(objectTypeList);
}

void level0init() {
  roomHP = 44;
  for (int i = 11; i < roomHP+11; i ++) {
    if (i < 44)
      brickList.add(
        new Brick (
        55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
        60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
        gameWidth/14, 
        2)
        );
    else
      movingBrickList.add(
        new MovingBrick (
        55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
        60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
        gameWidth/14, 
        5, 
        55+ displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
        -450 + displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
        0.007)
        );
  }
}

void level1init() {
  /* roomHP = 40;
   for (int i = 0; i < roomHP; i ++) {
   if (i % 2 == 0)
   brickList.add(
   new Brick (
   55+displayWidth/2-gameWidth/2 + int(i % 10) * (gameWidth/11), 
   60+displayHeight/2-gameHeight/2 + int(i / 10) * 60, 
   gameWidth/14, 
   3)
   );
   else
   movingBrickList.add(
   new MovingBrick (
   55+displayWidth/2-gameWidth/2 + int(i % 10) * (gameWidth/11), 
   60+displayHeight/2-gameHeight/2 + int(i / 10) * 60, 
   gameWidth/14, 
   3, 
   55+ displayWidth/2-gameWidth/2 + int(i % 10) * (gameWidth/11), 
   -450 + displayHeight/2-gameHeight/2 + int(i / 10) * 60, 
   0.007)
   );
   }*/
  roomHP = 22;
  for (int i = 20; i < roomHP+18; i ++) {
    brickList.add(
      new Brick (
      55+displayWidth/2-gameWidth/2 + int(i % 10) * (gameWidth/11), 
      60+displayHeight/2-gameHeight/2 + int(i / 10) * 60, 
      gameWidth/50, 
      2)
      );
  }

  movingBrickList.add(
    new MovingBrick (
    55 + displayWidth/2-gameWidth/2 + int(60 % 10) * (gameWidth/11), 
    60 + displayHeight/2-gameHeight/2 + int(50 / 10) * 60, 
    gameWidth/40, 
    1, 
    55 + displayWidth/2-gameWidth/2 + int(69 % 10) * (gameWidth/11), 
    60 + displayHeight/2-gameHeight/2 + int(50 / 10) * 60, 
    -0.007)
    );

  movingBrickList.add(
    new MovingBrick (
    55 + displayWidth/2-gameWidth/2 + int(70 % 10) * (gameWidth/11), 
    60 + displayHeight/2-gameHeight/2 + int(60 / 10) * 60, 
    gameWidth/40, 
    1, 
    55 + displayWidth/2-gameWidth/2 + int(79 % 10) * (gameWidth/11), 
    60 + displayHeight/2-gameHeight/2 + int(60 / 10) * 60, 
    0.007)
    );
}
void level2init() {
  roomHP=10;
  blackHoleList.add(new BlackHole(displayWidth/2, displayHeight/2, 8, 250));

  for (int i = 20; i < roomHP+20; i ++) {
    brickList.add(
      new Brick (
      55+displayWidth/2-gameWidth/2 + int(i % 10) * (gameWidth/12), 
      60+displayHeight/2-gameHeight/2 + int(i / 10) * 60, 
      gameWidth/14, 
      2)
      );
  }
}

void levelinit() {
  roomHP = level;
  for (int i = 0; i < roomHP; i ++) {
    movingBrickList.add(
      new MovingBrick (
      55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
      60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
      gameWidth/14, 
      2, 
      55 + displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
      -100 + displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
      0.005)
      );
  }
}
