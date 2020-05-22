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

On any call to level instance creation, each renderable object type will be initialized as an arraylist of that object type and then added to the master arrayList.  
<pre>
  gameObjects = new ArrayList<ArrayList>();// The master arrayList
  brickList = new ArrayList<Brick>();
  breakerList = new ArrayList<Breaker>();
  bounceList = new ArrayList<BounceEffect>();
</pre>
...
<pre>
  gameObjects.add (bounceList);
  gameObjects.add (brickList);
  gameObjects.add (breakerList);
</pre>

This master arrayList will then cycle through each object type linked list to run each objects render() and Main() functions.



