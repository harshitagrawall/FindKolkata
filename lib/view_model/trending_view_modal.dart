import 'package:flutter/foundation.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/trending_modal.dart';
import 'package:mvvm/respository/trending_repositary.dart';

class TrendingListViewViewModal with ChangeNotifier {

  final _myRepo = TrendingRepository();

  ApiResponse<TrendingModal> trendingList = ApiResponse.loading();

  setTrendingList(ApiResponse<TrendingModal> response){
    trendingList = response ;
    notifyListeners();
  }


  Future<void> fetchTrendingListApi ()async{

    setTrendingList(ApiResponse.loading());

    _myRepo.fetchHomeList().then((value){

      setTrendingList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setTrendingList(ApiResponse.error(error.toString()));

    });
  }

}