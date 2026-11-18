import 'package:get/get.dart';

/// One saved address on [AddressesController].
class AddressEntry {
  const AddressEntry({
    required this.label,
    required this.recipient,
    required this.line,
    required this.city,
    required this.phone,
    this.isDefault = false,
  });

  /// Short tag shown on the card — "Home", "Studio", ...
  final String label;

  /// Who receives the delivery at [line].
  final String recipient;

  /// Street address line.
  final String line;

  /// City / area, e.g. "Lekki Phase 1, Lagos".
  final String city;

  /// Contact number for the delivery rider.
  final String phone;

  /// The address used when no other is picked — only one at a time.
  final bool isDefault;

  /// Returns a copy with [isDefault] overridden. Entries are immutable, so
  /// the controller rewrites them instead of mutating in place.
  AddressEntry copyWith({bool? isDefault}) => AddressEntry(
        label: label,
        recipient: recipient,
        line: line,
        city: city,
        phone: phone,
        isDefault: isDefault ?? this.isDefault,
      );
}

/// Saved delivery / pickup addresses behind the Addresses screen.
///
/// Seeded with two mock entries so the screen isn't empty on first open.
/// Everything is in-memory — swap for a real repository once one exists.
class AddressesController extends GetxController {
  static AddressesController get instance => Get.find();

  /// The user's saved addresses; exactly one carries [AddressEntry.isDefault]
  /// while the list isn't empty.
  final RxList<AddressEntry> addresses = <AddressEntry>[
    const AddressEntry(
      label: 'Home',
      recipient: 'Amara Grace',
      line: '27 Bode Thomas Street',
      city: 'Surulere, Lagos',
      phone: '+234 801 234 5678',
      isDefault: true,
    ),
    const AddressEntry(
      label: 'Studio',
      recipient: 'Amara Grace',
      line: '5 Ozumba Mbadiwe Avenue',
      city: 'Lekki Phase 1, Lagos',
      phone: '+234 803 445 1120',
    ),
  ].obs;

  /// Appends [entry]. The first address added becomes the default when
  /// nothing has been marked default yet (e.g. the list was emptied).
  void add(AddressEntry entry) {
    final hasDefault = addresses.any((a) => a.isDefault);
    addresses.add(hasDefault ? entry : entry.copyWith(isDefault: true));
  }

  /// Marks the address at [index] as default and clears the flag everywhere
  /// else, so exactly one card carries the badge.
  void setDefault(int index) {
    for (var i = 0; i < addresses.length; i++) {
      addresses[i] = addresses[i].copyWith(isDefault: i == index);
    }
  }

  /// Deletes the address at [index]. If the default one went away, the
  /// first survivor takes over so a default always exists.
  void removeAt(int index) {
    final wasDefault = addresses[index].isDefault;
    addresses.removeAt(index);
    if (wasDefault && addresses.isNotEmpty) {
      addresses[0] = addresses[0].copyWith(isDefault: true);
    }
  }
}
