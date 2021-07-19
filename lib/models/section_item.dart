class SectionItem {

  SectionItem.fromMap(Map<String, dynamic> map){
    image = map['image'] as String;
    product = map['product'] as String;
  }

  late String image;
  late String product;

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}