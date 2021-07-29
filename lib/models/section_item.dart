class SectionItem {

  SectionItem({required this.image,required this.product});

  SectionItem.fromMap(Map<String, dynamic> map){
    image = map['image'] as String;
    product = map['product'] as String;
  }

  late String image;
  late String product;

  SectionItem clone(){
    return SectionItem(
      image: image,
      product: product,
    );
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}