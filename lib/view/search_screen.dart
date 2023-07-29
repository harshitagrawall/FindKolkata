import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view_model/drop_down_view_modal.dart';
import 'package:mvvm/view_model/trending_view_modal.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _selValue;

  final TextEditingController _texfieldController = TextEditingController();
  TrendingListViewViewModal trendingListViewViewModal =
      TrendingListViewViewModal();
  DropDownListViewViewModal dropDownListViewViewModal =
      DropDownListViewViewModal();

  @override
  void initState() {
    // TODO: implement initState
    trendingListViewViewModal.fetchTrendingListApi();
    dropDownListViewViewModal.fetchDropDownItemList();
    _selValue = 'Kolkata';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var device_size, width, height;
    device_size = MediaQuery.of(context).size;
    width = device_size.width;
    height = device_size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: width * .245,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: width * .44,
                  width: width * .44,
                  child: Image.asset('image/findKolkata.png'),
                ),
              ],
            ),
            Container(
              height: width * .09,
              width: width * .61,
              child: TextField(
                controller: _texfieldController,
                maxLines: 1,
                style: TextStyle(fontSize: 13),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'What are you looking for...?',
                ),
              ),
            ),
            SizedBox(
              height: width * .05,
            ),
            Container(
              height: width * .099,
              width: width * .61,
              // Set the desired height for the dropdown button
              child: ChangeNotifierProvider<DropDownListViewViewModal>(
                create: (BuildContext context) => dropDownListViewViewModal,
                child: Consumer<DropDownListViewViewModal>(
                    builder: (context, valuee, _) {
                  switch (valuee.dropDownList.status) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(valuee.dropDownList.message.toString()));
                    case Status.COMPLETED:
                      return DropdownButtonFormField<String>(
                        value: _selValue!.isNotEmpty ? _selValue : null,
                        onChanged: (val) {
                          setState(() {
                            _selValue = val as String;
                          });
                        },
                        items: valuee.dropDownList.data!.areas!
                            .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      );
                  }
                  return Container();
                }),
              ),

              // DropdownButton(
              //   items: listItem.map((e) {
              //     return DropdownMenuItem(
              //       child: Text(e),
              //       value: e,
              //     );
              //   }).toList(),
              //   value: _value,
              //   onChanged: (v) {
              //     _value = v as int;
              //   },
              // ),
              // decoration: BoxDecoration(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 16),
              //       filled: true,
              //       fillColor: Colors.grey.shade200,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(30),
              //         ),
              //       ),
              //     ),
            ),
            SizedBox(
              height: width * .099,
            ),
            InkWell(
              onTap: () {
                if (_texfieldController.text.toString().isEmpty) {
                  Utils.toastMessage('Please Enter Service');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                data:
                                    _texfieldController.text.toString().trim(),
                                area: _selValue,
                              )));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  border: Border.all(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: width * .075,
                width: width * .195,
                child: Center(
                    child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: height * .35,
            ),
            Text(
              '@2023 Powered by Find Kolkata',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            // SizedBox(
            //   height: width * .12,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Trending',
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //       ),
            //       Icon(
            //         Icons.trending_up,
            //         size: 30,
            //       ),
            //     ],
            //   ),
            // ),
            // ChangeNotifierProvider<TrendingListViewViewModal>(
            //   create: (BuildContext context) => trendingListViewViewModal,
            //   child: Consumer<TrendingListViewViewModal>(
            //       builder: (context, value, _) {
            //     switch (value.trendingList.status) {
            //       case Status.LOADING:
            //         return Center(child: CircularProgressIndicator());
            //       case Status.ERROR:
            //         return Center(
            //             child: Text(value.trendingList.message.toString()));
            //       case Status.COMPLETED:
            //         return SingleChildScrollView(
            //           child: ListView.builder(
            //               physics: const NeverScrollableScrollPhysics(),
            //               scrollDirection: Axis.vertical,
            //               shrinkWrap: true,
            //               itemCount: value.trendingList.data!.listings!.length,
            //               itemBuilder: (context, index) {
            //                 return Padding(
            //                   padding:
            //                       EdgeInsets.symmetric(horizontal: width * .05),
            //                   child: InkWell(
            //                     onTap: () {
            //                       print(value.trendingList.data!
            //                           .listings![index].banner
            //                           .toString());
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) => DetailsScreen(
            //                                   id: value.trendingList.data!
            //                                       .listings![index].id
            //                                       .toString())));
            //                     },
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           height: width * .50,
            //                           child: Column(
            //                             children: [
            //                               Row(
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 children: [
            //                                   Container(
            //                                     child: Image.network(
            //                                       value.trendingList.data!
            //                                           .listings![index].banner
            //                                           .toString(),
            //                                       errorBuilder:
            //                                           (context, error, stack) {
            //                                         return Icon(
            //                                           Icons.error,
            //                                           color: Colors.red,
            //                                         );
            //                                       },
            //                                       height: width * .27,
            //                                       width: width * .17,
            //                                       fit: BoxFit.cover,
            //                                     ),
            //                                   ),
            //                                   Padding(
            //                                     padding: const EdgeInsets.only(
            //                                         left: 10),
            //                                     child: Container(
            //                                       width: width * .7,
            //                                       child: Column(
            //                                         crossAxisAlignment:
            //                                             CrossAxisAlignment
            //                                                 .start,
            //                                         children: [
            //                                           Text(
            //                                             value
            //                                                 .trendingList
            //                                                 .data!
            //                                                 .listings![index]
            //                                                 .name
            //                                                 .toString(),
            //                                             style: TextStyle(
            //                                                 fontWeight:
            //                                                     FontWeight
            //                                                         .bold),
            //                                           ),
            //                                           SizedBox(
            //                                             height: 8,
            //                                           ),
            //                                           SizedBox(
            //                                             height: width * .06,
            //                                             width: width * .11,
            //                                             child: TextButton(
            //                                               style: ButtonStyle(
            //                                                 backgroundColor:
            //                                                     MaterialStateProperty.all<
            //                                                             Color>(
            //                                                         Colors.green
            //                                                             .shade900),
            //                                                 foregroundColor:
            //                                                     MaterialStateProperty
            //                                                         .all<Color>(
            //                                                             Colors
            //                                                                 .white),
            //                                               ),
            //                                               onPressed: () {},
            //                                               child: Row(
            //                                                 mainAxisAlignment:
            //                                                     MainAxisAlignment
            //                                                         .start,
            //                                                 children: [
            //                                                   Text(
            //                                                     value
            //                                                         .trendingList
            //                                                         .data!
            //                                                         .listings![
            //                                                             index]
            //                                                         .rating
            //                                                         .toString(),
            //                                                     style: TextStyle(
            //                                                         fontSize:
            //                                                             10,
            //                                                         fontWeight:
            //                                                             FontWeight
            //                                                                 .bold),
            //                                                   ),
            //                                                   Icon(
            //                                                     Icons.star,
            //                                                     size: 12,
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           ),
            //                                           SizedBox(
            //                                             height: 8,
            //                                           ),
            //                                           Text(
            //                                             value
            //                                                 .trendingList
            //                                                 .data!
            //                                                 .listings![index]
            //                                                 .address
            //                                                 .toString(),
            //                                             overflow: TextOverflow
            //                                                 .ellipsis,
            //                                             style: TextStyle(
            //                                                 color: Colors.grey,
            //                                                 fontSize: 13),
            //                                           ),
            //                                           SizedBox(
            //                                             height: 5,
            //                                           ),
            //                                           // Row(
            //                                           //   children: [
            //                                           //     Text(
            //                                           //       'Service Type:  ',
            //                                           //       style: TextStyle(
            //                                           //           fontSize: 12),
            //                                           //     ),
            //                                           //     Text('Home Cleaning',
            //                                           //         style: TextStyle(
            //                                           //             fontSize: 12,
            //                                           //             color:
            //                                           //                 Colors.grey)),
            //                                           //   ],
            //                                           // )
            //                                         ],
            //                                       ),
            //                                     ),
            //                                   )
            //                                 ],
            //                               ),
            //                               SizedBox(
            //                                 height: width * .07,
            //                               ),
            //                               Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceEvenly,
            //                                 children: [
            //                                   GestureDetector(
            //                                     onTap: () async {
            //                                       FlutterPhoneDirectCaller
            //                                           .callNumber(value
            //                                               .trendingList
            //                                               .data!
            //                                               .listings![index]
            //                                               .contactNumber
            //                                               .toString());
            //                                     },
            //                                     child: SizedBox(
            //                                       width: width * .44,
            //                                       height: width * .075,
            //                                       child: TextButton(
            //                                         style: ButtonStyle(
            //                                           backgroundColor:
            //                                               MaterialStateProperty
            //                                                   .all<Color>(
            //                                                       Colors.blue),
            //                                           foregroundColor:
            //                                               MaterialStateProperty
            //                                                   .all<Color>(
            //                                                       Colors.white),
            //                                         ),
            //                                         onPressed: () async {
            //                                           FlutterPhoneDirectCaller
            //                                               .callNumber(value
            //                                                   .trendingList
            //                                                   .data!
            //                                                   .listings![index]
            //                                                   .contactNumber
            //                                                   .toString());
            //                                         },
            //                                         child: Row(
            //                                           mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .center,
            //                                           children: [
            //                                             Icon(
            //                                               Icons.call,
            //                                               size: 17,
            //                                             ),
            //                                             Padding(
            //                                               padding:
            //                                                   const EdgeInsets
            //                                                           .only(
            //                                                       left: 5),
            //                                               child:
            //                                                   Text('Call Now'),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                   GestureDetector(
            //                                     onTap: () {
            //                                       if (value
            //                                               .trendingList
            //                                               .data!
            //                                               .listings![index]
            //                                               .whatsappNumber
            //                                               .toString()[0] ==
            //                                           '+') {
            //                                         String url =
            //                                             "whatsapp://send?phone=${value.trendingList.data!.listings![index].whatsappNumber.toString()}";
            //                                         launch(url);
            //                                       } else {
            //                                         String url =
            //                                             "whatsapp://send?phone=+91${value.trendingList.data!.listings![index].whatsappNumber.toString()}";
            //                                         launch(url);
            //                                       }
            //                                     },
            //                                     child: SizedBox(
            //                                       width: width * .44,
            //                                       height: width * .075,
            //                                       child: OutlinedButton(
            //                                         style: OutlinedButton
            //                                             .styleFrom(
            //                                           side: BorderSide(
            //                                               width: 1.0,
            //                                               color: Colors.blue),
            //                                         ),
            //                                         onPressed: () {
            //                                           if (value
            //                                                   .trendingList
            //                                                   .data!
            //                                                   .listings![index]
            //                                                   .whatsappNumber
            //                                                   .toString()[0] ==
            //                                               '+') {
            //                                             String url =
            //                                                 "whatsapp://send?phone=${value.trendingList.data!.listings![index].whatsappNumber.toString()}";
            //                                             launch(url);
            //                                           } else {
            //                                             String url =
            //                                                 "whatsapp://send?phone=+91${value.trendingList.data!.listings![index].whatsappNumber.toString()}";
            //                                             launch(url);
            //                                           }
            //                                         },
            //                                         child: Text('Send Enquiry'),
            //                                       ),
            //                                     ),
            //                                   )
            //                                 ],
            //                               ),
            //                               SizedBox(
            //                                 height: width * .07,
            //                               ),
            //                               Container(
            //                                 height: .5,
            //                                 width: double.infinity,
            //                                 color: Colors.grey.shade300,
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               }),
            //         );
            //     }
            //     return Container();
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
