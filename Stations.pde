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

    noFill();
    //fill(200);
    stroke(100, 50);
    strokeWeight(1);
    //noStroke();
    ellipse(lon, lat, 6, 6);
    //noStroke();

    //Landmarks

    fill(70);
    //textFont(font10);
    strokeWeight(1);
    textSize(10);
    if (station_name.equals("Pershing Square N")) {
      textAlign(LEFT);
      text("Grand Central", lon+70, lat+50);
      line(lon, lat, lon+65, lat+45);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("E 17 St & Broadway")) {
      textAlign(LEFT);
      text("Union Square", lon+170, lat+50);
      line(lon, lat, lon+165, lat+45);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("Broadway & Battery Pl")) {
      textAlign(LEFT);
      text("Wall Street", lon-80, lat+40);
      line(lon, lat, lon-45, lat+30);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("Atlantic Ave & Fort Greene Pl")) {
      textAlign(LEFT);
      text("Barclays Center", lon-70, lat+25);
      line(lon, lat, lon-25, lat+20);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("Central Park S & 6 Ave")) {
      textAlign(LEFT);
      text("Central Park South", lon+30, lat-30);
      line(lon, lat, lon+25, lat-30);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("Pearl St & Anchorage Pl")) {
      textAlign(LEFT);
      text("Dumbo", lon-140, lat+65);
      line(lon-30, lat+10, lon-105, lat+55);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("S 3 St & Bedford Ave")) {
      textAlign(LEFT);
      text("Williamsburg", lon+50, lat-25);
      line(lon, lat, lon+50, lat-20);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("W 42 St & 8 Ave")) {
      textAlign(LEFT);
      text("Port Authority", lon-190, lat-15);
      line(lon, lat, lon-120, lat-15);
      //text(station_name, width-20, height-550);
    } 
    if (station_name.equals("8 Ave & W 33 St")) {
      textAlign(LEFT);
      text("Penn Station", lon-190, lat-15);
      line(lon, lat, lon-130, lat-15);
      //text(station_name, width-20, height-550);
    } 
    if (dist(mouseX, mouseY, lon, lat) < 5) {
      textAlign(LEFT);
      noStroke();
      fill(255);
      rect(lon+5, lat-20, 150, 15);
      fill(0);
      text(station_name, lon+10, lat-10);
      //text(station_name, width-20, height-550);
    } 
    else {
    }
  }
}

