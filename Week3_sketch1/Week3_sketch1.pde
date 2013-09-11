// I'm continuing my experimentation with transcendental curves
// This is the butterfly curve
// periodically elongating the ellipses in different directions
// gives a nice sense of depth, like a tube being twisted
// https://github.com/ELearningRufian/Processing/tree/master/Week3_sketch1

float canvasWidth = 800.0;
float canvasHeight = 640.0;
float pi = 3.1415926;
float size = 100.0;

void setup()
{
  size((int)canvasWidth, (int)canvasHeight);
  background(#042004);
}

void draw()
{
  stroke(#1A1919);
  fill(#C6E8A2);
  quad(80,320,400,0,720,320,400,640);
  fill(#E0E0CC);
  rect(150,70,500,500);

  colorMode(HSB);
  for (float i = 2.0 * pi ; i > 0.0 ; i -= pi / 100.0)
  {   
    float centerX = canvasWidth  / 2.0 + size /2.0 * sin(i) * (exp(cos(i)) - 2.0 * cos(4.0 * i) - pow(sin(i / 12.0), 5));   
    float centerY = canvasHeight / 2.0 - size /2.0 * cos(i) * (exp(cos(i)) - 2.0 * cos(4.0 * i) - pow(sin(i / 12.0), 5));
    int fill1 =(int)(cos(i) * 194.0 +  30.0);
    int fill2 =(int)(cos(i * 3.0) * 100.0 + 150.0);
    int fill3 =(int)(cos(i * 5.0) * 150.0 + 180.0);
    fill(fill1,fill2,fill3,90);
    stroke(fill1,fill2,fill3);
    ellipse(centerX, centerY, 25.0 * sin(i), 25.0 * cos(i));   
  }
}
