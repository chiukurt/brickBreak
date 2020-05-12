void renderQueuedObjects(ArrayList<ArrayList> gameObjects) {
  for (ArrayList objectTypeList : gameObjects) {
    renderObjectsPerType (objectTypeList);
  }
}

void renderObjectsPerType (ArrayList<Renderable> objectTypeList) {
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) {
      itemToRender.render();
      itemToRender.Main();
    }
  }
}

class Renderable extends Object {
  boolean enabled=true;
  void render() {
  }
  void Main() {
  }
}

public boolean collision (float x, float y, float x1, float y1, float x2, float y2) {
  //println ("("+x+", "+y+")"+"("+x1+", "+y1+")"+"("+x2+", "+y2+")");
  if (x >= x1 && x<= x2 && y >= y1 && y <= y2)
    return true;
  return false;
}

void resetGame() {
  roomHP = 77;
  gameHeight = int(displayHeight*0.9);
  gameWidth = int(gameHeight*10/16);

  gameObjects = new ArrayList<ArrayList>();
  brickList = new ArrayList<Brick>();
  breakerList = new ArrayList<Breaker>();
  bounceList = new ArrayList<BounceEffect>();

  for (int i = 0; i < roomHP; i ++) {
    brickList.add(
      new Brick (
      55+displayWidth/2-gameWidth/2 + int(i % 11) * (gameWidth/12), 
      60+displayHeight/2-gameHeight/2 + int(i / 11) * 60, 
      gameWidth/14, 10));
  }

  gameObjects.add (bounceList);
  gameObjects.add (brickList);
  gameObjects.add (breakerList);
}

float getHyp (float x1, float y1, float x2, float y2) {
  return (sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)));
}

//Returns values if hypotenuse is 1 
float normalizeX (float x1, float y1, float x2, float y2) {
  return 0;
}

float normalizeY (float x1, float y1, float x2, float y2) {
  return 0;
}