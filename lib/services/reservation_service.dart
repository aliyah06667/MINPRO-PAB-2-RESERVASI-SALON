import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reservation.dart';

class ReservationService {
  final supabase = Supabase.instance.client;

  Future addReservation(Reservation r) async {
    await supabase.from('reservations').insert({
      'name': r.name,
      'contact': r.contact,
      'service': r.service,
      'date': r.date,
      'notes': r.notes,
      'price': r.price,
    });
  }

  Future<List> getReservations() async {
    final data = await supabase.from('reservations').select();
    return data;
  }

  Future deleteReservation(int id) async {
    await supabase.from('reservations').delete().eq('id', id);
  }

  Future updateReservation(int id, Reservation r) async {
    await supabase
        .from('reservations')
        .update({
          'name': r.name,
          'contact': r.contact,
          'service': r.service,
          'date': r.date,
          'notes': r.notes,
          'price': r.price,
        })
        .eq('id', id);
  }
}
