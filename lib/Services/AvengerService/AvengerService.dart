import 'dart:io';

import 'package:api/Helpers/Utitilites/Utilities.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';

import '../../BO/BO.dart';
import '../../Helpers/APIHandlerHelper/APIHandlerHelper.dart';
import '../../Helpers/AppConstants/AppConstants.dart';
import 'IAvengerService.dart';

// Create a class AvengerService that implements IAvengerService
class AvengerService implements IAvengerService {
  // Create an instance _dio of the Dio package and the set the base url in the base options
  final Dio _dio =
      Dio(BaseOptions(baseUrl: AppConstants.avengerServiceBaseUrl));

  /* Create a method createNewAvenger of type Service result of AvengerBO, since this method is 
  executing after a computation it is set to future .This method, gets the hero of type AvengerBO as required.
  In the try block for creating avenger post method is accessed using the dio instance. If the status code is 201, service result 
  is returned that consist of the deserialized data, the status code- OK and the message as the new hero is created. The exceptions
  FormatException, SocketException is handled in the on block and in the catch block the exception details are written.
   */
  @override
  Future<ServiceResult<AvengerBO>> createNewAvenger(
      {required AvengerBO hero}) async {
    try {
      var responseData = await _dio.post(
          AppConstants.avengerServiceCreateNewHeroEndPoint,
          data: JsonMapper.serialize(hero));
      if (responseData.statusCode == 201) {
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: JsonMapper.deserialize<AvengerBO>(responseData.data),
            message: "New hero is created");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        message: "Data has not been created",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        message: "There is no internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        message: e.toString(),
      );
    }
  }

  /* Create a method deleteHeroFromAvenger of type Service result of List of AvengerBO, since this method is 
  executing after a computation it is set to future .This method, gets the hero of type AvengerBO as required.
  In the try block of deleteHeroFromAvenger delete method is accessed using the dio instance. If the status code is 200, The data from the response
  is stored in the variable content. The list of type avengerBO and name finalcontent is initialized. If the reponse is of type list then for every element in the response
  is deserialized and stored in the variable instance. Check if instance is not equal to none then it is added to the list finalcontent. The service result 
  is returned that consist of list finalcontent, the status code- OK and the message as the new hero has been deleted. The exceptions
  FormatException, SocketException is handled in the on block and in the catch block the exception details are written.
   */
  @override
  Future<ServiceResult<List<AvengerBO>>> deleteHeroFromAvenger(
      {required AvengerBO hero}) async {
    try {
      var resposeFromServer = await _dio
          .delete("${AppConstants.avengerServiceEditHeroEndPoint}/${hero.id}");
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data deleted Successfully");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data not deleted",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is no internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }

  /* Create a method editNameOfAvenger of type Service result of List of AvengerBO, since this method is 
  executing after a computation it is set to future .This method, gets the hero of type AvengerBO as required.
  In the try block of editNameOfAvenger put method is accessed using the dio instance. If the status code is 200, The data from the response
  is stored in the variable content. The list of type avengerBO and name finalcontent is initialized. If the reponse is of type list then for every element in the response
  is deserialized and stored in the variable instance. Check if instance is not equal to none then it is added to the list finalcontent. The service result 
  is returned that consist of list finalcontent, the status code- OK and the message as the new hero has been deleted. The exceptions
  FormatException, SocketException is handled in the on block and in the catch block the exception details are written.
   */
  @override
  Future<ServiceResult<List<AvengerBO>>> editNameOfAvenger(
      {required AvengerBO hero}) async {
    try {
      var resposeFromServer = await _dio.put(
          "${AppConstants.avengerServiceEditHeroEndPoint}/${hero.id}",
          data: JsonMapper.serialize(hero));
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got edited Successfully");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been edited",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is no internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }

  /* Create a method getAllAvengers of type Service result of List of AvengerBO, since this method is 
  executing after a computation it is set to future . In the try block of getAllAvengers get method is accessed using the dio instance. If the status code is 200, The data from the response
  is stored in the variable content. The list of type avengerBO and name finalcontent is initialized. If the reponse is of type list then for every element in the response
  is deserialized and stored in the variable instance. Check if instance is not equal to none then it is added to the list finalcontent. The service result 
  is returned that consist of list finalcontent, the status code- OK and the message as the data got successfully is passed. The exceptions
  FormatException, SocketException is handled in the on block and in the catch block the exception details are written.
   */
  @override
  Future<ServiceResult<List<AvengerBO>>> getAllAvengers() async {
    try {
      var resposeFromServer =
          await _dio.get(AppConstants.avengerServiceEditHeroEndPoint);
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is no internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }
}
