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
  //saveFrame("movie/citibike-####.png");
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
  textFont(font18);
  fill(150);
  ellipse(rEdge-10, tBound-705, 6, 6);
  text("Citi Bike Station", rEdge-26, tBound-700);

  //Station and Ride Legend
  strokeWeight(1);
  stroke(0, 0, 255, 50);
  fill(150);
  noFill();
  stroke(150, 50);
  fill(0, 0, 255);
  text("Annual Member", rEdge-26, tBound-668);
  fill(0, 0, 255, 50);
  ellipse(rEdge-10, tBound-673, 22, 22);
  fill(255, 158, 0);
  text("Casual Member", rEdge-26, tBound-635);
  fill(255, 158, 0, 50);
  ellipse(rEdge-10, tBound-640, 22, 22);
  textAlign(LEFT);
  //Legend End

  //Title Begin
  fill(255);
  noStroke();
  fill(0, 80);
  rect(0, 0, width, 45);
  stroke(1);
  strokeWeight(.5);
  fill(255);
  line(0, 45, width, 45);
  textFont(font24);
  textSize(24);
  textAlign(CENTER);
  text("Citi Bike Trip Starts", width/2, 24);
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
  text(active_rides, lEdge+80, (tBound-630)); // rides on screen now

  //line structure for time/details
  strokeWeight(1);
  textAlign(LEFT);
  textSize(18);
  stroke(150);
  strokeWeight(1);
  line(lEdge, height-642, lEdge+80, height-642);
  line(lEdge+78, height-647, lEdge+78, height-342);


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
  text(currentDate, lEdge+85, (height - 575)); // date in timeline

  //weather display
  textFont(font18);
  textSize(18);
  if (currentDate.equals("9/17/13")) {
    fill(200);
    text("Weather", lEdge+85, height-542);
    text("66.9/51.4", lEdge+85, height-525);
    text("No Rain", lEdge+85, height-505);
  }
  else {
    text("Weather", lEdge+85, height-542);
    text("67.8/54.7", lEdge+85, height-525);
    text("No Rain", lEdge+85, height-505);
  }

  
  //time display
  fill(150);
  textFont(fontb36);
  textSize(36);
  text(newCurrentHour+":"+nf(currentMinutes, 2)+ampm, lEdge+85, (height - 600)); // date in timeline
  //End time and date
  
  println(currentTime);
  //println(float(10*60)/totalMinutes);
  
//Train Delay
  fill(255, 0, 0);
  if (currentDate.equals("9/17/13")) {
    if (currentTime > (float(10*60)/totalMinutes) && currentTime< (float(11*60)/totalMinutes)){
    //if ((newCurrentHour+":"+nf(currentMinutes, 2)+ampm).equals("10:01am")) {
      textFont(font12);
      text("Transit Delay", lEdge+85, height - 485 );
      text("4/5 Train", lEdge+85, height - 460 );
      text("Union Square", lEdge+85, height - 445 );
    }
    if ((newCurrentHour+":"+nf(currentMinutes, 2)+ampm).equals("11:25am")) {
      textFont(font12);
      text("Transit Delay", lEdge+85, height - 485 );
      text("4/5 Train", lEdge+85, height - 460 );
      text("Union Square", lEdge+85, height - 445 );
    }
    if ((newCurrentHour+":"+nf(currentMinutes, 2)+ampm).equals("12:48pm")) {
      textFont(font12);
      text("Transit Delay", lEdge+85, height - 485 );
      text("N/Q/R Train", lEdge+85, height - 460 );
      text("Times Square", lEdge+85, height - 445 );
    }
    if ((newCurrentHour+":"+nf(currentMinutes, 2)+ampm).equals("7:06pm")) {
      textFont(font12);
      text("Transit Delay", lEdge+85, height - 485 );
      text("L Train", lEdge+85, height - 460 );
      text("Union Square", lEdge+85, height - 445 );
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
  line(lEdge+10, height-60, lEdge+10, height-75-active_subscribers/3);
  stroke(255, 183, 0, 10);
  line(lEdge+35, height-60, lEdge+35, height-625);
  stroke(255, 183, 0);
  line(lEdge+35, height-60, lEdge+35, height-75-active_costumers/3);
  textFont(font24);
  fill(150);
  text( "Rider Total: " + plotted, lEdge+80, height-50);
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

