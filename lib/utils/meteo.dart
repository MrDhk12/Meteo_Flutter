String weatherStatus(String? main) {
  String? assets = "";
  switch (main) {
    case ("Clear"):
      assets = "assets/clear.png";
      break;
    case ("Rain"):
      assets = "assets/rainy.png";
      break;
    case ("Clouds"):
      assets = "assets/clouds.png";
      break;
    case ("Snow"):
      assets = "assets/snow.png";
      break;
    case ("Extreme"):
      assets = "assets/thunder.png";
      break;
    default:
  }
  return assets;
}
