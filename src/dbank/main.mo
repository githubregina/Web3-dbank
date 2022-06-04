import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  // "stable" will save the value
  stable var currentValue: Float = 300;
  // currentValue := 300;
  //replace the value using :=

  let id = 16546816556468;
  //cannot be changed

  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

  // Debug.print(debug_show(currentValue));
  //print > text
  //debug_show > number

  // Debug.print(debug_show(id));

  //add public to let this function can be called outside of canister.
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("You have no enough balance to withdraw.")
    };
  };
  // topUp();

  // read only --- much faster
  public query func checkBalance(): async Float {
    return currentValue;
  };


  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNs = currentTime - startTime;
    let timeElapsedS = timeElapsedNs/ 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }
};