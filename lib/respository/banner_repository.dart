import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/banner_modal.dart';
import 'package:mvvm/model/home_modal.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/res/app_url.dart';

class BannerRepository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<BannerModal> fetchBanner()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getBanner);
      return response = BannerModal.fromJson(response);


    }catch(e){
      throw e ;
    }
  }
}