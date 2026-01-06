class User {
  final int id;
  final String email;
  final String username;
  final Name name;
  final Address? address;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    this.address,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: Name.fromJson(json['name']),
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
      phone: json['phone'],
    );
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(firstname: json['firstname'], lastname: json['lastname']);
  }

  String get full => '$firstname $lastname'
      .split(' ')
      .map((str) => str[0].toUpperCase() + str.substring(1))
      .join(' ');
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final Geolocation geolocation;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      geolocation: Geolocation.fromJson(json['geolocation']),
    );
  }

  String get fullAddress => '$number $street, $city, $zipcode'
      .split(' ')
      .map(
        (str) => str.isNotEmpty ? str[0].toUpperCase() + str.substring(1) : '',
      )
      .join(' ');
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(lat: json['lat'], long: json['long']);
  }
}
