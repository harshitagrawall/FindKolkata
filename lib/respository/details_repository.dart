

import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/details_modal.dart';
import 'package:mvvm/res/app_url.dart';

class DetailsRepository {
  // id=2
  var id;

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<DetailsModal> fetchDetailsList(String id)async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.detailsListUrl+'id=$id');
      return response = DetailsModal.fromJson(response);

    }catch(e){
      throw e ;
    }
  }
}