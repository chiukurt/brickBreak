# brickBreak
Minigame made using OOP. Emphasis on scalability as many features will be added down the line.

Works on android via processing's ability generate an .APK file



<h2>Render queue concept</h2>
Any object that can be rendered on screen will extend from the Renderable abstract class.
<pre>
class Renderable extends Object {
  boolean enabled=true;
  void render() {
  }
  void Main() {
  }
}
</pre>

On any call to level instance creation, each renderable object type will be initialized as an arrayList of that object type and then added to the master arrayList.  
<pre>
  gameObjects = new ArrayList<ArrayList>(); //The master arrayList

  brickList = new ArrayList<Brick>();
  movingBrickList = new ArrayList<MovingBrick>();
  breakerList = new ArrayList<Breaker>();
  bounceList = new ArrayList<BounceEffect>();
</pre>
...
<pre>
  gameObjects.add (brickList);
  gameObjects.add (movingBrickList);
  gameObjects.add (bounceList);
  gameObjects.add (breakerList);
</pre>

This master arrayList will then cycle through each object type linked list to run each objects render() and Main() functions.
<pre>
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
</pre>

<h2>Breaker to brick collision</h2>
Current code used, assuming the brick is a perfect square.

 - Cycle through each breaker referenced as 'b'
 - Measure the angle between the center of the breaker and the center of the brick using .heading() function
 - Split the angle quadrants into an X shaped part
 - If the angle resides between 5PI/4 and 7PI/4 or PI/4 and 3PI/4, a vertical collision has occured and y velocity is flipped
 - If the angle resides in another part, a horizontal collision has occured and x velocity is flipped
 - Add corresponding impact graphical effect to the render queue 

<pre>
   toBreaker.x = (b.x-x);
   toBreaker.y = (b.y-y);
   float angle = toBreaker.heading()+PI;

        if ((angle >= 5*PI/4 && angle <= 7*PI/4) || (angle >= PI/4 && angle <= 3*PI/4)) {
          bounceList.add (new BounceEffect (int(b.x+b.xvel*2), int(b.y+b.yvel*2), 30));
          b.yvel = -b.yvel;
        } else {
          bounceList.add (new BounceEffect (int(b.x+b.xvel*2), int(b.y+b.yvel*2), 30));
          b.xvel = -b.xvel;
        }
</pre>

<h2>Breaker magnet attraction to mouse</h2>
Done using vector addition. 

 - Create a normal vector of the current breaker velocity (bVel)
 - Create a normal vector between the breaker and the mouse (dVel)
 - Add the two vectors with a 6:1 ratio between bVel and dVel
 - Multiply the resulting vector to preserve the overall movement speed of the breaker
 
 <pre> if (magnetOn) {
      if (x > mouseX || x < mouseX || y > mouseY || y < mouseY) {
        PVector dVec = new PVector (mouseX-x, mouseY-y);
        PVector bVec = new PVector (xvel,yvel);
        dVec.normalize();
        bVec.normalize();
        bVec.mult(6);
        
        PVector rVec = bVec.add(dVec);
        rVec.normalize();
        rVec.mult(breakerSpeed);
        xvel = rVec.x;
        yvel = rVec.y;
      }
    }</pre>
