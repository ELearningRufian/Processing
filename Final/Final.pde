// This sketch approximates an interpretation of Terry Riley's score "In C"
// The score specifies sound snippets and rules and recommendations for
// playing them. In the short time available for this project I won't be able
// to implement all the rules but I think it is possible to achieve an
// approximation that will be sufficiently interesting to play with

import ddf.minim.*;

Minim minim;
// The implementation is based files containing recorded fragments
// Each instrument (voice) will use a different player so that
// they can play simultaneously
AudioPlayer[] player;
// The correct number of fragments is 53 but it will take time to
// get them ready and I'd rather start programming before all the
// audio is ready
int fragmentCount = 15;
// The intention is to make it multi-voice but the first attempt is single-voice
int voiceCount = 1;
// Each voice will be playing a specific fragment (0 to 52)
int[] voicePosition;
// We will need a table of file names
// each voice in each row
// each fragment in each column
// Initially I will have only one instrument
// but in a future version this will give use the flexibility of having
// different instruments in each voice
// e.g., files for PianoAndStrings from 1 to 53 on voice 1
// files for Clarinet from 1 to 53 on voice 2, etc
String[][] voiceFile;

void setup()
{
  size(1024, 768, P3D);
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  voiceFile = new String[voiceCount][fragmentCount]; 
  player = new AudioPlayer[voiceCount];
  voicePosition = new int[voiceCount];
  initializeVoiceFile(0,"PianoAndStrings");
}

void initializeVoiceFile(int voiceNumber, String instrumentName)
{
  if (voiceCount <= voiceNumber)
  {
    // Ignore attempts to initialize voices above the current voice count
    return;
  }
  
  voicePosition[voiceNumber] = 0;
  for (int fragmentIndex = 0; fragmentIndex < fragmentCount; ++fragmentIndex)
  {
    // The fragment names start at 01 but the array starts at 0 so we need to add 1
    // e.g., voice[1][0] = "PianoAndStrings_01.wav"
    voiceFile[voiceNumber][fragmentIndex]=String.format("%s_%02d.wav",instrumentName,fragmentIndex+1);
  }
}

void draw()
{
  background(0);
  stroke(255);

  for (int voiceIndex = 0; voiceIndex < voiceCount ; ++voiceIndex)
  {
    if (null == player[voiceIndex] || !player[voiceIndex].isPlaying() && !player[voiceIndex].isLooping() && fragmentCount > voicePosition[voiceIndex])
    {
      player[voiceIndex] = minim.loadFile(voiceFile[voiceIndex][voicePosition[voiceIndex]]);
      player[voiceIndex].play();
      voicePosition[voiceIndex]++;
    }
  }
    
  // draw the waveforms (modified version of the example in the Minim documentation for the play() method) 
  for(int i = 0; i < player[0].bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player[0].bufferSize(), 0, width );
    float x2 = map( i+1, 0, player[0].bufferSize(), 0, width );
    line( x1, 50 + player[0].left.get(i)*50, x2, 50 + player[0].left.get(i+1)*50 );
    line( x1, 150 + player[0].right.get(i)*50, x2, 150 + player[0].right.get(i+1)*50 );
  }
  
  // Exit when the last voice is done 
  if (voicePosition[voiceCount -1] == fragmentCount && !player[voiceCount-1].isPlaying())
  {
    exit();
  }
}


