class VGA {

  int? checkIn;
  int? checkOut;

  VGA() {
    checkIn = 0;
    checkOut = 0;
  }

  VGA fromSocket(Map<String, dynamic> data){
    checkIn = data['checkIn'];
    checkOut = data['checkOut'];
    return this;
  }
}

class TGA {

  int? checkIn;
  int? checkOut;

  TGA() {
    checkIn = 0;
    checkOut = 0;
  }

  TGA fromSocket(Map<String, dynamic> data){
    checkIn = data['checkIn'];
    checkOut = data['checkOut'];
    return this;
  }
}