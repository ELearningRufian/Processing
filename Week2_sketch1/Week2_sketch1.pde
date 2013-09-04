size(800, 640);
background(0xFFFAF5);
stroke(0x1A1919);
float canvasWidth = 800.0;
float canvasHeight = 640.0;

float size = 100.0;
float growth = 0.0115;
//colorMode(HSB);
for (int i=20;i>0;i--)
{   
   float centerX = canvasWidth / 2.0 + size * exp(i*growth) * cos(i);   
   float centerY = canvasHeight / 2.0 + size * exp(i*growth) * sin(i);
   int fill1 =(int)( cos(exp(i)*3.14) * 128.0 + 128.0);
   int fill2 =(int)( cos(exp(i)*6.28) * 128.0 + 128.0);
   int fill3 =(int)( cos(exp(i)*9.42) * 128.0 + 128.0);
   fill(fill1,fill2,fill3);
   ellipse(centerX,centerY,i*14.0,i*14.0);   
}
