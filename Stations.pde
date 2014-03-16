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
    //fill(150);
    stroke(100,50);
    strokeWeight(2);
    ellipse(lon, lat, 8, 8);
    noStroke();
    
  }
}