String numberConverter(double number) {
  return (number % 1 == 0)
      ? number.toInt().toString()
      : number.toStringAsFixed(2);
}
