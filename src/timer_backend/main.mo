import Time "mo:base/Time";
import Debug "mo:base/Debug";
import Int "mo:base/Int";

actor SimpleTimer {
  stable var startTime : Int = 0;
  stable var isRunning : Bool = false;
  stable var totalTime : Int = 0;
 

  public func start() {
    Debug.print("Starting the timer");
    if (not isRunning) {
      startTime := Time.now() / 1_000_000_000;
      isRunning := true;
      Debug.print("⏳ Timer started at: " # Int.toText(startTime) # " seconds");
    } else {
      Debug.print("⚠️ Timer is already running.");
    }
  };


  public func pause() {
    Debug.print("Pausing the timer");
    if (isRunning) {
      let current = Time.now() / 1_000_000_000;
      let elapsedTime = current - startTime;
      totalTime += elapsedTime;
      isRunning := false;
      Debug.print("Timer paused. Total time: " # Int.toText(totalTime) # " seconds");
    } else {
      Debug.print("Timer is not running.");
    }
  };
};

