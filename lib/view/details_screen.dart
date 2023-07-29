import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/details_view_modal.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  var id;

  DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsViewViewModal detailsViewViewModal = DetailsViewViewModal();

  //
  // callNumber()async{
  //   await launch(dialNumber);
  //
  // }

  @override
  void initState() {
    // TODO: implement initState
    detailsViewViewModal.fetchDetailsList(widget.id);
    print('id =${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void sendWhattsApp() {
      String url = "whatsapp://send?phone=+917748866267&text=hello";
      launch(url);
    }

    var device_size, height, width;
    device_size = MediaQuery.of(context).size;
    height = device_size.height;
    width = device_size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<DetailsViewViewModal>(
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
                        height: width * .075,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                value.detailsList.data!.banner.toString()),
                          ),
                          border: Border.all(width: .5,color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: width * .49,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: width * .005,
                      ),
                      Text(
                        // 'hello',
                        value.detailsList.data!.name.toString(),
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        // 'hello',
                        value.detailsList.data!.areaName.toString(),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            value.detailsList.data!.rating.toString(),
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
                        height: width * .085,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FlutterPhoneDirectCaller.callNumber(value
                                  .detailsList.data!.contactNumber
                                  .toString());
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 25.5,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.call),
                              ),
                            ),
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.grey,
                          //   radius: 25.5,
                          //   child: CircleAvatar(
                          //     backgroundColor: Colors.white,
                          //     radius: 25,
                          //     child: Icon(Icons.location_on),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              if (value.detailsList.data!.contactNumber
                                      .toString()[0] ==
                                  '+') {
                                String url =
                                    "whatsapp://send?phone=${value.detailsList.data!.contactNumber.toString()}";
                                launch(url);
                              } else {
                                String url =
                                    "whatsapp://send?phone=+91${value.detailsList.data!.contactNumber.toString()}";
                                launch(url);
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 25.5,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('image/whatsapp.jpg'),
                                radius: 25,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Share.share('com.example.mvvm');
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 25.5,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.share),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * .1,
                      ),
                      Container(
                        height: .5,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: width * .03,
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
                                  border:
                                      Border.all(color: Colors.grey, width: .5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: width * .195,
                                width: width * .195,
                                child: Image.network(
                                    value.detailsList.data!.images![0].toString(),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: width * .195,
                              width: width * .195,
                              child: Image.network(
                                  value.detailsList.data!.images![0].toString(),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: width * .195,
                              width: width * .195,
                              child: Image.network(
                                  value.detailsList.data!.images![0].toString(),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: width * .195,
                              width: width * .195,
                              child: Image.asset(
                                  value.detailsList.data!.images![0].toString(),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * .05,
                      ),
                      Container(
                        height: .5,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: width * .03,
                      ),
                      Container(
                        width: double.infinity,
                        height: width * .195,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: width*.03),
                                  child: Icon(Icons.map_outlined,size: 19,),
                                ),
                                Flexible(
                                    child: Text(
                                  value.detailsList.data!.address.toString(),
                                  overflow: TextOverflow.visible,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width*.08),
                              child: GestureDetector(
                                onTap: () async {
                                  Utils.toastMessage('Copied Address to Clipboard');
                                  await Clipboard.setData(ClipboardData(text: value.detailsList.data!.address.toString(),));
                                  // copied successfully
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: width*.01),
                                      child: Icon(Icons.copy, size: 15),
                                    ),
                                    Text(
                                      'Copy Adress',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: width * .02,
                      ),
                      Container(
                        height: .5,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: width*.04,
                      ),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined,size: 20,),
                          Padding(
                            padding: EdgeInsets.only(left: width*.03),
                            child: Text('Open Time 12:00 pm - 11:00 pm'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width*.04,
                      ),
                      Container(
                        height: .5,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      Container(
                        height: width * .12,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(Icons.call_outlined,size: 19,),
                            Padding(
                              padding: EdgeInsets.only(left: width*.03),
                              child: Text(
                                value.detailsList.data!.contactNumber.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: width * .02,
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
      ),
    );
  }
}
