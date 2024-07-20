extension MyValue on double {
  String get of2 =>
      toString().split('.')[0] +
      '.' +
      toString().split('.')[1][0] +
      toString().split('.')[1][1];
}
