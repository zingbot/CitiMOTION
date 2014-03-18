float mapScreenWidth, mapScreenHeight;
float mapGeoLeft   = -74.04; 
//float mapGeoLeft   = -74.03;          
float mapGeoRight  =  -73.92;
//float mapGeoRight  =  -73.85;    
float mapGeoTop    =  40.775;
//float mapGeoTop    =  40.775;          
float mapGeoBottom =  40.66;     
//float mapGeoBottom =  40.67;

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

Table myTable;

Stations[] myStation;
Rides[] myRide;

void setup() {
  //size(int(1920*.75), int(1080*.75));
  size(800, 800);
  background(255);
  smooth();
  frameRate(24);

  PFont  font24 = loadFont("OpenSans-24.vlw");
  PFont  font40 = loadFont("OpenSans-40.vlw");
  PFont  font10 = loadFont("OpenSans-10.vlw");
  PFont  font18 = loadFont("OpenSans-18.vlw");

  textFont(font40);
  textSize(40);

  mapScreenWidth = width;
  mapScreenHeight = height;
  getStationInfo();
  getTripInfo();
}


void draw() {
  background(255);
  PFont  font40 = loadFont("OpenSans-40.vlw");
  PFont  font28 = loadFont("OpenSans-28.vlw");
  PFont  font24 = loadFont("OpenSans-24.vlw");
  PFont  font18 = loadFont("OpenSans-18.vlw");
  PFont  font12 = loadFont("OpenSans-12.vlw");
  PFont  font10 = loadFont("OpenSans-10.vlw");

  active_rides = 0;
  active_costumers = 0;
  active_subscribers = 0;
  for (int i=0; i<myStation.length;i++) {
    myStation[i].plotStations();
  }
  for (int i=0; i<myRide.length;i++) {
    myRide[i].plotRides();
    active_costumers = active_costumers + myRide[i].costumers;
    active_rides = active_rides + myRide[i].activeRides;
    active_subscribers = active_subscribers + myRide[i].subscribers;
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

  // Credits
  fill(0);
  textAlign(LEFT);
  textFont(font18);
  textSize(18);
  fill(150);
  text("Sarah Kaufman", lEdge+480, tBound-50); 
  fill(150);
  textFont(font10);
  textSize(10);
  text("Rudin Center for Transportation", lEdge+480, tBound-35);
  text("NYU Wagner School", lEdge+480, tBound-20);
  fill(0);
  textFont(font18);

  textSize(18);
  fill(150);
  text("Jeff Ferzoco", lEdge+300, tBound-50);
  fill(150);
  textFont(font10);

  textSize(10);
  text("linepointpath.com", lEdge+300, tBound-35);

  textFont(font18);
  textSize(18);
  text("Juan F. Saldarriaga", lEdge+300, tBound-15);

  textFont(font10);
  textSize(10);
  text("with lots of help from", lEdge+650, tBound-50);
  textFont(font12);
  textSize(12);
  text("Ekene Ijoema", lEdge+650, tBound-35);
  text("David Stolarsky", lEdge+650, tBound-20);
  text("Chrys Wu", lEdge+650, tBound-5);

  //Color legend
  textAlign(LEFT);
  textFont(font18);
  textSize(18);
  fill(0, 0, 255);
  text("Annual Pass Holders", lEdge+60, tBound-150);
  fill(255, 158, 0);
  stroke(0, 0, 255);
  strokeWeight(1);
  line(lEdge+10, tBound-155, lEdge+55, tBound-155);
  text("Purchased a Ticket", lEdge+60, tBound-100);
  textSize(10);
  text("(1 or 7 day passes)", lEdge+60, tBound-90);
  stroke(255, 158, 0);
  strokeWeight(1);
  line(lEdge+40, tBound-100, lEdge+55, tBound-100);
  textAlign(LEFT);

  //Circle Legend
  strokeWeight(1);
  stroke(0, 0, 255, 50);
  noFill();
  //destination ring
  stroke(255, 158, 0);
  ellipse(rEdge-29, tBound-120, 30, 30);
  stroke(0, 0, 255);
  ellipse(rEdge-29, tBound-120, 25, 25);
  //station ring
  strokeWeight(2);
  stroke(100, 50);
  ellipse(rEdge-29, tBound-120, 16, 16);
  line(rEdge-29, tBound-120, rEdge-70, tBound-120);
  fill(150);
  text("Citibike", rEdge-105, tBound-120);
  text("Station", rEdge-105, tBound-110);
  text("Destination", rEdge-105, tBound-140);
  line(rEdge-50, tBound-140, rEdge-40, tBound-130);

  //Active rider bars
  textFont(font28);
  textSize(28);
  fill(cInt);
  text("Active Riders: "+ active_rides, lEdge, (tBound-50)); // rides on screen now
  strokeWeight(1);
  line(lEdge, tBound-80, rEdge, tBound-80);

  textSize(18);
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
    currentDate = "November 1st";
  }
  else {
    currentDate = "October 31st";
  }
  if (currentHour == 0) {
    newCurrentHour = 12;
  }
  else {
    newCurrentHour = currentHour;
  }

  text(currentDate+" "+newCurrentHour+":"+nf(currentMinutes, 2)+ampm, lEdge, (height - 40)); // date in timeline
  //  stroke(cInt);
  //  strokeWeight(1);
  //  line(edge, tBound, tBound, tBound); // timeline base
  //  strokeWeight(3);
  //  line(frameCount-edge, tBound-5, frameCount-edge, tBound+5); //timeline ticker (interactive slider?)

  // Activity bars: measure of the number of riders on screen
  strokeWeight(20);
  stroke(0, 0, 255);
  line(lEdge+10, height-120, lEdge+10, height-120-active_subscribers/4);
  stroke(255, 183, 0);
  line(lEdge+35, height-120, lEdge+35, height-120-active_costumers/4);
}

void keyPressed() {
  noLoop();
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
  myTable = loadTable("103113latlonpairsfinal.csv");
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
      if (startDay == 31) {
        start_day = 0;
      }
      else {
        start_day = 1;
      }
      startSeconds = startMinutes*60+start_day*24*60;
      myRide[i-1] = new Rides(startLon, startLat, endLon, endLat, tripDuration, startTime, startSeconds, userType);
    }
    else {
    }
  }
}

