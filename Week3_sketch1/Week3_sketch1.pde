// I'm continuing my experimentation with transcendental curves
// This is the butterfly curve
// periodically elongating the ellipses in different directions
// gives a nice sense of depth, like a tube being twisted
// https://github.com/ELearningRufian/Processing/tree/master/Week3_sketch1

float canvasWidth = 800.0;
float canvasHeight = 640.0;
float pi = 3.1415926;
float size = 100.0;
color monarchButterfly[]       = { #FEFBCD, #68422F, #562E15, #F1C655, #FB8928 };
color monarchButterflyShades[] = { #F49B6E, #68422F, #B47352, #754A35, #4E3223 };
color complementaryDarkest = #046063;
color complementaryDarker = #155456;
color complementaryLighter = #079EA2;
color complementaryLightest = #0BE9EF;
int colorIndex = 0;
int frame = 0;

void setup()
{
  size((int)canvasWidth, (int)canvasHeight);
  background(complementaryDarker);
  frameRate(8);
}

void draw()
{
  colorIndex = (colorIndex+1) % 5;
  stroke(complementaryDarkest);
  fill(complementaryLighter);
  quad(80,320,400,0,720,320,400,640);
  fill(complementaryLightest);
  rect(150,70,500,500);

  for (float i = 2.0 * pi ; i > 0.0 ; i -= pi / 150.0)
  {   
    float centerX = canvasWidth  / 2.0 + size /2.0 * sin(i) * (exp(cos(i)) - 2.0 * cos(4.0 * i) - pow(sin(i / 12.0), 5));   
    float centerY = canvasHeight / 2.0 - size /2.0 * cos(i) * (exp(cos(i)) - 2.0 * cos(4.0 * i) - pow(sin(i / 12.0), 5));
    fill(monarchButterfly[colorIndex]);
    stroke(monarchButterflyShades[colorIndex]);
    ellipse(centerX, centerY, 25.0 * sin(i), 25.0 * cos(i));
    colorIndex = (colorIndex+1) % 5; // Loop from 0 to 4    
  }
  
  //// // Save the first 5 frames to disk
  //// if (frame++ < 5)
  //// {
  ////  saveFrame(String.format("butterfly-%1$d.png",frame));
  //// }
}
