import processing.serial.*;    // Importing the Serial library
import java.util.Map;          // Importing library to use HashMap
import ddf.minim.*;

AudioPlayer kick1;
AudioPlayer snare1;
AudioPlayer kick2;
AudioPlayer snare2;
AudioPlayer kick3;
AudioPlayer snare3;
AudioPlayer kick4;
AudioPlayer snare4;

Minim minim;
PFont helvetica;

Serial port;

String kick="good_kick.mp3";
String snare="snare_2.mp3";

String housekick = "housekick.mp3";
String housesnare = "housesnare.mp3";

String steelkick = "steelkick.mp3";
String steelsnare = "steelsnare.mp3";

String basskick = "basskick.mp3";
String basssnare = "basssnare.mp3";

String serialString;
HashMap<String, Integer> serialData = new HashMap<String, Integer>();

void setup() {
  // randomSeed(int(random(1, 10000)));
  fullScreen();
  background(255);
  frameRate(60);
  minim = new Minim(this);
  kick1 = minim.loadFile(kick);
  snare1 = minim.loadFile(snare);
  kick2 = minim.loadFile(housekick);
  snare2 = minim.loadFile(housesnare);
  kick3 = minim.loadFile(steelkick);
  snare3 = minim.loadFile(steelsnare);
  kick4 = minim.loadFile(basskick);
  snare4 = minim.loadFile(basssnare);
  
  String portName = "/dev/cu.usbmodem21101";  

  port = new Serial(this, portName, 9600);
  port.bufferUntil('\n');
}

void draw() {
  parseSerialData();
  
  if(!serialData.isEmpty()) {
    
    int kick = serialData.get("kick");
    int snare = serialData.get("snare");
    
    int vol = serialData.get("volume");
    float volume = map(vol, 0, 1023, -10.0, 10.0);
    float volVal = map(volume, -10.0, 10.0, 1.0, 100.0);
    
    int drumType = serialData.get("type");
    float type = int(map(drumType, 0, 1023, 1, 5));
    
    if(type == 1){
       background(255, 196, 184);
    }
    else if(type == 2){
      background(195, 255, 184);
    }
    else if(type == 3){
      background(184, 218, 255);
    }
    else if(type == 4){
      background(230, 184, 255);
    }
    textSize(128);
    fill(0, 0, 0);
    helvetica = createFont("helvetica.ttf", 100);
    textFont(helvetica);
    textSize(100);
    text("Volume: " + int(volVal) + "%", 400, 640);
    textSize(150);
    text("Play Me!", 450, 340);
    textSize(30);
    text("The left knob controls the volume", 500, 420);
    text("and the right one changes the sound profile", 420, 450);
    
    int kickthreshold = 10;
    int snarethreshold = 10;

    if(kick >= kickthreshold){
      if(type == 1){
        kick1.setGain(volume);
        kick1.rewind();
        kick1.play();
      }
      else if(type == 2){
        kick2.setGain(volume);
        kick2.rewind();
        kick2.play();      
      }
      else if(type == 3){
        kick3.setGain(volume);
        kick3.rewind();
        kick3.play();      
      }
      else if(type == 4){
        kick4.setGain(volume);
        kick4.rewind();
        kick4.play();      
      }

    }
    
    if(snare >= snarethreshold){
      if(type == 1){
        snare1.setGain(volume);
        snare1.rewind();
        snare1.play();
      }
      else if(type == 2){
        snare2.setGain(volume);
        snare2.rewind();
        snare2.play();      
      }
      else if(type == 3){
        snare3.setGain(volume);
        snare3.rewind();
        snare3.play();      
      }
      else if(type == 4){
        snare4.setGain(volume);
        snare4.rewind();
        snare4.play();      
      }
    }

  }
}
// serialEvent function 
  // Triggered whenever data is received over serial
void serialEvent(Serial p) {
  serialString = p.readString();
}

// parseSerialData function
  // Read the serialString variable of the form 
  // "Key1:Value1;Key2:Value2;Key3:Value3 ..."
  // And update the serialData HashMap
void parseSerialData() {
  // Delimiters used to split the string
  final String MAP_ITEMS_DELIMITER = ";";  // ; to split key-value pairs
  final String KEY_VALUE_DELIMITER = ":";  // : to split key and value
  
  if (serialString == null || serialString.length() == 0) {
    // Do nothing if empty string
    return;
  }
  
  String[] keyValuePairStrings = serialString.split(MAP_ITEMS_DELIMITER);
  
  for (String kvString : keyValuePairStrings) {
    String[] keyValuePair = kvString.split(KEY_VALUE_DELIMITER);
    if (keyValuePair == null || keyValuePair.length < 2) {
      // skip if we have bad input
      continue;
    }
    
    // trim our values now 
    String keyItem = trim(keyValuePair[0]);
    String value = trim(keyValuePair[1]);
    int itemValue = int(value);
    
    // Put the value into our hashmap
    serialData.put(keyItem, itemValue);
  } 

}
