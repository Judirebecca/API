import 'package:dart_json_mapper/dart_json_mapper.dart' ;

// Create a class AvengerBO
@jsonSerializable
class AvengerBO {
  // Create a variable id of integer datatype and keep it nullable
  int? id;

  // Create a variable name of String datatype and keep it nullable
  String? name;

  // In the constructor of AvengerBO get id and name as required parameter
  AvengerBO({required this.id, required this.name});
}
