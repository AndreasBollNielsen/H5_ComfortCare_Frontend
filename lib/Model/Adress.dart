class Address {
  final String streetName;
  final String localArea;
  final String city;

  Address(this.streetName, this.localArea, this.city);

  factory Address.fromAddressString(String addressString) {
    // Del adressen ved kommaer for at få separate elementer
    List<String> addressParts = addressString.split(',');

    print(addressString);
    for (var i = 0; i < addressParts.length; i++) {
      print('index: $i: ${addressParts[i]} ');
    }
    // Fjern eventuelle ekstra mellemrum fra hver del
    addressParts = addressParts.map((part) => part.trim()).toList();

    if (addressParts.length < 3) {
      addressParts.insert(1, ' ');
    }

    // Sørg for, at der er mindst 4 dele (gade, postnummer, by, etage)
    if (addressParts.length >= 3) {
      String street = addressParts[0];
      String local = addressParts[1];
      String city = addressParts[2];

      return Address(street, local, city);
    } else {
      throw Exception('Ugyldig adressetekst');
    }
  }
}
