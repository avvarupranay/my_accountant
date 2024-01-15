 class Car{
  int length;
  int width;
  int height;
  int chasisNumber;

  Car(this.length , this.width , this.height , this.chasisNumber);

  int totalVolume() {
    // TODO: implement totalVolume
    throw UnimplementedError();
  }
  int getChasisNumber() {
    // TODO: implement getChasisNumber
    throw UnimplementedError();
  }
}


class SUV implements Car{
  @override
  late int chasisNumber;

  @override
  late int height;

  @override
  late int length;

  @override
  late int width;

  @override
  int getChasisNumber() {
    // TODO: implement getChasisNumber
    throw UnimplementedError();
  }

  @override
  int totalVolume() {
    // TODO: implement totalVolume
    throw UnimplementedError();
  }

  // @override
  // int getChasisNumber() {
  //   // TODO: implement getChasisNumber
  //   throw UnimplementedError();
  // }
  //
  // @override
  // int totalVolume() {
  //   // TODO: implement totalVolume
  //   throw UnimplementedError();
  // }


}