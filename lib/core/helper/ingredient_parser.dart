import 'dart:convert';

class IngredientParser {
  // Define unit conversions to base units (ml for volume, grams for weight)
  static const Map<String, double> volumeConversions = {
    'ml': 1.0,
    'L': 1000.0,
    'tsp': 5.0, // approximate 1 tsp = 5 ml
    'tbsp': 15.0, // approximate 1 tbsp = 15 ml
    'cup': 240.0, // approximate 1 cup = 240 ml
    'cups': 240.0,
  };

  static const Map<String, double> weightConversions = {
    'g': 1.0,
    'gram': 1.0,
    'grams': 1.0,
    'kg': 1000.0,
    'oz': 28.35, // 1 oz ≈ 28.35 g
    'lb': 453.59, // 1 lb ≈ 453.59 g
  };

  // Approximate weights for common items without units
  static const Map<String, double> approximateWeights = {
    'chicken breast': 150.0, // g
    'beef patty': 150.0,
    'salmon fillet': 150.0,
    'steak': 200.0,
    'shrimp': 7.0, // per shrimp
    'egg': 50.0,
    'avocado': 150.0,
    'banana': 120.0,
    'tomato': 100.0,
    'onion': 150.0,
    'garlic clove': 5.0,
    // Add more as needed
  };

  static Map<String, double> parseAndSumIngredients(List<String> ingredientStrings) {
    Map<String, double> summedIngredients = {};

    for (String ingredient in ingredientStrings) {
      final parsed = _parseIngredient(ingredient);
      if (parsed != null) {
        final name = parsed['name'] as String;
        final quantity = parsed['quantity'] as double;
        final unit = parsed['unit'] as String?;

        // Convert to base unit
        double baseQuantity = quantity;
        if (unit != null) {
          if (volumeConversions.containsKey(unit)) {
            baseQuantity = quantity * volumeConversions[unit]!;
          } else if (weightConversions.containsKey(unit)) {
            baseQuantity = quantity * weightConversions[unit]!;
          }
        }

        summedIngredients[name] = (summedIngredients[name] ?? 0) + baseQuantity;
      }
    }

    return summedIngredients;
  }

  static Map<String, dynamic>? _parseIngredient(String ingredient) {
    // Remove parentheses and extra text
    ingredient = ingredient.replaceAll(RegExp(r'\s*\([^)]*\)'), '').trim();

    // Match patterns like "1 cup", "2 tablespoons", "1/2 kg", etc.
    final regExp = RegExp(r'^(\d+(?:\.\d+)?(?:/\d+)?)\s*([a-zA-Z]+)?\s*(.*)$');
    final match = regExp.firstMatch(ingredient);

    if (match != null) {
      final quantityStr = match.group(1)!;
      final unit = match.group(2)?.toLowerCase();
      final name = match.group(3)?.trim() ?? '';

      double quantity = _parseQuantity(quantityStr);

      // If no unit, try to approximate based on name
      if (unit == null && approximateWeights.containsKey(name.toLowerCase())) {
        quantity *= approximateWeights[name.toLowerCase()]!;
        return {'name': name, 'quantity': quantity, 'unit': 'g'};
      }

      return {'name': name, 'quantity': quantity, 'unit': unit};
    }

    // If no match, assume it's a whole item, approximate weight
    final name = ingredient.toLowerCase();
    if (approximateWeights.containsKey(name)) {
      return {'name': ingredient, 'quantity': approximateWeights[name]!, 'unit': 'g'};
    }

    // If can't parse, skip or handle as is
    return null;
  }

  static double _parseQuantity(String quantityStr) {
    if (quantityStr.contains('/')) {
      final parts = quantityStr.split('/');
      if (parts.length == 2) {
        final num = double.tryParse(parts[0]) ?? 1;
        final den = double.tryParse(parts[1]) ?? 1;
        return num / den;
      }
    }
    return double.tryParse(quantityStr) ?? 1;
  }

  static String formatQuantity(double quantity, String? unit) {
    if (unit == null) {
      return '${quantity.toStringAsFixed(1)} g'; // default to grams
    }

    // Format back to preferred units
    if (volumeConversions.containsKey(unit)) {
      // For volume, keep in ml, L, etc.
      if (quantity >= 1000) {
        return '${(quantity / 1000).toStringAsFixed(1)} L';
      } else if (quantity >= 15) {
        return '${(quantity / 15).toStringAsFixed(1)} tbsp';
      } else if (quantity >= 5) {
        return '${(quantity / 5).toStringAsFixed(1)} tsp';
      } else {
        return '${quantity.toStringAsFixed(1)} ml';
      }
    } else if (weightConversions.containsKey(unit)) {
      // For weight, keep in grams
      return '${quantity.toStringAsFixed(1)} g';
    }

    return '${quantity.toStringAsFixed(1)} $unit';
  }
}
