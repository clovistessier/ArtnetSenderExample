import ch.bildspur.artnet.*;

ArtNetClient artnet;
byte[] dmxData = new byte[512];

String remote = new String("192.168.8.201");;

final int FRAME_RATE = 60;

final int NUM_COLORS = 8;
color[] colors = new color[NUM_COLORS];


final int NUM_LEDS = 75;
byte[][] artnetData = new byte[8][512];

byte[][] sharedArtnetData = new byte[8][512];
final Object artnetLock = new Object();

float brightness;



void setup() {
  size(400, 400);
  frameRate(FRAME_RATE);

  // set up color wheel based on number of strips for this example
  colorMode(HSB, 255, 255, 255);
  for (int i = 0; i < NUM_COLORS; i++) {
    colors[i] = color(((i*255)/NUM_COLORS), 255, 255);
  }
  colorMode(RGB, 255, 255, 255);

  // create artnet client without buffer (no receving needed)
  artnet = new ArtNetClient(null);
  artnet.start();
  
  // initialize the artnetData and sharedArtnetData arrays
  synchronized(artnetLock) {
    for (int i = 0; i < artnetData.length; i++) {
      for (int j = 0; j < artnetData[i].length; j++) {
        artnetData[i][j] = 0;
        sharedArtnetData[i][j] = 0;
      }
    }
  }

  new ArtnetSenderThread(artnet, remote, sharedArtnetData, artnetLock).start();
}

void draw() {
  // set the brightness based on mouseX position for this example
  brightness = map(mouseX, 0, width, 0, 1.0);

  // fill artnet array  
  for (int i = 0; i < NUM_COLORS; i++) {
    // empty the dmxData array
    for (int j = 0; j < artnetData[i].length; j++) {
      artnetData[i][j] = 0;
    }

    // fill the dmxData array
    // in this example we fill each strip with a different color
    color c = colors[i];
    for (int j = 0; j < NUM_LEDS; j++) {
      artnetData[i][j*3 + 0] = (byte)(red(c)*brightness);
      artnetData[i][j*3 + 1] = (byte)(green(c)*brightness);
      artnetData[i][j*3 + 2] = (byte)(blue(c)*brightness);
  }
  }

  // Copy artnetData to sharedArtnetData safely
  synchronized(artnetLock) {
    for (int i = 0; i < artnetData.length; i++) {
      System.arraycopy(artnetData[i], 0, sharedArtnetData[i], 0, artnetData[i].length);
    }
  }
}