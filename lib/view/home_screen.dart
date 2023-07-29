import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/view/details_screen.dart';
import 'package:mvvm/view_model/banner_view_view_modal.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  var data, area;

  HomeScreen({Key? key, required this.data, required this.area})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  BannerViewViewModal bannerViewViewModal = BannerViewViewModal();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchHomeListApi(widget.data, widget.area);
    bannerViewViewModal.fetchBannerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var device_size, height, width;
    device_size = MediaQuery.of(context).size;
    height = device_size.height;
    width = device_size.width;
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ChangeNotifierProvider<BannerViewViewModal>(
              create: (BuildContext context) => bannerViewViewModal,
              child:
                  Consumer<BannerViewViewModal>(builder: (context, value, _) {
                switch (value.bannerList.status) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.bannerList.message.toString()));
                  case Status.COMPLETED:
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: width * .05),
                      child: Container(
                        height: width * .35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                            value.bannerList.data!.banners![0].toString()),
                      ),
                    );
                }
                return Container();
              }),
            ),

            Column(
              children: [
                ChangeNotifierProvider<HomeViewViewModel>(
                  create: (BuildContext context) => homeViewViewModel,
                  child:
                      Consumer<HomeViewViewModel>(builder: (context, value, _) {
                    switch (value.homeList.status) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(
                            child: Text(value.homeList.message.toString()));
                      case Status.COMPLETED:
                        return SingleChildScrollView(
                          // Container(
                          // height: width * .4,
                          // decoration: BoxDecoration(
                          // border: Border.all(),
                          // borderRadius: BorderRadius.circular(10),
                          // ),
                          // child:  Image.asset(
                          // 'image/findKolkata.png',
                          // ),
                          // );
                          child: ListView.builder(
                              itemCount: value.homeList.data!.listings!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .05),
                                  child: InkWell(
                                    onTap: () {
                                      print(value.homeList.data!
                                          .listings![index].banner
                                          .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                      id: value.homeList.data!
                                                          .listings![index].id
                                                          .toString())));
                                    },
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          if (index == 4 && index > 0)
                                            ChangeNotifierProvider<
                                                BannerViewViewModal>(
                                              create: (BuildContext context) =>
                                                  bannerViewViewModal,
                                              child:
                                                  Consumer<BannerViewViewModal>(
                                                      builder:
                                                          (context, value, _) {
                                                switch (
                                                    value.bannerList.status) {
                                                  case Status.LOADING:
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  case Status.ERROR:
                                                    return Center(
                                                        child: Text(value
                                                            .bannerList.message
                                                            .toString()));
                                                  case Status.COMPLETED:
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal:
                                                                  width * .05),
                                                      child: Container(
                                                        height: width * .35,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Image.network(
                                                            value.bannerList.data!.banners![0].toString()),
                                                      ),
                                                    );
                                                }
                                                return Container();
                                              }),
                                            ),
                                          Container(
                                            height: width * .50,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(width: .5,color: Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Image.network(
                                                          value
                                                              .homeList
                                                              .data!
                                                              .listings![index]
                                                              .banner
                                                              .toString(),
                                                          errorBuilder:
                                                              (context, error,
                                                                  stack) {
                                                            return Icon(
                                                              Icons.error,
                                                              color: Colors.red,
                                                            );
                                                          },
                                                          height: width * .27,
                                                          width: width * .17,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Container(
                                                          width: width * .7,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  value
                                                                      .homeList
                                                                      .data!
                                                                      .listings![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      width *
                                                                          .06,
                                                                  width: width *
                                                                      .11,
                                                                  child:
                                                                      TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                                          .green
                                                                          .shade900),
                                                                      foregroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .white),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          value
                                                                              .homeList
                                                                              .data!
                                                                              .listings![index]
                                                                              .rating
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .star,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Text(
                                                                  value
                                                                      .homeList
                                                                      .data!
                                                                      .listings![
                                                                          index]
                                                                      .address
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                // Row(
                                                                //   children: [
                                                                //     Text(
                                                                //       'Service Type:  ',
                                                                //       style: TextStyle(
                                                                //           fontSize: 12),
                                                                //     ),
                                                                //     Text('Home Cleaning',
                                                                //         style: TextStyle(
                                                                //             fontSize: 12,
                                                                //             color:
                                                                //                 Colors.grey)),
                                                                //   ],
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: width * .07,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          FlutterPhoneDirectCaller
                                                              .callNumber(value
                                                                  .homeList
                                                                  .data!
                                                                  .listings![
                                                                      index]
                                                                  .contactNumber
                                                                  .toString());
                                                        },
                                                        child: SizedBox(
                                                          width: width * .44,
                                                          height: width * .075,
                                                          child: TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .blue),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              FlutterPhoneDirectCaller
                                                                  .callNumber(value
                                                                      .homeList
                                                                      .data!
                                                                      .listings![
                                                                          index]
                                                                      .contactNumber
                                                                      .toString());
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.call,
                                                                  size: 17,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Text(
                                                                      'Call Now'),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (value
                                                                  .homeList
                                                                  .data!
                                                                  .listings![
                                                                      index]
                                                                  .whatsappNumber
                                                                  .toString()[0] ==
                                                              '+') {
                                                            String url =
                                                                "whatsapp://send?phone=${value.homeList.data!.listings![index].whatsappNumber.toString()}";
                                                            launch(url);
                                                          } else {
                                                            String url =
                                                                "whatsapp://send?phone=+91${value.homeList.data!.listings![index].whatsappNumber.toString()}";
                                                            launch(url);
                                                          }
                                                        },
                                                        child: SizedBox(
                                                          width: width * .44,
                                                          height: width * .075,
                                                          child: OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              side: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                            onPressed: () {
                                                              if (value
                                                                      .homeList
                                                                      .data!
                                                                      .listings![
                                                                          index]
                                                                      .whatsappNumber
                                                                      .toString()[0] ==
                                                                  '+') {
                                                                String url =
                                                                    "whatsapp://send?phone=${value.homeList.data!.listings![index].whatsappNumber.toString()}";
                                                                launch(url);
                                                              } else {
                                                                String url =
                                                                    "whatsapp://send?phone=+91${value.homeList.data!.listings![index].whatsappNumber.toString()}";
                                                                launch(url);
                                                              }
                                                            },
                                                            child: Text(
                                                                'Send Enquiry'),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: width * .07,
                                                  ),
                                                  Container(
                                                    height: .5,
                                                    width: double.infinity,
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                    }
                    return Container();
                  }),
                ),
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: .5,
            //   width: double.infinity,
            //   color: Colors.grey.shade300,
            // ),
            ChangeNotifierProvider<BannerViewViewModal>(
              create: (BuildContext context) => bannerViewViewModal,
              child:
                  Consumer<BannerViewViewModal>(builder: (context, value, _) {
                switch (value.bannerList.status) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.bannerList.message.toString()));
                  case Status.COMPLETED:
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: width * .05),
                      child: Container(
                        height: width * .35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                            value.bannerList.data!.banners![0].toString()),
                      ),
                    );
                }
                return Container();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
