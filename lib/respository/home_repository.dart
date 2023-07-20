import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/home_modal.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/res/app_url.dart';

class HomeRepository {

  // q=cleaning&area=rau
  //
  //
  // +'q=$data'+'&area=$area
  var area,data;

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<ItemListModal> fetchHomeList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.homeListUrl);
      // print(AppUrl.homeListUrl+'q=$data'+'&area=$area');
      return response = ItemListModal.fromJson(response);


    }catch(e){
      throw e ;
    }
  }
}