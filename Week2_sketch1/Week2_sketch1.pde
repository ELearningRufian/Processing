size(800, 640);
background(0);
stroke(#1A1919);
float canvasWidth = 800.0;
float canvasHeight = 640.0;
fill(#FFFAF5);
quad(80,320,400,0,720,320,400,640);
rect(150,70,500,500);

float size = 100.0;
float growth = 0.0115;
colorMode(HSB);
for (int i=18;i>0;i--)
{   
   float centerX = canvasWidth / 2.0 + size * exp(i*growth) * cos(i);   
   float centerY = canvasHeight / 2.0 + size * exp(i*growth) * sin(i);
   int fill1 =(int)( cos(exp(i)*3) * 10.0 + 60.0);
   int fill2 =(int)( cos(exp(i)*4) * 100.0 + 150.0);
   int fill3 =(int)( cos(exp(i)*5) * 100.0 + 150.0);
   fill(fill1,fill2,fill3);
   ellipse(centerX,centerY,i*14.0,i*14.0);   
}
