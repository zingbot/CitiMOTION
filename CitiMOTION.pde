float mapScreenWidth, mapScreenHeight;
float mapGeoLeft   = -74.04; 
//float mapGeoLeft   = -74.03;          
float mapGeoRight  =  -73.93;
//float mapGeoRight  =  -73.85;    
float mapGeoTop    =  40.775;
//float mapGeoTop    =  40.775;          
float mapGeoBottom =  40.67;     
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

  PFont fontLight = loadFont("Interstate-Light-48.vlw");
  PFont fontBlack = loadFont("Interstate-Black-48.vlw");
  textFont(fontLight);
  textSize(40);

  mapScreenWidth = width;
  mapScreenHeight = height;
  getStationInfo();
  getTripInfo();
}


void draw() {
  background(255);
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
  int edge = 20;
  int cInt = 150;
  float tBound = height-20;

//Color legend
  textSize(20);
  fill(0, 0, 255);
  text("Annual Users", edge, 100);
  fill(255, 158, 0);
  text("Ticket Buyers", edge, 130);
  textSize(14);
  text("(1 or 7 day passes)", edge, 150);

//Active rider bars
  textSize(27);
  fill(cInt);
  text(active_rides+" riders", edge, (height-70)); // rides on screen now
  
  
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

  text(currentDate+" "+newCurrentHour+":"+nf(currentMinutes, 2)+ampm, edge, (height - 40)); // date in timeline
  //  stroke(cInt);
  //  strokeWeight(1);
  //  line(edge, tBound, tBound, tBound); // timeline base
  //  strokeWeight(3);
  //  line(frameCount-edge, tBound-5, frameCount-edge, tBound+5); //timeline ticker (interactive slider?)

  // Activity bars: measure of the number of riders on screen
  strokeWeight(20);
  stroke(0, 0, 255);
  line(edge+10, height-120, edge+10, height-120-active_subscribers/4);
  stroke(255, 183, 0);
  line(edge+35, height-120, edge+35, height-120-active_costumers/4);
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

