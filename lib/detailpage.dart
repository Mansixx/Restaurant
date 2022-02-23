import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {

  String lat;
  String long;
  Detail({required this.lat,required this.long});
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Detail> {
  final String allCustomerURL =
      "";
  var data;
  late String lat;
  late String long;

  @override
  // ignore: must_call_super

  void initState() {
    lat=widget.lat;
    long=widget.long;
    print(long);
    print(lat);
    this.getJsonData();
    super.initState();
  }

  // ignore: missing_return
  Future<String> getJsonData() async {
    var response = await http.get(
      // Encoding URL
        Uri.parse("http://fmtest.dishco.com/shawmanservices/api/GetFormatedAddress/FunPubRetrieveFormatedAddress?StrLocLatitude=$lat&StrLocLongitude=$long"),
        headers: {"AndroidPhone": "EV6FTlgBhOalM+qjJpr2OZpAEpPkYJHC5I1aOWyeLevwSIpuzyKEAg=="});

    print(response.body);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;

      print("data");
      print(data);
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Restaurant Detail"),
        ),
        // backgroundColor: Colors.blueGrey.shade300,
        body: SafeArea(
          child: Scrollbar(
            child: data.length<0?CircularProgressIndicator():Text(data["CityName"])
          ),
        ),
      ),
    );
  }
}