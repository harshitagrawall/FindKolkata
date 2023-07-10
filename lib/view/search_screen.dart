import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
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
  final TextEditingController _texfieldController = TextEditingController();
  TrendingListViewViewModal trendingListViewViewModal = TrendingListViewViewModal();
  DropDownListViewViewModal dropDownListViewViewModal = DropDownListViewViewModal();

  @override
  void initState() {
    // TODO: implement initState
    trendingListViewViewModal.fetchTrendingListApi();
    dropDownListViewViewModal.fetchDropDownItemList();
    super.initState();
  }

  final listItem = [
    'Please Select',
    'Rau',
    'vijay nagar',
    'Indore',
    'L.I.G',
    'Palasia',
    '56 Dukaan',
    'Holker Staidum',
  ];

  String? _selValue = 'Please Select';
  FocusNode _selvalueFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var device_size, width;
    device_size = MediaQuery.of(context).size;
    width = device_size.width;
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
            child: DropdownButtonFormField<String>(
              value: _selValue,
              onChanged: (val) {
                setState(() {
                  _selValue = val as String;
                });
              },
                   items: listItem
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
            ),
          ),
          SizedBox(
            height: width * .099,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            data: _texfieldController.text.toString(),
                            area: _selValue,
                          )));
              // print(_texfieldController.toString());
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
            height: width * .12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Trending',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Icon(
                  Icons.trending_up,
                  size: 30,
                ),
              ],
            ),
          ),
          ChangeNotifierProvider<TrendingListViewViewModal>(
            create: (BuildContext context) => trendingListViewViewModal,
            child: Consumer<TrendingListViewViewModal>(
                builder: (context, value, _) {
              switch (value.trendingList.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.trendingList.message.toString()));
                case Status.COMPLETED:
                  return SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * .05, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.home);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: width * .22,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .025, vertical: 5),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://picsum.photos/250?image=9',
                                        // value.trendingList.data!.listings[index].banner.toString(),
                                        errorBuilder: (context, error, stack) {
                                          return Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                        height: width * .17,
                                        width: width * .17,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * .025),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.trendingList.data!
                                                  .listings![index].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '5.0 stars',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Vijay Nagar, Indore',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
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
    ));
  }
}
