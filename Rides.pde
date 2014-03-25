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
  int activeRides;
  int costumers;
  int subscribers;
  int dot_opacity = 20;
  int mapped;


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
    mapped = 0;
    costumers = 0;
    subscribers = 0;
    PVector currentPosition = new PVector(start.x, start.y);
    fill(0, 0, 0, 10);
    if (getCurrentTime()>start_seconds && getCurrentTime()<(start_seconds+trip_duration)) {
      activeRides = 1;
      travelled = getCurrentTime()-start_seconds;
      percentTraveled = travelled/trip_duration;
      int displayTime = getCurrentTime();  

      //origin and destination rings
      if (user_type.equals("Customer")) {
        costumers = 1;
        subscribers = 0;
        fill(255, 158, 0, dot_opacity);
        //        noFill();
        //        strokeWeight(4);
        //        stroke(255, 158, 0, 20);
      }
      else {
        costumers = 0;
        subscribers = 1;
        fill(0, 0, 255, dot_opacity);
        //        noFill();
        //        strokeWeight(2);
        //        stroke(0, 0, 255, 20);
      }
      //noStroke();
      ellipse(start.x, start.y, 12, 12);
      //ellipse(end.x, end.y, 15, 15);


      //Citibike dot
      currentPosition = PVector.lerp(start, end, percentTraveled);
      noStroke();
      if (user_type.equals("Customer")) {
        fill(255, 158, 70, 100);
      }
      else {
        fill(0, 0, 255, 100);
      }
      ellipse(currentPosition.x, currentPosition.y, 3, 3);

      //Line between the stations
      if (user_type.equals("Customer")) {
        stroke(255, 158, 0, 100);
      }
      else {
        stroke(0, 0, 200, 100);
      }
      strokeWeight(.15);
      line(start.x, start.y, end.x, end.y);
    }
    else {
      activeRides = 0;
    }
    if (getCurrentTime()>start_seconds) {
      mapped = 1;
    }
    else {
      mapped = 0;
    }
  }
}

