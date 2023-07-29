import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/banner_modal.dart';
import 'package:mvvm/respository/banner_repository.dart';


class BannerViewViewModal with ChangeNotifier {

  final _myRepo = BannerRepository();

  ApiResponse<BannerModal> bannerList = ApiResponse.loading();

  setBannerList(ApiResponse<BannerModal> response){
    bannerList = response ;
    notifyListeners();
  }

  Future<void> fetchBannerList ()async{

    setBannerList(ApiResponse.loading());

    _myRepo.fetchBanner().then((value){

      setBannerList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setBannerList(ApiResponse.error(error.toString()));

    });
  }


}