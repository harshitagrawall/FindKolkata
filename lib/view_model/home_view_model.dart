import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/home_modal.dart';
import 'package:mvvm/respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<ItemListModal> homeList = ApiResponse.loading();

  setHomeList(ApiResponse<ItemListModal> response){
    homeList = response ;
    notifyListeners();
  }


  Future<void> fetchHomeListApi (String data,String area)async{

    setHomeList(ApiResponse.loading());

    _myRepo.fetchHomeList(data,area).then((value){

      setHomeList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setHomeList(ApiResponse.error(error.toString()));

    });
  }


}