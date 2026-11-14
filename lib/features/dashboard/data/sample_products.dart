import 'package:grace_and_gown_app/features/shop/products/models/products.dart';

/// Static demo inventory — swap for your backend later.
///
/// Paths use `gown_28..gown_41` on purpose: those are the ~30–250KB .jpg
/// versions. `gown_1..27` are ~2.3MB PNGs, which would put ~32MB of images
/// behind this grid.
///
/// `imageAspect` values are the real width ÷ height of each asset, measured
/// from the files — keep them in sync if you replace an image.
class SampleProducts {
  SampleProducts._();

  /// The curated catalogue shown on the home grid.
  static const List<Product> items = [
    Product(
      id: 'g28',
      name: 'Aurelia Lace Gown',
      category: 'White',
      price: '₦150,000 / 3 days',
      image: 'assets/images/category/gown_28.jpg',
      imageAspect: 0.4626, // 736 x 1591
      description:
      'A floor-sweeping silhouette in delicate corded lace, finished with a soft sweep train and covered buttons down the back.',
      fabric: 'Corded lace, satin lining',
      sizes: ['8', '10', '12', '14'],
      availability: 'Available',
    ),
    Product(
      id: 'g29',
      name: 'Odette Ball Gown',
      category: 'White',
      price: '₦185,000 / 3 days',
      image: 'assets/images/category/gown_29.jpg',
      imageAspect: 0.7502, // 1024 x 1365
      description:
      'Classic ball gown with a full tulle skirt and beaded bodice — built for a grand entrance.',
      fabric: 'Tulle, beaded organza',
      sizes: ['10', '12', '14', '16'],
      availability: 'Available',
    ),
    Product(
      id: 'g30',
      name: 'Celeste Mermaid',
      category: 'White',
      price: '₦165,000 / 3 days',
      image: 'assets/images/category/gown_30.jpg',
      imageAspect: 0.8017, // 736 x 918
      description:
      'A fitted mermaid cut that flares at the knee, with a sheer illusion neckline.',
      fabric: 'Crepe, illusion net',
      sizes: ['8', '10', '12'],
      availability: 'Limited',
    ),
    Product(
      id: 'g31',
      name: 'Amara Trad Set',
      category: 'Trad',
      price: '₦95,000 / 2 days',
      image: 'assets/images/category/gown_31.jpg',
      imageAspect: 0.8, // 960 x 1200
      description:
      'Traditional two-piece with hand-finished geo george detailing and coral bead accents.',
      fabric: 'Geo george, lace',
      sizes: ['M', 'L', 'XL'],
      availability: 'Available',
    ),
    Product(
      id: 'g32',
      name: 'Bianca Satin Gown',
      category: 'Reception',
      price: '₦130,000 / 3 days',
      image: 'assets/images/category/gown_32.jpg',
      imageAspect: 0.8, // 736 x 920
      description:
      'Minimalist satin with a cowl back and thigh-high slit — made for the reception dance floor.',
      fabric: 'Duchess satin',
      sizes: ['8', '10', '12', '14'],
      availability: 'Available',
    ),
    Product(
      id: 'g33',
      name: 'Rosalind A-Line',
      category: 'White',
      price: '₦140,000 / 3 days',
      image: 'assets/images/category/gown_33.jpg',
      imageAspect: 0.75, // 1152 x 1536
      description:
      'Soft A-line with floral appliqué scattered from bodice to hem.',
      fabric: 'Chantilly lace',
      sizes: ['10', '12', '14'],
      availability: 'Available',
    ),
    Product(
      id: 'g34',
      name: 'Court Signature Set',
      category: 'Court',
      price: '₦75,000 / 1 day',
      image: 'assets/images/category/gown_34.jpg',
      imageAspect: 0.8077, // 735 x 910
      description:
      'Sharp, tailored look for registry day — jacket, skirt and matching fascinator.',
      fabric: 'Wool blend',
      sizes: ['S', 'M', 'L'],
      availability: 'Available',
    ),
    Product(
      id: 'g35',
      name: 'Ivory Tea-Length',
      category: 'White',
      price: '₦88,000 / 2 days',
      image: 'assets/images/category/gown_35.jpg',
      imageAspect: 0.8077, // 735 x 910
      description:
      'Playful tea-length hem with a sweetheart neckline and detachable bow.',
      fabric: 'Satin, tulle',
      sizes: ['8', '10', '12'],
      availability: 'Available',
    ),
    Product(
      id: 'g36',
      name: 'Zara Beaded Gown',
      category: 'Reception',
      price: '₦175,000 / 3 days',
      image: 'assets/images/category/gown_36.jpg',
      imageAspect: 0.75, // 600 x 800
      description:
      'Fully beaded sheath with cap sleeves — catches every bit of light.',
      fabric: 'Beaded mesh',
      sizes: ['10', '12'],
      availability: 'Reserved',
    ),
    Product(
      id: 'g37',
      name: 'Nneka George Set',
      category: 'Trad',
      price: '₦110,000 / 2 days',
      image: 'assets/images/category/gown_37.jpg',
      imageAspect: 0.6399, // 375 x 586
      description:
      'Richly coloured traditional set with hand-sewn sequin panels and a matching gele.',
      fabric: 'George, sequin lace',
      sizes: ['M', 'L', 'XL'],
      availability: 'Available',
    ),
    Product(
      id: 'g38',
      name: 'Grace Column Gown',
      category: 'White',
      price: '₦155,000 / 3 days',
      image: 'assets/images/category/gown_38.jpg',
      imageAspect: 0.8005, // 1200 x 1499
      description:
      'Clean column silhouette with a cathedral train and jewelled belt.',
      fabric: 'Mikado silk',
      sizes: ['8', '10', '12', '14', '16'],
      availability: 'Available',
    ),
    Product(
      id: 'g39',
      name: 'Pearl Accessories Set',
      category: 'Accessories',
      price: '₦35,000 / 2 days',
      image: 'assets/images/category/gown_39.jpg',
      imageAspect: 0.802, // 1199 x 1495
      description:
      'Veil, gloves and pearl drop earrings styled to pair with any gown in the collection.',
      fabric: 'Tulle, freshwater pearl',
      sizes: ['One size'],
      availability: 'Available',
    ),
    Product(
      id: 'g40',
      name: 'Vera Draped Gown',
      category: 'Reception',
      price: '₦145,000 / 3 days',
      image: 'assets/images/category/gown_40.jpg',
      imageAspect: 0.8043, // 1200 x 1492
      description:
      'Softly draped jersey with a one-shoulder neckline and knotted waist.',
      fabric: 'Stretch jersey',
      sizes: ['8', '10', '12', '14'],
      availability: 'Available',
    ),
    Product(
      id: 'g41',
      name: 'Seraphine Corset Gown',
      category: 'White',
      price: '₦195,000 / 3 days',
      image: 'assets/images/category/gown_41.jpg',
      imageAspect: 0.8106, // 736 x 908
      description:
      'Structured corset bodice with a dramatic flared skirt and off-shoulder straps.',
      fabric: 'Brocade, boned satin',
      sizes: ['8', '10', '12'],
      availability: 'Limited',
    ),
  ];

