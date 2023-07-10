import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/trending_modal.dart';
import 'package:mvvm/res/app_url.dart';

class TrendingRepository{

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<TrendingModal> fetchHomeList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.tredingListUrl);
      return response = TrendingModal.fromJson(response);

    }catch(e){
      throw e ;
    }
  }


}