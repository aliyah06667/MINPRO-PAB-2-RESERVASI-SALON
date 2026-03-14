class Reservation {
  int? id;
  String name;
  String contact;
  String service;
  String date;
  String notes;
  int price;

  Reservation({
    this.id,
    required this.name,
    required this.contact,
    required this.service,
    required this.date,
    required this.notes,
    required this.price,
  });

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      service: map['service'],
      date: map['date'],
      notes: map['notes'] ?? "",
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'service': service,
      'date': date,
      'notes': notes,
      'price': price,
    };
  }
}