import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetching API',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var jsonList;
  @override
    void initState(){
      getData();
    }

    // 
    void getData() async {
    try {
      // Get request
      var response = await Dio()
          .get('https://protocoderspoint.com/jsondata/superheros.json');
      // verify request status
      if(response.statusCode == 200){
        setState(() {
          // make json list
          jsonList = response.data['superheros'] as List; 
        });
    
      } else{
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
        title: Text(
          'GeeksForGeeks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: jsonList == null ? 0: jsonList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.network(
                  jsonList[index]['url'], 
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50,
                ),
                ),
                
              title: Text(jsonList[index]['name']),
              subtitle: Text(jsonList[index]['power']),
            ));
          }),
    );
  }
}
