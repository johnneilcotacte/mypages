class MacroNutrient {
  String? _carbs;
  String? _protein;
  String? _cals;

  MacroNutrient({
    String? carbs,
    String? protein,
    String? cals,
  })  : _carbs = carbs,
        _protein = protein,
        _cals = cals;

  factory MacroNutrient.fromJson(Map<String, dynamic> json) {
    return MacroNutrient(
      carbs: json['carbs'] as String? ?? '',
      protein: json['protein'] as String? ?? '',
      cals: json['cals'] as String? ?? '',
    );
  }

  String? get carbs => _carbs;
  String? get protein => _protein;
  String? get cals => _cals;

  Map<String, dynamic> nutrients() {
    return {
      "carbs": carbs,
      "protein": protein,
      "cals": cals,
    };
  }
}
