enum SignalLevel { high, medium, low, unknown }

SignalLevel parseRssi(int rssi) {
  if (rssi == null) return SignalLevel.unknown;

  if (rssi > -60) {
    return SignalLevel.high;
  } else if (rssi > -90) {
    return SignalLevel.medium;
  } else {
    return SignalLevel.low;
  }
}
