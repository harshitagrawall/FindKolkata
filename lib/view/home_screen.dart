import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/view/details_screen.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  var data,area;

  HomeScreen({Key? key, required this.data, required this.area})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchHomeListApi();
    // print('hello${widget.area}+${widget.data}');
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     InkWell(
      //         onTap: () {
      //           userPrefernece.remove().then((value) {
      //             Navigator.pushNamed(context, RoutesName.login);
      //           });
      //         },
      //         child: Center(child: Text('Logout'))),
      //     SizedBox(
      //       width: 20,
      //     )
      //   ],
      // ),
      body: Column(
        children: [
          Container(
            height: width*.48,
            child: Image.asset('image/findKolkata.png'),
          ),
          ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context) => homeViewViewModel,
            child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
              switch (value.homeList.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.homeList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.homeList.data!.listings!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .05, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          id: value
                                              .homeList.data!.listings![index].id
                                              .toString())));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: width * .48,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Image.network(
                                              value.homeList.data!.listings![index].banner.toString(),
                                              errorBuilder:
                                                  (context, error, stack) {
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
                                            const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.homeList.data!.listings![0]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  height: width * .06,
                                                  width: width * .11,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty
                                                          .all<Color>(Colors
                                                          .green.shade900),
                                                      foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                    ),
                                                    onPressed: () {},
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '5.0',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Vijay Nagar, Indore',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Service Type:  ',
                                                      style:
                                                      TextStyle(fontSize: 12),
                                                    ),
                                                    Text('Home Cleaning',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: width * .075,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: width * .44,
                                            height: width * .075,
                                            child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                                foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                              ),
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    size: 17,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 5),
                                                    child: Text('Call Now'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * .44,
                                            height: width * .075,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1.0, color: Colors.blue),
                                              ),
                                              onPressed: () {},
                                              child: Text('Send Enquiry'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1.5,
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
              }
              return Container();
            }),
          ),
          Container(
            height: width*.48,
            child: Image.asset('image/findKolkata.png'),
          ),
        ],
      )
    );
  }
}
