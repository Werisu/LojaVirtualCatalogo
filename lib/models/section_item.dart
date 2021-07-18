class SectionItem {

  SectionItem.fromMap(Map<String, dynamic> map){
    image = map['image'] as String;
  }

  late String image;

  @override
  String toString() {
    return 'SectionItem{image: $image}';
  }
}