float mapScreenWidth, mapScreenHeight;
//full map
float mapGeoLeft   = -74.055045;       
float mapGeoRight  = -73.921255;
float mapGeoTop    =  40.776837;
float mapGeoBottom =  40.675890;

int startingFrame = 4000;


//bk zoom
//float mapGeoLeft   = -74.000130;       
//float mapGeoRight  =  -73.959618;
//float mapGeoTop    =  40.705367;
//float mapGeoBottom =  40.684673; 

//// Midtown Zoom
//float mapGeoLeft   = -74.015691;       
//float mapGeoRight  =  -73.95262;
//float mapGeoTop    =  40.770018;
//float mapGeoBottom =  40.732168; 

//float mapGeoLeft   = -74.03; 
//float mapGeoRight  =  -73.85;    
//float mapGeoTop    =  40.775;          
//float mapGeoBottom =  40.67;

PImage backgroundMap;

int totalAnimationFrames = 10800;
int totalMinutes = 48*60;
float currentTime;
int currentMinutes;
int currentHour;
int newCurrentHour;
String newCurrentMinutes;
String ampm;
String currentDate;
int active_rides;
int active_costumers;
int active_subscribers;
int plotted;

Table myTable;

Stations[] myStation;
Rides[] myRide;

void setup() {
  //size(int(1920*.75), int(1080*.75));
  size(800, 800);
  background(255);
  backgroundMap   = loadImage("nyc.png");
  smooth();
  frameRate(18);



  textSize(40);
  mapScreenWidth = width;
  mapScreenHeight = height;
  getStationInfo();
  getTripInfo();
  frameCount = startingFrame;
}

