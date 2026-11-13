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

  static const List<Product> items = [
    Product(
      id: 'g28',
      name: 'Aurelia Lace Gown',
      category: 'White',
      price: '₦150,000 / 3 days',
      image: 'assets/images/gowns/gown_28.jpg',
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
      image: 'assets/images/gowns/gown_29.jpg',
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
      image: 'assets/images/gowns/gown_30.jpg',
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
      image: 'assets/images/gowns/gown_31.jpg',
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
      image: 'assets/images/gowns/gown_32.jpg',
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
      image: 'assets/images/gowns/gown_33.jpg',
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
      image: 'assets/images/gowns/gown_34.jpg',
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
      image: 'assets/images/gowns/gown_35.jpg',
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
      image: 'assets/images/gowns/gown_36.jpg',
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
      image: 'assets/images/gowns/gown_37.jpg',
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
      image: 'assets/images/gowns/gown_38.jpg',
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
      image: 'assets/images/gowns/gown_39.jpg',
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
      image: 'assets/images/gowns/gown_40.jpg',
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
      image: 'assets/images/gowns/gown_41.jpg',
      imageAspect: 0.8106, // 736 x 908
      description:
      'Structured corset bodice with a dramatic flared skirt and off-shoulder straps.',
      fabric: 'Brocade, boned satin',
      sizes: ['8', '10', '12'],
      availability: 'Limited',
    ),
  ];
}
