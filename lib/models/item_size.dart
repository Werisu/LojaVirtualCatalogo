class ItemSize{

  ItemSize();

  ItemSize.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  late String? name = "";
  late num? price = 0;
  late int? stock = 0;

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}