
int tempMouseX, tempMouseY;
boolean mouseDown = false;

void mousePressed() {
  if (roomHP>0) {
    tempMouseX=mouseX;
    tempMouseY=mouseY;
    mouseDown = true; // Enables trajectory prediction and reticule
  }

  if (clickTimer > 0) {
    if (magnetOn)
      magnetOn=false;
    else
      magnetOn=true;
  }

  clickTimer = 10;
}

void mouseReleased() {
  if (roomHP>0) {
    mouseDown = false;  // Disables trajectory prediction and reticule

    //Creates new projectile breaker
    PVector bVel = new PVector (mouseX-tempMouseX, mouseY-tempMouseY);
    if (bVel.x!=0 || bVel.y!=0) {
      bVel.normalize();
      bVel.mult(breakerSpeed);
      breakerList.add (new Breaker (tempMouseX, tempMouseY, 20, bVel.x, bVel.y));
    }
  }
}

void aimGraphic() {//Placeholder function for breaker trajectory prediciton and aiming reticule
  float xvel, yvel;
  PVector pVec = new PVector (mouseX-tempMouseX, mouseY-tempMouseY);
  float x = tempMouseX, y = tempMouseY;
  PVector toBreaker = new PVector();

  // Aiming reticule
  stroke(255);
  fill(0, 0, 0, 0);
  ellipse (tempMouseX, tempMouseY, 
    getHyp(mouseX, mouseY, tempMouseX, tempMouseY)*2, 
    getHyp(mouseX, mouseY, tempMouseX, tempMouseY)*2);
  line (mouseX, mouseY, tempMouseX, tempMouseY);
  ellipse (mouseX, mouseY, 5, 5);
  ellipse (tempMouseX, tempMouseY, 15, 15);

  pVec.normalize();
  pVec.mult(breakerSpeed);
  xvel = pVec.x;
  yvel = pVec.y;

  for ( int i = 0; i < 125; i ++) {
    stroke (255, 255, 255, 255-i*2);
    x+=xvel;
    y+=yvel;

    if (x+xvel>=displayWidth/2+gameWidth/2 || x+xvel<displayWidth/2-gameWidth/2) {
      xvel=-xvel;
    }
    if (y+yvel>=displayHeight/2+gameHeight/2 || y+yvel<displayHeight/2-gameHeight/2) {
      yvel=-yvel;
    }

    for (Brick b : brickList) {
      if (b.enabled && collision(x+xvel, y+yvel, b.x-b.bh/2, b.y- b.bw, b.x+b.bh/2, b.y+ b.bw)) {
        toBreaker.x = (x-b.x);
        toBreaker.y = (y-b.y);
        float angle = toBreaker.heading()+PI;
        if ((angle >= 5*PI/4 && angle <= 7*PI/4) || (angle >= PI/4 && angle <= 3*PI/4)) {
          yvel=-yvel;
        } else {
          xvel = -xvel;
        }
      }
    }

    for (MovingBrick b : movingBrickList) {
      if (b.enabled && collision(x+xvel, y+yvel, b.x-b.bh/2, b.y- b.bw, b.x+b.bh/2, b.y+ b.bw)) {
        toBreaker.x = (x-b.x);
        toBreaker.y = (y-b.y);
        float angle = toBreaker.heading()+PI;
        if ((angle >= 5*PI/4 && angle <= 7*PI/4) || (angle >= PI/4 && angle <= 3*PI/4)) {
          yvel=-yvel;
        } else {
          xvel = -xvel;
        }
      }
    }
    strokeWeight (3);
    point (x, y);
    strokeWeight(1);
  }
}
