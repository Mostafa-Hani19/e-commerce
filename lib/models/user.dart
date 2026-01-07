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
  User copyWith({
    int? id,
    String? email,
    String? username,
    Name? name,
    Address? address,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
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

  Name copyWith({String? firstname, String? lastname}) {
    return Name(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }
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

  Address copyWith({
    String? city,
    String? street,
    int? number,
    String? zipcode,
    Geolocation? geolocation,
  }) {
    return Address(
      city: city ?? this.city,
      street: street ?? this.street,
      number: number ?? this.number,
      zipcode: zipcode ?? this.zipcode,
      geolocation: geolocation ?? this.geolocation,
    );
  }
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(lat: json['lat'], long: json['long']);
  }

  Geolocation copyWith({String? lat, String? long}) {
    return Geolocation(lat: lat ?? this.lat, long: long ?? this.long);
  }
}