void draw() {
  //scale(2);
  //delay(20);
  saveFrame("movie/citibike-#####.png");
  background(255);
  smooth();
  image(backgroundMap, 0, 0, mapScreenWidth, mapScreenHeight);

  PFont  font40 = loadFont("Archer-Book-40.vlw");
  PFont  font28 = loadFont("Archer-Book-28.vlw");
  PFont  font24 = loadFont("Archer-Book-24.vlw");
  PFont  font18 = loadFont("Archer-Book-18.vlw");
  PFont  font14 = loadFont("Archer-Book-14.vlw");
  PFont  font12 = loadFont("Archer-Book-12.vlw");
  PFont  font10 = loadFont("Archer-Book-10.vlw");
  PFont  fontb24 = loadFont("Archer-Bold-24.vlw");
  PFont  fontb36 = loadFont("Archer-Bold-36.vlw");
  PFont  fontb48 = loadFont("Archer-Bold-48.vlw");
  PFont  fontl36 = loadFont("Archer-Light-36.vlw");
  PFont  fontl24 = loadFont("Archer-Light-24.vlw");
  PFont  fontDigits = loadFont("TradeGothicLTStd-Light-36.vlw");
  PFont  fontDigits18 = loadFont("TradeGothicLTStd-Light-18.vlw");


  active_rides = 0;
  active_costumers = 0;
  active_subscribers = 0;
  plotted = 0;
  for (int i=0; i<myStation.length;i++) {
    myStation[i].plotStations();
  }
  for (int i=0; i<myRide.length;i++) {
    myRide[i].plotRides();
    active_costumers = active_costumers + myRide[i].costumers;
    active_rides = active_rides + myRide[i].activeRides;
    active_subscribers = active_subscribers + myRide[i].subscribers;
    plotted = plotted + myRide[i].mapped;
  }
  if (frameCount > totalAnimationFrames) {
    exit();
  }
  else {
  }


  //Interface Development
  int lEdge = 20;
  int rEdge = width-20;
  int cInt = 150;
  float tBound = height-20;

  //Begin Credits
  fill(0);
  textAlign(LEFT);
  textFont(font12);
  textSize(12);
  fill(150);
  text("Credits: Jeff Ferzoco – jeff@linepointpath.com  // Sarah Kaufman – Rudin Center for Transportation // Juan F. Saldarriaga – juanfrans@gmail.com", lEdge+0, tBound);
  text("and help from Ekene Ijoema, David Stolarsky, and Chrys Wu ", lEdge+240, tBound+12);
  fill(150);
  line(lEdge, tBound-15, rEdge, tBound-12);

  //End Credits

  //Begin Interface

  //Legend Begin
  //Citi Bike Station
  textAlign(RIGHT);
  fill(255, 90);
  rect(rEdge-180, tBound-530, 180, 140);
  textFont(font18);
  fill(200);
  ellipse(rEdge-20, tBound-505, 6, 6);
  fill(150);
  text("Citi Bike Station", rEdge-33, tBound-500);

  //Station and Ride Legend
  strokeWeight(1);
  stroke(0, 0, 255, 50);

  fill(150);
  noFill();
  stroke(150, 50);
  fill(0, 0, 255);
  text("Annual Member", rEdge-33, tBound-468);
  fill(0, 0, 255, 50);
  ellipse(rEdge-30, tBound-453, 22, 22);
  fill(255, 158, 0);
  text("Casual Member", rEdge-33, tBound-413);
  fill(255, 158, 0, 50);
  ellipse(rEdge-40, tBound-440, 22, 22);
  textAlign(LEFT);
  //Legend End

  //Title Begin
  fill(255);
  noStroke();
  fill(0, 80);
  rect(0, 0, width, 45);
  stroke(1);
  strokeWeight(.55);
  fill(255);
  line(0, 45, width, 45);
  textFont(font24);
  textSize(24);
  textAlign(CENTER);
  text("Citi Bike Trips", width/2, 24);
  textFont(font14);
  text("Tues, Sept. 17th & Wed, Sept 18th, 2013", width/2, 39);
  textAlign(LEFT);

  //Title End

  //Activity Bars Begin
  //Active rider tally
  textFont(font28);
  textSize(28);
  fill (200);
  text("Active", lEdge, tBound-700);
  text("Riders", lEdge, tBound-670);
  fill(150);
  textAlign(RIGHT);
  textFont(fontb36);
  textSize(36);
  fill(150);
  textFont(fontDigits);
  textSize(36);
  text(active_rides, lEdge+80, (tBound-630)); // rides on screen now
  textAlign(LEFT);
  textSize(18);
  textFont(fontDigits18);
  text( "Total: " + plotted, lEdge+90, height-650);

  //line structure for time/details
  strokeWeight(1);
  textAlign(LEFT);
  textSize(18);
  stroke(150);
  strokeWeight(1);
  line(lEdge, height-640, lEdge+180, height-640);
  line(lEdge+78, height-640, lEdge+78, height-342);


  //time and date display
  currentTime = float(frameCount)/totalAnimationFrames;
  currentHour = floor(48*currentTime)%12;
  currentMinutes = floor(currentTime*totalMinutes)%60;
  if (floor((48*currentTime)%24)<12) {
    ampm = "am";
  }
  else {
    ampm = "pm";
  }
  if (floor(48*currentTime)>23) {
    //currentDate = "November 1st";
    currentDate = "9/18/13";
  }
  else {
    currentDate = "9/17/13";
  }
  if (currentHour == 0) {
    newCurrentHour = 12;
  }
  else {
    newCurrentHour = currentHour;
  }
  //date display
  fill(150);
  textFont(font24);
  textSize(24);
  textFont(fontDigits18);
  text(currentDate, lEdge+85, (height - 575)); // date in timeline

  //weather display
  textFont(fontDigits18);
  textSize(18);
  if (currentDate =="9/17/13") {
    fill(200);
    text("Weather", lEdge+85, height-542);
    fill(150);
    text("67°"+" / " + "51°", lEdge+85, height-520);
    text("No Rain", lEdge+85, height-500);
  }
  else {
    fill(200);
    text("Weather", lEdge+85, height-542);
    fill(150);
    textFont(fontDigits18);
    text("67°" +" / "+"55°", lEdge+85, height-520);
    text("No Rain", lEdge+85, height-500);
  }


  //time display
  fill(150);
  textAlign(LEFT);
  textFont(fontDigits);
  textSize(30);
  text(newCurrentHour+":"+nf(currentMinutes, 2)+""+ampm, lEdge+83, (height - 600)); // date in timeline
  //End time and date

  //Train Delay
  fill(255, 0, 0);
  int tdText=height-475;
  int trText=height-460;
  int locText=height-445;
  int lineText=lEdge+85;
  if (currentDate.equals("9/17/13")) {
    if (currentTime > (float(7*60)/totalMinutes) && currentTime< (float(8*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("2/3 trains", lineText, trText );
      text("Wall Street", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(250, 560, 25, 25);
      //ellipse(390, 300, 7, 7);
    }
    if (currentTime > (float(9*60)/totalMinutes) && currentTime< (float(12*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("4/5 Trains", lineText, trText );
      text("Union Square", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(380, 290, 25, 25);
    }
    if (currentTime > (float(11*60)/totalMinutes) && currentTime< (float(13*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("N/Q/R Trains", lineText, trText );
      text("Times Square", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(400, 130, 25, 25);
    } 
    if (currentTime > (float(18*60)/totalMinutes) && currentTime< (float(19*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("2/3 Train", lineText, trText );
      text("Atlantic AVenue", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(430, 680, 25, 25);
    }
    if (currentTime > (float(18*60)/totalMinutes) && currentTime< (float(19*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("L Train", lineText, trText+40 );
      text("Union Square", lineText, locText+40 );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(380, 290, 25, 25);
    }
  }
  else {
    //println(float(14*60)/totalMinutes, currentTime);
    if (currentTime > (float((24+3)*60)/totalMinutes) && currentTime< (float((24+4)*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("N trains", lineText, trText );
      text("57th/7", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(440, 80, 25, 25);
      //ellipse(390, 300, 7, 7);
    }
    if (currentTime > (float((24+8)*60)/totalMinutes) && currentTime< (float((24+9)*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("B/D Trains", lineText, trText );
      text("West 4th St", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(300, 330, 25, 25);
    }
    if (currentTime > (float((24+12)*60)/totalMinutes) && currentTime< (float((24+13)*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("L Trains", lineText, trText );
      text("Atlantic Ave.", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(430, 680, 25, 25);
    } 
    if (currentTime > (float((24+13)*60)/totalMinutes) && currentTime< (float((24+14)*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("J Train", lineText, trText );
      text("Broad Street", lineText, locText );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(260, 550, 25, 25);
    }
    if (currentTime > (float((24+16)*60)/totalMinutes) && currentTime< (float((24+17)*60)/totalMinutes)) {
      textFont(font14);
      text("Transit Delay:", lineText, tdText );
      textFont(font12);
      text("R Train", lineText, trText+40 );
      text("Canal St.", lineText, locText+40 );
      noFill();
      strokeWeight(3);
      stroke(255, 0, 0, 70);
      rect(340, 410, 25, 25);
    }
  }

  //Begin activity bars
  // Activity bars: measure of the number of riders on screen
  //labels
  textAlign(LEFT);
  textFont(font18);
  textSize(18);
  fill(0, 0, 255);
  text("Annual Members", lEdge+80, tBound-120);
  fill(255, 158, 0);
  stroke(0, 0, 255);
  strokeWeight(1);
  line(lEdge+10, tBound-125, lEdge+75, tBound-125);
  text("Casual Members", lEdge+80, tBound-75);
  stroke(255, 158, 0);
  strokeWeight(1);
  line(lEdge+40, tBound-80, lEdge+75, tBound-80);
  textAlign(LEFT);

  //active rider bars and background
  strokeWeight(20);
  stroke(0, 0, 255, 10);
  line(lEdge+10, height-60, lEdge+10, height-625);
  stroke(0, 0, 255);
  line(lEdge+10, height-60, lEdge+10, height-75-active_subscribers/2);
  stroke(255, 183, 0, 10);
  line(lEdge+35, height-60, lEdge+35, height-625);
  stroke(255, 183, 0);
  line(lEdge+35, height-60, lEdge+35, height-75-active_costumers/2);
  textFont(font24);
  fill(150);
}
//end active bars

void keyPressed() {
  noLoop();
  if (key == CODED) {
    if (keyCode == RIGHT) {
      currentHour = currentHour+1;
    } 
    else if (keyCode == LEFT) {
      currentHour = currentHour-1;
    }
  }
}

void keyReleased() {
  loop();
}

int getCurrentTime() {
  return frameCount;
}



void getStationInfo() {
  String stationName;
  int stationID;
  float longitude;
  float latitude;

  JSONObject baseData = loadJSONObject("CitiBikeData_1.json");
  JSONArray stationBeanList = baseData.getJSONArray("stationBeanList");
  myStation = new Stations[stationBeanList.size()];

  for (int i=0;i<stationBeanList.size();i++) {
    JSONObject thisStation = stationBeanList.getJSONObject(i);
    stationID = thisStation.getInt("id");
    longitude = thisStation.getFloat("longitude");
    latitude = thisStation.getFloat("latitude");
    stationName = thisStation.getString("stationName");
    myStation[i] = new Stations(stationName, stationID, longitude, latitude);
  }
}

void getTripInfo() {
  //myTable = loadTable("103113latlonpairsfinalTENROUTE.csv");
  myTable = loadTable("917n1813latlonpairs.csv");
  //myTable = loadTable("103113latlonpairsfinal.csv");
  float startLon;
  float startLat;
  float endLon;
  float endLat;
  int tripDuration;
  String userType;
  String startTime;
  int startSeconds;
  String[] baseDataTime;
  String date;
  String hour;
  String[] hour2;
  String[] date2;
  int startMinutes;
  int startDay;
  int start_day;
  myRide = new Rides[myTable.getRowCount()-1];

  for (int i=1;i<myTable.getRowCount(); i++) {

    if (myTable.getString(i, 3) != null) {
      startLon = float(myTable.getString(i, 10));
      startLat = float(myTable.getString(i, 9));
      endLon = float(myTable.getString(i, 13));
      endLat = float(myTable.getString(i, 12));
      tripDuration = int(myTable.getString(i, 0));
      userType = myTable.getString(i, 6);
      startTime = myTable.getString(i, 1);
      baseDataTime = split(myTable.getString(i, 1), " ");
      date = baseDataTime[0];
      hour = baseDataTime[1];
      hour2 = split(hour, ":");
      startMinutes = 60*(int(hour2[0]))+int(hour2[1]);
      date2 = split(date, "/");
      startDay = int(date2[1]); 
      if (startDay == 17) {
        start_day = 0;
      }
      else {
        start_day = 1;
      }
      startSeconds = startMinutes*60+start_day*24*60*60;
      myRide[i-1] = new Rides(startLon, startLat, endLon, endLat, tripDuration, startTime, startSeconds, userType);
    }
    else {
    }
  }
}

