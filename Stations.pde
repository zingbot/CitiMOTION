class Stations {

  //Properties***********************
  String stationName;
  int stationID;
  float longitude;
  float latitude;
  String station_name;
  int station_id;
  float lon;
  float lat;

  //Constructor**********************
  Stations(String stationName, int stationID, float longitude, float latitude) {
    station_name = stationName;
    station_id = stationID;
    lon = map(longitude, mapGeoLeft, mapGeoRight, 0, width);
    lat = map(latitude, mapGeoTop, mapGeoBottom, 0, height);
  }

  //Methods**************************
  void plotStations() {
    
    //PFont  font10 = loadFont("OpenSans-10.vlw");
    noFill();
    //fill(150);
    stroke(100, 50);
    strokeWeight(2);
    ellipse(lon, lat, 8, 8);
    //noStroke();
    fill(150);
    //textFont(font10);
    strokeWeight(1);
    textSize(10);
      if (station_name.equals("Pershing Square N")) {
      textAlign(LEFT);
      text("Grand Central", lon+100, lat+50);
      line(lon, lat, lon+95, lat+45);
      //text(station_name, width-20, height-550);
    } 
      if (station_name.equals("E 17 St & Broadway")) {
      textAlign(LEFT);
      text("Union Square", lon+100, lat+50);
      line(lon, lat, lon+95, lat+45);
      //text(station_name, width-20, height-550);
    } 
      if (station_name.equals("Broadway & Battery Pl")) {
      textAlign(LEFT);
      text("Wall Street", lon-80, lat+40);
      line(lon, lat, lon-45, lat+30);
      //text(station_name, width-20, height-550);
    } 
    if (dist(mouseX, mouseY, lon, lat) < 5) {
      textAlign(LEFT);
      text(station_name, lon+10, lat-10);
      //text(station_name, width-20, height-550);
    } 
    else {
    }
  }
}

