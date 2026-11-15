/// A scheduled studio visit.
///
/// Mock data for now — the shape is what a real bookings source would
/// return, so swapping in an API later only touches the controller.
class Booking {
  const Booking({
    required this.reference,
    required this.date,
    required this.time,
    required this.style,
    this.status = 'Confirmed',
    this.isPaid = false,
    this.paymentReference,
  });

  /// Display reference, e.g. `GG-1042`.
  final String reference;

  /// The day of the visit. Time-of-day lives in [time] as a slot label.
  final DateTime date;

  /// Chosen slot, e.g. `11:00 AM`.
  final String time;

  /// What the visit is for, e.g. `Bridal Fitting`.
  final String style;

  final String status;

  /// True once the booking fee has settled. A booking is only ever
  /// created after payment succeeds, so new visits start paid — the
  /// flag exists so the card can show it and a real backend can persist it.
  final bool isPaid;

  /// Gateway reference for the fee payment, e.g. `PAY-8341`.
  final String? paymentReference;
}
