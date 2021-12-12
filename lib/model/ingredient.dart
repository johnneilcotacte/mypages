class Ingredient {
  String? _id;
  String? _name;
  String? _amount;

  Ingredient({String? id, String? name, String? amount}) {
    _id = id;
    _name = name;
    _amount = amount;
  }
  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json['id'],
        name: json['name'] as String? ?? '',
        amount: json['amount'] as String? ?? '',
      );
  String? get id => _id;
  String? get name => _name;
  String? get amount => _amount;
}
