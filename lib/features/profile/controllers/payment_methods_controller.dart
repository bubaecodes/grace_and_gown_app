import 'package:get/get.dart';

/// A saved card. Only the last four digits are ever kept — never the
/// full number.
class PaymentCardEntry {
  const PaymentCardEntry({
    required this.brand,
    required this.last4,
    required this.expiry,
    required this.holder,
    this.isDefault = false,
  });

  /// "Visa" or "Mastercard", inferred from the first digit on save.
  final String brand;

  /// The final four digits, shown masked as •••• last4.
  final String last4;

  /// Expiry as typed, "MM/YY".
  final String expiry;

  /// Name embossed on the card.
  final String holder;

  /// The card charged by default — only one at a time.
  final bool isDefault;

  /// Returns a copy with [isDefault] overridden. Entries are immutable, so
  /// the controller rewrites them instead of mutating in place.
  PaymentCardEntry copyWith({bool? isDefault}) => PaymentCardEntry(
        brand: brand,
        last4: last4,
        expiry: expiry,
        holder: holder,
        isDefault: isDefault ?? this.isDefault,
      );
}

/// Saved payment methods behind the Payment Methods screen.
///
/// Seeded with two mock cards so the screen isn't empty on first open.
/// Card details are simulated — a real gateway replaces this later.
class PaymentMethodsController extends GetxController {
  static PaymentMethodsController get instance => Get.find();

  /// The user's saved cards; exactly one carries [PaymentCardEntry.isDefault]
  /// while the list isn't empty.
  final RxList<PaymentCardEntry> cards = <PaymentCardEntry>[
    const PaymentCardEntry(
      brand: 'Visa',
      last4: '4242',
      expiry: '08/27',
      holder: 'Amara Grace',
      isDefault: true,
    ),
    const PaymentCardEntry(
      brand: 'Mastercard',
      last4: '8891',
      expiry: '03/26',
      holder: 'Amara Grace',
    ),
  ].obs;

  /// Adds a card from its full number but stores only the last four digits.
  /// The first digit picks the brand: 4 → Visa, anything else → Mastercard.
  /// The screen validates the 16 digits before calling this.
  void addCard({
    required String number,
    required String expiry,
    required String holder,
  }) {
    final digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 4) return;

    final entry = PaymentCardEntry(
      brand: digits.startsWith('4') ? 'Visa' : 'Mastercard',
      last4: digits.substring(digits.length - 4),
      expiry: expiry,
      holder: holder,
    );

    cards.add(cards.isEmpty ? entry.copyWith(isDefault: true) : entry);
  }

  /// Marks the card at [index] as default and clears the flag everywhere
  /// else, so exactly one row carries the badge.
  void setDefault(int index) {
    for (var i = 0; i < cards.length; i++) {
      cards[i] = cards[i].copyWith(isDefault: i == index);
    }
  }

  /// Deletes the card at [index]. If the default one went away, the first
  /// survivor takes over so a default always exists.
  void removeAt(int index) {
    final wasDefault = cards[index].isDefault;
    cards.removeAt(index);
    if (wasDefault && cards.isNotEmpty) {
      cards[0] = cards[0].copyWith(isDefault: true);
    }
  }
}
