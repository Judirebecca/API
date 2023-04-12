import 'dart:async';

// Create an abstract class Popup
abstract class Popup{}

// create a class AddText that extends Popup
class AddText extends Popup{

  // Create a variable data of List type dynamic
  List<dynamic> data;

  // In the class's constructor pass the data as required parameter
  AddText({required this.data});
}

// Create a mixin Popupdata
mixin Popupdata{

  // Create an instance of streamcontroller with name popupcontroller
  StreamController<Popup?> popupcontroller = StreamController<Popup?>();

  /* Create a method setfield that has event of type Popup as the required parameter. In the method add the event in the popupcontroller*/
  void setfield({required Popup event}) {
    popupcontroller.add(event);
  }

  /* Create a method closemixin. In the method await and close the popupcontroller*/
  void closemixin() async{
    await popupcontroller.close();
  }
}