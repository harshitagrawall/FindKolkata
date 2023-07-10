import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/drop_down_modal.dart';
import 'package:mvvm/respository/drop_down_repository.dart';



class DropDownListViewViewModal with ChangeNotifier{

  final _myRepo = DropDownRepository();

  ApiResponse<DropDownModal> dropDownList = ApiResponse.loading();

  setDropDownList(ApiResponse<DropDownModal> response){
    dropDownList = response ;
    notifyListeners();
  }



  Future<void> fetchDropDownItemList ()async{

    setDropDownList(ApiResponse.loading());

    _myRepo.fetchDropDownList().then((value){

      setDropDownList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setDropDownList(ApiResponse.error(error.toString()));

    });
  }

}