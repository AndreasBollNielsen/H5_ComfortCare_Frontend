class Address {
  final String streetName;
  final String localArea;
  final String city;

  Address(this.streetName, this.localArea, this.city);

  factory Address.fromAddressString(String addressString) {
    //splitting string into parts
    List<String> addressParts = addressString.split(',');

    //removing blank space from each string
    addressParts = addressParts.map((part) => part.trim()).toList();

    //add blank space if local area is not present
    if (addressParts.length < 3) {
      addressParts.insert(1, '');
    }

    //retrieve street,localarea and city & return the model
    String street = addressParts[0];
    String local = addressParts[1];
    String city = addressParts[2];

    return Address(street, local, city);
  }
}
