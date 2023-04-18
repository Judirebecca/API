import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../BO/BO.dart';
import '../../Helpers/AppNavigations/NavigationMixin.dart';
import '../../Helpers/Mixins/Popup.dart';
import '../../Helpers/Mixins/Textfield.dart';
import '../../Services/AvengerService/IAvengerService.dart';
part 'FirstPageModel.g.dart';

// Create a class FirstPageModel that has the mixins Popupdata,NavigationMixin, Textfielddata
class FirstPageModel = _FirstPageModelBase
    with _$FirstPageModel, Popupdata, NavigationMixin, Textfielddata;

abstract class _FirstPageModelBase with Store {
  // The registered IAvengerService is got using the get_it instance and stored in variable avengerServiceInstance of type final
  final avengerServiceInstance = GetIt.instance.get<IAvengerService>();

  // Create a list allAvengers of type AvengerBO and initialize it with an empty list
  @observable
  List<AvengerBO> allAvengers = [];

  // Create a variable isAvengersLoading of bool datatype and set its value to false
  @observable
  bool isAvengersLoading = false;

  // Create a method setIsAvengersLoading that requires isLoading variable of bool datatype as parameter and inside the method set the value of isLoading to isAvengersLoading
  @action
  void setIsAvengersLoading({required bool isLoading}) {
    isAvengersLoading = isLoading;
  }

  // Create a method setAllAvengers that requires newAvengers variable of datatype List of AvengerBo as parameter and inside the method set allAvengers as empty list and set the value of newAvengers to allAvengers
  @action
  void setAllAvengers({required List<AvengerBO> newAvengers}) {
    allAvengers = [];
    allAvengers = newAvengers;
  }

// Create a variable texts of String datatype and assign empty string as its value
  String texts = " ";

// Create a method settext that requires data variable of String datatype as parameter and inside the method set data as empty String and set the value of data to texts
  void settext({required String data}) {
    data = "";
    texts = data;
  }
  String error = "";
  void seterror({required String errortext}){
    error = errortext;
  }
}
