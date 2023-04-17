import 'package:api/BO/BO.dart';
import 'package:api/Helpers/APIHandlerHelper/APIHandlerHelper.dart';
import 'package:api/Helpers/Mixins/Textfield.dart';
import 'package:api/Helpers/Utitilites/Utilities.dart';
import 'package:api/Pages/FirstPage/FirstPageModel.dart';
import 'package:flutter/material.dart';

import '../../Helpers/AppNavigations/NavigationMixin.dart';
import '../../Helpers/Mixins/Popup.dart';

// Create a class FirstPageVM that extends FirstPageModel
class FirstPageVM extends FirstPageModel {
  /* Create a method fetchAllAvengers of type void. In the try block the instance of AvengerBO is created. Call the setIsAvengersLoading and set the value of 
    isLoading as true. Create a variable data that stores the response received from the method getAllAvengers accessed using IAvengerService instance.
    Call the method setAllAvengers and set the value of newAvengers as the content in variable data. Call the method setIsAvengersLoading and change the isloading value 
    as false. In the catch block write the exceptiondata*/

  Future<void> fetchAllAvengers() async {
    try {
      setIsAvengersLoading(isLoading: true);
      var data = await avengerServiceInstance.getAllAvengers();
      if (data.statusCode == HttpStatusCode.OK) {
        setAllAvengers(newAvengers: data.content ?? []);
        seterror(errortext: " ");
      } else {
        error = data.message.toString();
        seterror(errortext: error);
        // set the error string to show to the view
        print("************************************");
        print(data.message.toString());
        print("************************************");
      }
      setIsAvengersLoading(isLoading: false);
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method addHero of type void and it requires nameofhero of datatype String as parameter. In the try block the instance of AvengerBO
  is created. In the constuctor null is passed to id and nameofhero is passed to the name. Create a variable data
  that stores the response received from the method deleteHeroFromAvenger accessed using IAvengerService instance. FOr the popup to be dismissed
  call the cancelinput method. Then, Use await and call the function fetchAllAvengers. In the catch block write the exceptiondata*/

  Future<void> addHero({required String nameofhero}) async {
    try {
      cancelInput();
      setIsAvengersLoading(isLoading: true);
      AvengerBO instance = AvengerBO(id: null, name: nameofhero);
      var data = await avengerServiceInstance.createNewAvenger(hero: instance);
      await fetchAllAvengers();
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method editHero of type void and it requires index of int datatype and nameofhero of String datatype as parameter. In the try block, create a variable
    heroname of String datatype and store the nameofhero in it. The instance of AvengerBO is created and in the constuctor the id of allAvenger's ath the index is passed to id and heroname is passed to the name. 
    Create a variable data that stores the response received from the method editNameOfAvenger accessed using IAvengerService instance. Use await and call
    the function fetchAllAvengers. For the popup to be dismissed the cancelinput method is called. In the catch block write the exceptiondata*/

  Future<void> editHero(
      {required int index, required String nameofhero}) async {
    try {
      cancelInput();
      setIsAvengersLoading(isLoading: true);
      String heroname = nameofhero;
      AvengerBO instance = AvengerBO(id: allAvengers[index].id, name: heroname);
      var data = await avengerServiceInstance.editNameOfAvenger(hero: instance);
      await fetchAllAvengers();
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method deleteHero of type void and it requires index as parameter. In the try block the instance of AvengerBO
  is created. In the constuctor the id of allAvenger's ath the index is passed to id and null is passed to the name. Create a variable data
  that stores the response received from the method deleteHeroFromAvenger accessed using IAvengerService instance. Use await and call
  the function fetchAllAvengers. In the catch block write the exceptiondata*/

  Future<void> deleteHero({required int index}) async {
    try {
      AvengerBO instance = AvengerBO(id: allAvengers[index].id, name: null);
      var data =
          await avengerServiceInstance.deleteHeroFromAvenger(hero: instance);
      await fetchAllAvengers();
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method showpop of type Future. The setfield method in popup mixin is called inside this method and in the event The class Addtext's required
  parameter data of type list dynamic is passed. The list consist of null in the zeroth position and message showpopup.
  in the first position*/

  Future<void> showpop() async {
    setfield(event: AddText(data: [null, "showpopup"]));
  }

  /* Create a method showsecondpop of type Future. It has index as the required parameter.
  The setfield method in popup mixin is called inside this method and in the event The class Addtext's required
  parameter data of type list dynamic is passed. The list consist of index in the zeroth position and message popupaction
  in the first position*/

  Future<void> showsecondpop({required int index}) async {
    setfield(event: AddText(data: [index, "popupaction"]));
  }

  /* Create a method cancelInput that adds the NavigatorPop function to the stream */

  void cancelInput() {
    navigationStream.add(NavigatorPop());
  }

  void onchange(String text){
    Textfieldcontroller.add(AddTextfield(data: text));
  }
}
