float mapScreenWidth, mapScreenHeight;
//full map
float mapGeoLeft   = -74.055045;       
float mapGeoRight  = -73.921255;
float mapGeoTop    =  40.776837;
float mapGeoBottom =  40.675890;     

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
  frameRate(24);



  textSize(40);
  mapScreenWidth = width;
  mapScreenHeight = height;
  getStationInfo();
  getTripInfo();
}

void draw() {
  //delay(20);
  saveFrame("movie/citibike-####.png");
  background(255);
  smooth();
  image(backgroundMap, 0, 0, mapScreenWidth, mapScreenHeight);

  PFont  font40 = loadFont("Archer-Book-40.vlw");
  PFont  font28 = loadFont("Archer-Book-28.vlw");
  PFont  font24 = loadFont("Archer-Book-24.vlw");
  PFont  font18 = loadFont("Archer-Book-18.vlw");
  PFont  font12 = loadFont("Archer-Book-12.vlw");
  PFont  font10 = loadFont("Archer-Book-10.vlw");
  PFont  fontb24 = loadFont("Archer-Bold-24.vlw");
  PFont  fontb36 = loadFont("Archer-Bold-36.vlw");
  PFont  fontb48 = loadFont("Archer-Bold-48.vlw");
  PFont  fontl36 = loadFont("Archer-Light-36.vlw");
  PFont  fontl24 = loadFont("Archer-Light-24.vlw");



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
  println(plotted+" bike rides plotted.");
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
  textFont(font12);

  textSize(12);
  fill(150);
  text("Credits: Jeff Ferzoco (jeff@linepointpath.com) // Juan F. Saldarriaga (juanfrans@gmail.com) // Sarah Kaufman (Rudin Center for Transportation)", lEdge+0, tBound);
  text("and help from Ekene Ijoema, David Stolarsky, and Chrys Wu ", lEdge+240, tBound+12);
  fill(150);



  //Color legend
  textAlign(LEFT);
  textFont(font18);
  textSize(18);
  fill(0, 0, 255);
  text("Annual Pass Holders", lEdge+80, tBound-120);
  fill(255, 158, 0);
  stroke(0, 0, 255);
  strokeWeight(1);
  line(lEdge+10, tBound-125, lEdge+75, tBound-125);
  text("Purchased a Ticket", lEdge+80, tBound-100);
  text("(1 or 7 day passes)", lEdge+80, tBound-80);
  stroke(255, 158, 0);
  strokeWeight(1);
  line(lEdge+40, tBound-100, lEdge+75, tBound-100);
  textAlign(LEFT);

  //Circle Legend
  strokeWeight(1);
  stroke(0, 0, 255, 50);
  fill(150);
  //text("Legend", rEdge-70, tBound-550);
  noFill();
  stroke(150, 50);
  //rect(rEdge-125, tBound-540, 200, 130);
  fill(0, 0, 255);
  textAlign(RIGHT);
  text("Annual Pass", rEdge-30, tBound-680);
  text("Bike Pickup", rEdge-30, tBound-665);
  fill(0, 0, 255, 50);
  ellipse(rEdge-10, tBound-680, 22, 22);
  fill(255, 158, 0);
  text("Ticketed Rider", rEdge-30, tBound-640);
  text("Bike Pickup", rEdge-30, tBound-625);

  fill(255, 158, 0, 50);
  ellipse(rEdge-10, tBound-640, 22, 22);

  //CitibikeStation
  noFill();
  strokeWeight(2);
  stroke(100, 50);
  ellipse(rEdge-10, tBound-719, 11, 11);
  fill(150);
  text("Citibike Station", rEdge-30, tBound-715);
  //line(rEdge-29, tBound-520, rEdge-60, tBound-520);
  //line(rEdge-40, tBound-540, rEdge-30, tBound-530);
  textAlign(LEFT);

  //Title
  fill(255);
  noStroke();
  fill(255, 80);
  rect(0, 0, width, 50);
  stroke(1);
  strokeWeight(.5);
  fill(150);
  line(0, 40, width, 40);
  textFont(fontb24);
  textSize(24);
  text("Citibike Rides", 10, 30);
  textFont(fontl24);
  text("September 17th and 18th, 2013", 190, 30);

  //Active rider bars
  textFont(font28);
  textSize(28);
  fill (200);
  text("Active", lEdge, tBound-700);
  text("Riders", lEdge, tBound-670);
  fill(150);
  textAlign(RIGHT);
  textFont(fontb36);
  textSize(36);
  fill(0, 0, 255);
  text(active_rides, lEdge+80, (tBound-630)); // rides on screen now
  strokeWeight(1);
  line(lEdge, tBound-12, rEdge, tBound-12);
  textAlign(LEFT);

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

  fill(150);
  textFont(font24);
  textSize(24);
  text(currentDate, lEdge+85, (height - 575)); // date in timeline
  textFont(fontl36);
  textSize(36);
  text(newCurrentHour+":"+nf(currentMinutes, 2)+ampm, lEdge+85, (height - 600)); // date in timeline

  // Activity bars: measure of the number of riders on screen
  stroke(150);
  strokeWeight(1);
  line(lEdge, height-642, lEdge+80, height-642);
  line(lEdge+78, height-647, lEdge+78, height-542);

  strokeWeight(20);
  stroke(0, 0, 255, 10);
  line(lEdge+10, height-60, lEdge+10, height-625);
  stroke(0, 0, 255);
  line(lEdge+10, height-60, lEdge+10, height-75-active_subscribers/4);
  stroke(255, 183, 0, 10);
  line(lEdge+35, height-60, lEdge+35, height-625);
  stroke(255, 183, 0);

  line(lEdge+35, height-60, lEdge+35, height-75-active_costumers/4);
  textFont(font10);
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

