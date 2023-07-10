import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/details_modal.dart';
import 'package:mvvm/respository/details_repository.dart';

class DetailsViewViewModal with ChangeNotifier {

  final _myRepo = DetailsRepository();

  ApiResponse<DetailsModal> detailsList = ApiResponse.loading();

  setDetailsList(ApiResponse<DetailsModal> response){
    detailsList = response ;
    notifyListeners();
  }


  Future<void> fetchDetailsList (String id)async{

    setDetailsList(ApiResponse.loading());

    _myRepo.fetchDetailsList(id).then((value){

      setDetailsList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setDetailsList(ApiResponse.error(error.toString()));

    });
  }

}