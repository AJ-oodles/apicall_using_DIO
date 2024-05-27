import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
var jsonList;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get('https://protocoderspoint.com/jsondata/superheros.json');
      if (response.statusCode == 200) {
        setState(() {
          // Parse the response data as JSON
print(response);
          jsonList= response.data["superheros"] as List;

        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning about dio in flutter', style: TextStyle(color: Colors.blue)),
      ),
      body: ListView.builder(
        // Use jsonData.length to determine the number of items
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  jsonList[index]['url'],
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50,
                ),
              ),
              title: Text(jsonList[index]["name"]),
              subtitle: Text(jsonList[index]["power"]),
            ),
          );
        },
        itemCount: jsonList==null?0:jsonList.length,
      ),
    );
  }
}
