String convertToFahrenheit (double temperature) {
  // Convert Kelvin to Fahrenheit
  return ((temperature - 273.15) * 9/5 + 32).toStringAsFixed(2);
}

String convertToCelsius (double temperature) {
  // Convert Kelvin to Celsius
  return (temperature - 273.15).toStringAsFixed(2);
}