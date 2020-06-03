
void objectListTraverse(ArrayList<ArrayList> gameObjects) {
  for (ArrayList objectTypeList : gameObjects) {
    renderObjectsPerType (objectTypeList);
  }
}

// Returns arrayList of only 'enabled' items
ArrayList<Renderable> CleanObjectList  (ArrayList<Renderable> objectTypeList) {
  ArrayList<Renderable> cleanedList = new ArrayList<Renderable>();
  for (Renderable itemToPreserve : objectTypeList) 
    if (itemToPreserve.enabled) 
      cleanedList.add(itemToPreserve);
  return cleanedList;
}

void renderObjectsPerType (ArrayList<Renderable> objectTypeList) {
  for (Renderable itemToRender : objectTypeList) {
    if (itemToRender.enabled) {
      itemToRender.render();
      itemToRender.Main();
    }
  }
}

// abstract class
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

class Point {
  int x, y;
  Point (int x, int y) {
    this.x=x;
    this.y=y;
  }
}
