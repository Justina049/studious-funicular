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


  public func resume() {
    Debug.print("Resuming the timer");
    if (not isRunning) {
      startTime := Time.now() / 1_000_000_000;
      isRunning := true;
      Debug.print("Timer resumed at: " # Int.toText(startTime) # " seconds");
    } else {
      Debug.print("Timer is already running.");
    }
  };


  public func stop() : async Int {
    Debug.print("Stopping the timer");
    if (isRunning) {
      let elapsedTime = (Time.now() / 1_000_000_000) - startTime;
      totalTime += elapsedTime;
      isRunning := false;
    };
    let finalTime = totalTime;
    totalTime := 0;
    Debug.print("Timer stopped. Total time: " # Int.toText(finalTime) # " seconds");
    return finalTime;
  };


  public query func check() : async Int {
    Debug.print("Checking the timer");
    if (isRunning) {
      let currentTime = ((Time.now() / 1_000_000_000) - startTime) + totalTime;
      Debug.print("⏱️ Current time: " # Int.toText(currentTime) # " seconds");
      return currentTime;
    } else {
      Debug.print("⏱️ Timer stopped. Total time: " # Int.toText(totalTime) # " seconds");
      return totalTime;
    }
  };

};

