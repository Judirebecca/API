import 'dart:async';

// Create an abstract class Textfield
abstract class Textfield{}

// Create a class AddTextfield that extends Textfield
class AddTextfield extends Textfield{

  // Create a variable data of String datatype
  String data;

  // In the class's constructor pass the data as required parameter
  AddTextfield({required this.data});
}
mixin Textfielddata{
  // Create an instance of streamcontroller with name Textfieldcontroller
  StreamController<Textfield?> Textfieldcontroller = StreamController<Textfield?>();

  /* Create a method setfieldtext that has event of type Textfield as the required parameter. In the method add the event in the Textfieldcontroller*/
  void setfieldtext({required Textfield event}) {
    Textfieldcontroller.add(event);
  }

  /* Create a method closetextmixin. In the method await and close the Textfieldcontroller*/
  void closetextmixin() async{
    await Textfieldcontroller.close();
  }
}