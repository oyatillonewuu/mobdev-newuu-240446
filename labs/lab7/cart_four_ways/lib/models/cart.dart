enum CheckoutStatus { idle, submitted, success, failure }

class Product {
  const Product({required this.id, required this.name, required this.price});
  final String id;
  final String name;
  final double price;
}

const catalog = [
  Product(id: 'p1', name: 'Keyboard', price: 49),
  Product(id: 'p2', name: 'Mouse', price: 25),
  Product(id: 'p3', name: 'Monitor', price: 199),
];

class CartLine {
  const CartLine({required this.product, required this.qty});
  final Product product;
  final int qty;
  double get subtotal => product.price * qty;
  CartLine copyWith({int? qty}) =>
      CartLine(product: product, qty: qty ?? this.qty);
}

/// Pure, style-independent cart logic. Every state holder calls these.
extension CartLines on List<CartLine> {
  List<CartLine> withProduct(Product p) {
    final i = indexWhere((l) => l.product.id == p.id);
    if (i == -1) return [...this, CartLine(product: p, qty: 1)];
    return [
      for (final l in this)
        l.product.id == p.id ? l.copyWith(qty: l.qty + 1) : l,
    ];
  }

  List<CartLine> without(String productId) => [
    for (final l in this)
      if (l.product.id != productId) l,
  ];

  List<CartLine> changeQty(String productId, int delta) {
    final i = indexWhere((l) => l.product.id == productId);
    if (i == -1) return this;
    final CartLine cartLine = this[i];
    if (cartLine.qty + delta <= 0) {
      return without(cartLine.product.id);
    }
    return [
      for (final l in this)
        l.product.id == cartLine.product.id
            ? l.copyWith(qty: l.qty + delta)
            : l,
    ];
  }

  double get subtotal => fold(0, (s, l) => s + l.subtotal);
  int get itemCount => fold(0, (s, l) => s + l.qty);
}

class CartState {
  final List<CartLine> lines;
  final String? coupon;
  final String? couponError;
  final String? orderId;
  final String? checkoutError;
  final CheckoutStatus checkoutStatus;

  CartState({
    required this.lines,
    this.coupon,
    this.orderId,
    this.checkoutError,
    CheckoutStatus? checkoutStatus,
  }) : couponError = (coupon != null && coupon != "SAVE10")
           ? "Invalid coupon"
           : null,
       checkoutStatus = (checkoutStatus ?? CheckoutStatus.idle);

  CartState copyWith({
    List<CartLine>? lines,
    String? coupon,
    String? orderId,
    String? checkoutError,
    CheckoutStatus? checkoutStatus,
  }) {
    return CartState(
      lines: lines ?? this.lines,
      coupon: coupon ?? this.coupon,
      orderId: orderId ?? this.orderId,
      checkoutError:
          checkoutError ?? ((orderId != null) ? null : this.checkoutError), // if orderId is not null,we should not carry prev error
      checkoutStatus: checkoutStatus ?? this.checkoutStatus,
    );
  }

  int get itemCount {
    return lines.itemCount;
  }

  double get subtotal => lines.subtotal;

  double get discount {
    if (couponError == null) {
      return 10.0;
    }
    return 0;
  }

  double get total {
    return subtotal - (discount / 100) * subtotal;
  }
}
