// I'm continuing my experimentation with transcendental curves
// In engineering school, one of the "fun" laboratories was watching Lissajous curves
// on an oscilloscope while playing with signals of varying phases and frequencies
// I would like to recreate some of that feeling for other people to enjoy
// The starting point is a blank oscilloscope screen because it makes much more sense
// from an experience point of view. I hope you find it ok, even though it is not an empty background
// If I knew how to do sound in processing, I would add a 50 or 60 Hz Hum for added realism :D
// https://github.com/ELearningRufian/Processing/tree/master/Week4_sketch1

float screenWidth = 800.0;
float frameWidth = 10.0;
float frameRadius = 10.0;
float centerCoordinate = frameWidth + 0.5 * screenWidth;
float pi = 3.1415926;
float size = 100.0;
color phosphorOff = #082c5e;
color phosphorOn[] = { #b0fbff, #a0fbff, #90fbff, #80fbff, #70fbff };
color grid = #022a2d;
color frame = #0c0d11;
int colorIndex = 0;

float horizontalAmplitude = 350.0;
float verticalAmplitude = 350.0;
float horizontalFrequency = 3;
float verticalFrequency = 4;
float phaseDifference = pi * 0.5;

void setup()
{
  size((int)(screenWidth+2.0*frameWidth), (int)(screenWidth+2.0*frameWidth));
  background(frame);
  smooth();
  frameRate(5);
  blankOscilloscope();
}

void draw()
{
   if(mousePressed)
   {
     horizontalAmplitude = mouseX - screenWidth * 0.5 - frameWidth;
     verticalAmplitude = horizontalAmplitude; /* use square aspect ratios for now */
     float x = centerCoordinate + horizontalAmplitude * sin(phaseDifference);
     float y = centerCoordinate; 
     stroke(phosphorOn[0]);
     for (float t = 4.0 * pi ; t > 0.0 ; t -= pi / 150.0)
     {
       float x1 = centerCoordinate + horizontalAmplitude * sin(horizontalFrequency * t + phaseDifference);
       float y1 = centerCoordinate + verticalAmplitude * sin(verticalFrequency * t);
       line(x,y,x1,y1);
       x=x1;
       y=y1;
     }
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
      saveFrame("screenshot.png");
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
  }
}

private void blankOscilloscope()
{
  fill(phosphorOff);
  rect(frameWidth,frameWidth,screenWidth,screenWidth,frameRadius);
  stroke(grid);
  for (float i = screenWidth * 0.1; i < screenWidth; i += screenWidth * 0.1)
  {
    line(frameWidth,frameWidth+i, frameWidth+screenWidth, frameWidth+i);
    line(frameWidth+i, frameWidth, frameWidth+i, frameWidth+screenWidth);
  }
}
