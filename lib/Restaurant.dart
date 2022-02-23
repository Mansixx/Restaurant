import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:restaurants/detailpage.dart';

class Restaurant extends StatefulWidget {
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Restaurant> {
  final String allCustomerURL =
      "http://fmtest.dishco.com/shawmanservices/api/RestaurantDetailsByFilter/GetFunPubRestaurantDetailsByFilter?StrLocLatitude=19.1105765&StrLocLongitude=73.0174654&StrLocCityName=Navi Mumbai&IntLocOrderby=1&IntLocNoOfRecords=0";
  var data;

  @override
  // ignore: must_call_super

  void initState() {
    this.getJsonData();
    super.initState();
  }

  // ignore: missing_return
  Future<String> getJsonData() async {
    var response = await http.get(
      // Encoding URL
        Uri.parse(allCustomerURL),
        headers: {"AndroidPhone": "EV6FTlgBhOalM+qjJpr2OZpAEpPkYJHC5I1aOWyeLevwSIpuzyKEAg=="});

    print(response.body);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;

      print("data");
      print(data["AllRestaurantDishes"][0]["RestaurantId"]);
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Restaurant list"),
        ),
        // backgroundColor: Colors.blueGrey.shade300,
        body: SafeArea(
          child: Scrollbar(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>Detail(lat:data["AllRestaurantDishes"][index]["Latitude"] ,long:data["AllRestaurantDishes"][index]["Longitude"] ,) ),
                        );
                      },
                      child: Container(
                        height: 100,

                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          elevation: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                             Text("Name: "+data["AllRestaurantDishes"][index]["RestaurantName"])
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}