class Rides {

  //Properties******************************
  float startLon;
  float startLat;
  float endLon;
  float endLat;
  PVector start;
  PVector end;
  float counter;
  float tripTime;
  int tripDuration;
  int trip_duration;
  String userType;
  String user_type;
  String startTime;
  int startFrame;
  int startSeconds;
  int start_seconds;
  float percentTraveled;
  float travelled;
  
 
  //Constructor*****************************
  Rides(float startLon, float startLat, float endLon, float endLat, int tripDuration, String startTime, int startSeconds, String userType) {
    start = new PVector(map(startLon, mapGeoLeft, mapGeoRight, 0, width), map(startLat, mapGeoTop, mapGeoBottom, 0, height));
    end = new PVector(map(endLon, mapGeoLeft, mapGeoRight, 0, width), map(endLat, mapGeoTop, mapGeoBottom, 0, height));
    trip_duration = (tripDuration*totalAnimationFrames)/172800;
    start_seconds = (startSeconds*totalAnimationFrames)/172800;
    user_type = userType;
  }

  //Methods*********************************
  void plotRides() {
    PVector currentPosition = new PVector(start.x, start.y);
    fill(0, 0, 0, 10);
    if (getCurrentTime()>start_seconds && getCurrentTime()<(start_seconds+trip_duration)) {
      travelled = getCurrentTime()-start_seconds;
      percentTraveled = travelled/trip_duration;
      int displayTime = getCurrentTime();     
      //origin and destination rings
      if (user_type.equals("Customer")) {
        noFill();
        strokeWeight(4);
        stroke(255, 158, 0, 50);
      }
      else {
        noFill();
        strokeWeight(2);
        stroke(0, 0, 255, 50);
      }
      ellipse(start.x, start.y, 12, 12);
      ellipse(end.x, end.y, 15, 15);
      
      //Citibuke dot
      currentPosition = PVector.lerp(start, end, percentTraveled);
      noStroke();
      if (user_type.equals("Customer")) {
        fill(255, 158, 0, 100);
      }
      else {
        fill(0, 0, 255, 100);
      }
     ellipse(currentPosition.x, currentPosition.y, 3, 3);
    // println(percentTraveled);
     //Line between the stations
      if (user_type.equals("Customer")) {
        stroke(255, 158, 0, 100);
      }
      else {
        stroke(0, 0, 200, 100);
      }
      strokeWeight(.25);
      line(start.x, start.y, end.x, end.y); 
    }
    else {
    }
  }
}
 