  /// Every image in `assets/images/category` (gown_1 … gown_74) as a product, in
  /// numeric order. The 14 curated items above keep their real data; the rest
  /// get generated entries built from [_generatedAspects].
  static final List<Product> all = _buildAll();

  /// Real width ÷ height for the images that have no curated entry.
  static const Map<int, double> _generatedAspects = {
    1: 0.6667, 2: 0.6656, 3: 0.6656, 4: 0.6656, 5: 0.6656, 6: 0.6656,
    7: 0.6656, 8: 0.6656, 9: 0.6656, 10: 0.6656, 11: 0.6656, 12: 0.6656,
    13: 0.6656, 14: 0.6656, 15: 0.6656, 16: 0.7143, 17: 0.6656,
    18: 0.6656, 19: 0.6656, 20: 0.6656, 21: 0.6656, 22: 0.6667,
    23: 0.6656, 24: 0.6667, 25: 0.6656, 26: 0.6656, 27: 0.6667,
    42: 0.8, 43: 0.8145, 44: 0.8042, 45: 0.872, 46: 0.8, 47: 0.8285,
    48: 0.8, 49: 0.9223, 50: 0.7564, 51: 0.5627, 52: 0.7993, 53: 0.8,
    54: 0.5625, 55: 0.8, 56: 0.6667, 57: 0.802, 58: 0.7356, 59: 0.6674,
    60: 0.8, 61: 0.7503, 62: 0.8, 63: 1.0059, 64: 0.6667, 65: 0.8212,
    66: 0.75, 67: 0.8, 68: 0.5627, 69: 0.7503, 70: 0.8, 71: 0.6667,
    72: 0.6667, 73: 0.6667, 74: 0.8,
  };

  static List<Product> _buildAll() {
    final curated = {
      for (final p in items) int.parse(p.id.substring(1)): p,
    };

    return List.unmodifiable([
      for (var n = 1; n <= 74; n++) curated[n] ?? _generate(n),
    ]);
  }

  /// Placeholder entry for an image that has no hand-written data yet.
  ///
  /// Categories rotate rather than defaulting to 'White', so stock is spread
  /// across the five categories shown on the Category tab and no card there
  /// ends up empty. See `GownCategories.all` for the labels these must match.
  static const List<String> _generatedCategories = [
    'White',
    'Court',
    'Trad',
    'Accessories',
    'Reception',
  ];

  static Product _generate(int n) {
    final ext = n <= 27 ? 'png' : 'jpg'; // gown_1..27 are PNG, the rest JPEG
    final price = 90 + (n % 6) * 15; // ₦90k–₦165k, deterministic variety

    return Product(
      id: 'g$n',
      name: 'Gown ${n.toString().padLeft(2, '0')}',
      category: _generatedCategories[n % _generatedCategories.length],
      price: '₦$price,000 / 3 days',
      image: 'assets/images/category/gown_$n.$ext',
      imageAspect: _generatedAspects[n] ?? 0.8,
      description:
      'Part of the Grace & Gown collection, photographed exactly as shown. '
      'Ask in-store for fabric, sizing and styling details.',
      fabric: 'See in-store',
      sizes: ['8', '10', '12', '14'],
      availability: 'Available',
    );
  }
}
