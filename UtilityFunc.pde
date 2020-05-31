

/*
void objectListTraverse1(ArrayList List) {
 if (List instanceof ArrayList) {
 objectListTraverse2 (List);
 }else{
 
 }
 }
 
 void objectListTraverse2(ArrayList<ArrayList> List) {
 for (ArrayList thisList : List) {
 objectListTraverse1(thisList);
 }
 }
 
 
 
 void objectMain (Renderable itemToRender) {
 if (itemToRender.enabled) {
 itemToRender.render();
 itemToRender.Main();
 }
 }
 */

void objectListTraverse(ArrayList<ArrayList> gameObjects) {
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
