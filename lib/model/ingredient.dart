class Ingredient {
  String? _id;
  String? _name;
  bool? _isBought;

  Ingredient({
    String? id,
    String? name,
    bool? isBought,
  }) {
    _id = id;
    _name = name;

    _isBought = isBought;
  }
  String? get id => _id;
  String? get name => _name;

  bool? get isBought => _isBought;
}
