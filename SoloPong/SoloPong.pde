float x;  // x and y are the width and height divided by 2
float y;
float vx; // vx and vy are the speed of the ball travelling
float vy;  
float diameter = 20; 
float rectSize = 150;
int counter; //counter is the scoreboard
boolean paused = false;
import processing.sound.*;
SoundFile kick; // imported sound from Moodle lecture
PFont font;
PFont font2;

void setup() 
{
  size(750, 500); // size of the sketch width is 750 = x length and 500 = y which is length
  reset();
  kick = new SoundFile(this, "kickDrum.wav"); // sound 
  font = loadFont("AppleSDGothicNeo-Heavy-48.vlw"); // font for the game over 
  font2 = loadFont("Galvji-Oblique-48.vlw"); //font for the score
}

void reset() 
{
  counter = 0;
  paused = false;
  x = width/2;
  y = height/2;
  vx = random(3, 5);
  vy = random(3, 5); // vx and vy randomly selected from 3,5.
}

void draw() 
{ 
  if (!paused) {
    background(#7AF798); // background set to a nice tone of green

    fill(#FA00FF);
    strokeWeight(0.5);
    stroke(#FA00FF);
    ellipse(x, y, diameter, diameter); // ball is centred x and y and size is diameter , diameter also coloured neon pink

    fill(#00E3FF);
    strokeWeight(2);
    stroke(#00E3FF);
    rect(0, 0, 20, height);
    rect(width-20, mouseY-rectSize/2, 10, rectSize); // rectangle is coloured neon blue 

    x = x + vx;
    y = y + vy;
    counter = counter + 1; // score is getting 1+ every time 

    if ( x > width-30 && x < width - 20 && y > mouseY - rectSize/2 && y < mouseY + rectSize/2)  
    {
      vx = vx * -1;
      kick.play();
    } 

    if (x < 25) 
    {
      vx = vx * -1.05;
      vy = vy * 1.05;  // vx and vy are increasing and decreasing by 1.05 
      x = x + vx;
      kick.play();
    }

    if ( y > height || y < 0 ) 
    {
      vy = vy * -1;
      kick.play(); // ball makes sound whenever it bounces or touches moving rectangle
    }
    textSize(15);

    if (x > width) // if ball goes beyond the moving rectangle then game over and resets 
    {
      fill(0);
      textFont(font);
      textSize(25);
      textAlign(CENTER);
      text("GAME OVER! \nThank you for playing! \n(Click or press R to reset)", width / 2, height / 2); 
      paused = true;
    } 
    
    fill(255,0,0);
    textFont(font2);
    textSize(25);
    text("SCORE: " + counter, width/2, 490); //displays score on the bottom 
  }
}

void mousePressed() 
{ 
  reset(); // if mouse is clicked ball resets back to original place
}

void keyPressed()
{
  if ( key == 'r' ) // if key 'r' is pressed ball resets back to original place
  {
    reset();
  }
}
