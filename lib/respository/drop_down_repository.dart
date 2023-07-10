import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/drop_down_modal.dart';
import 'package:mvvm/res/app_url.dart';

class DropDownRepository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<DropDownModal> fetchDropDownList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.dropDownListUrl);
      return response = DropDownModal.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}