import 'package:flutter/material.dart';
import 'package:flutter_application_1/ClientModel.dart';
import 'package:flutter_application_1/Database.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // data for testing
  // List<Client> testClients = [
  //   Client(firstName: "Raouf", lastName: "Rahiche", blocked: false),
  //   Client(firstName: "Zaki", lastName: "oun", blocked: true),
  //   Client(firstName: "oussama", lastName: "ali", blocked: false),
  // ];

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar( title: Text("Flutter synthese"),),
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllMesures(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                Client item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background:Container(color: Colors.red),
                  onDismissed: (direction){
                    DBProvider.db.deleteMesures(item.id);
                  },
                child:  ListTile(
                  title : Text(item.m_distance),
                  subtitle:Text(item.m_date),
                  leading: Text(item.id.toString()),
                )
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
