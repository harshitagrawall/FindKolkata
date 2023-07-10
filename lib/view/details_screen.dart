import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/view_model/details_view_modal.dart';
import 'package:provider/provider.dart';


class DetailsScreen extends StatefulWidget {
  var id;
  DetailsScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsViewViewModal detailsViewViewModal = DetailsViewViewModal();

  @override
  void initState() {
    // TODO: implement initState
    detailsViewViewModal.fetchDetailsList(widget.id);
    print('id =${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var device_size,height,width;
    device_size = MediaQuery.of(context).size;
    height = device_size.height;
    width = device_size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<DetailsViewViewModal>(
        create: (BuildContext context) => detailsViewViewModal,
        child: Consumer<DetailsViewViewModal>(builder: (context, value, _) {
          switch (value.detailsList.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.detailsList.message.toString()));
            case Status.COMPLETED:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width*.075,
                    ),
                    Container(
                      height: width*.49,
                      width: double.infinity,
                      child: Image.asset('image/findKolkata.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(
                      height: width*.005,
                    ),
                    Text(
                      value.detailsList.data!.name.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      value.detailsList.data!.areaName.toString(),
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '4.8 ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 17,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width*.085,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 25.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(Icons.call),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 25.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(Icons.location_on),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 25.5,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('image/whatsapp.jpg'),
                              radius: 25,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 25.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(Icons.share),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width*.1,
                    ),
                    Container(
                      height: .5,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: width*.05,
                    ),
                    Text(
                      'Photos',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: width*.195,
                            width: width*.195,
                            child: Image.asset('image/findKolkata.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: width*.195,
                            width: width*.195,
                            child: Image.asset('image/findKolkata.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: width*.195,
                            width: width*.195,
                            child: Image.asset('image/findKolkata.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: width*.195,
                            width: width*.195,
                            child: Image.asset('image/findKolkata.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width*.05,
                    ),
                    Container(
                      height: .5,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: width*.05,
                    ),
                    Container(
                      width: double.infinity,
                      height: width*.195,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Text(
                                      value.detailsList.data!.address.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(Icons.copy, size: 15),
                                  ),
                                  Text(
                                    'Copy Adress',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image(
                                image: AssetImage('image/googleMap.jpeg'),
                                height: width*.22,
                                width: width*.195,
                                fit: BoxFit.contain),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width*.05,
                    ),
                    Container(
                      height: .5,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      height: width*.12,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.call_outlined),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(   value.detailsList.data!.contactNumber.toString(),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width*.05,
                    ),
                    Container(
                      height: .5,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              );
          }
          return Container();
        }),
      ),
    );
  }
}
