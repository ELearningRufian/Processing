// I'm continuing my experimentation with transcendental curves
// In engineering school, one of the "fun" laboratories was watching Lissajous curves
// on an oscilloscope while playing with signals of varying phases and frequencies
// I would like to recreate some of that feeling for other people to enjoy
// The starting point is a blank oscilloscope - it is not a flat background
// I'm know I'm asking for flexibility in the definition of 'blank'
// but I hope you will agree it fits a specific artistic purpose
// both for recreating the "oscilloscope feeling" and for assisting in the drawing 
// (I can get better results if I can see how far from the center I am before the first click)
//
// If I knew how to do sound in processing, I would add a 50 or 60 Hz Hum for added realism :D
//
// Instructions
//   1-Specify the frequency ratio using the following keys:
//     1,2,3,4,5 for Horizontal frequency
//     q,w,e,r,t for Vertical frequency
//     (the default is 3,r)
//   2-Specify the phase difference with the following keys
//     h,j,k,l (0 to 1.5 PI in PI/2 increments)
//     (the default is j) 
//   3-Specify the beam intensity using the following keys
//     y,u,i,o,p (y is the less intense, p is the most)
//     (the default is y)
//   4-Using the mouse, click  the screen (single clicks or click-and-drag are both ok)
//     the further away from the center, the larger the image will be
//   5-Click s to save the current drawing
//   6-Click c (or a delete key) to clear the current drawing and start again
//
// This sketch is designed for qwerty keyboards, 
// on other keyboards (e.g., azerty) it will be less intuitive, sorry!
//
// https://github.com/ELearningRufian/Processing/tree/master/Week4_sketch1

/* Constants */
float screenWidth = 800.0;
float frameWidth = 10.0;
float frameRadius = 10.0;
float centerCoordinate = frameWidth + 0.5 * screenWidth;
color phosphorOff = #082c5e;
color phosphorOn[] = { 0x2280fbff, 0x4480fbff, 0x6680fbff, 0x8880fbff, 0xaa80fbff };
color grid = #022a2d;
color frame = #0c0d11;

/* Defaults */
color curveColor = phosphorOn[4];
float horizontalFrequency = 3;
float verticalFrequency = 4;
float phaseDifference = PI * 0.5;

void setup()
{
  size((int)(screenWidth+2.0*frameWidth), (int)(screenWidth+2.0*frameWidth));
  smooth();
  frameRate(10);
  blankOscilloscope();
}

void draw()
{
   if(mousePressed)
   {
     float amplitude = constrain(max(abs(mouseX - centerCoordinate), abs(mouseY - centerCoordinate)), 0.0, screenWidth * 0.5);
     float x = centerCoordinate + amplitude * sin(phaseDifference);
     float y = centerCoordinate;      
     for (float t = 0 ; t <= 2.0 * PI; t += PI / 1000.0)
     {
       float x1 = centerCoordinate + amplitude * sin(horizontalFrequency * t + phaseDifference);
       float y1 = centerCoordinate + amplitude * sin(verticalFrequency * t);
       stroke(curveColor);       
       line(x,y,x1,y1);
       x=x1;
       y=y1;
     }
     drawGrid(); /* Keeping the grid "on top", for that "oscilloscope feeling" */
   }
}

void keyReleased()
{
  switch (key)
  {
    case 'c':
    case 'C':
    case DELETE:
    case BACKSPACE:
      blankOscilloscope();
      break;
    case 's':
    case 'S':
      saveFrame("Lissajous.png");
      break;
    case '1':
      horizontalFrequency = 1;
      break;
    case '2':
      horizontalFrequency = 2;
      break;
    case '3':
      horizontalFrequency = 3;
      break;
    case '4':
      horizontalFrequency = 4;
      break;
    case '5':
      horizontalFrequency = 5;
      break;
    case 'q':
    case 'Q':
      verticalFrequency = 1;
      break;
    case 'w':
    case 'W':
      verticalFrequency = 2;
      break;
    case 'e':
    case 'E':
      verticalFrequency = 3;
      break;
    case 'r':
    case 'R':
      verticalFrequency = 4;
      break;
    case 't':
    case 'T':
      verticalFrequency = 5;
      break;
    case 'y':
    case 'Y':
      curveColor = phosphorOn[0];
      break;
    case 'u':
    case 'U':
      curveColor = phosphorOn[1];
      break;
    case 'i':
    case 'I':
      curveColor = phosphorOn[2];
      break;
    case 'o':
    case 'O':
      curveColor = phosphorOn[3];
      break;
    case 'p':
    case 'P':
      curveColor = phosphorOn[4];
      break;
    case 'h':
    case 'H':
      phaseDifference = 0;
      break;
    case 'j':
    case 'J':
      phaseDifference = PI * 0.5;
      break;
    case 'k':
    case 'K':
      phaseDifference = PI;
      break;
    case 'l':
    case 'L':
      phaseDifference = PI * 1.5;
      break;
  }
}

private void blankOscilloscope()
{
  background(frame);
  fill(phosphorOff);
  rect(frameWidth,frameWidth,screenWidth,screenWidth,frameRadius);
  drawGrid();
}

private void drawGrid()
{
  stroke(grid);
  for (float i = screenWidth * 0.1; i < screenWidth; i += screenWidth * 0.1)
  {
    line(frameWidth,frameWidth+i, frameWidth+screenWidth, frameWidth+i);
    line(frameWidth+i, frameWidth, frameWidth+i, frameWidth+screenWidth);
  }
}
