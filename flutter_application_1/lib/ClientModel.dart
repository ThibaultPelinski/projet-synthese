import 'dart:html';
import 'dart:convert';

Client clientFromJson(String str){
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data){
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id ;
  String m_distance;
  String m_date;


  Client({
    this.id,
    this.m_distance,
    this.m_date,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
      id: json["id"],
        m_distance: json["M_distance"],
        m_date: json["M_date"],
      );

  Map<String, dynamic> toMap() => {
         "id": id,
        "M_distance": m_distance,
        "M_date": m_date,
  };
}