import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=10feb015dd";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
    ),
));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dolar;
  late double euro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor de Moedas \$"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando Dados...",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0 ),
                  textAlign: TextAlign.center,)
              );
              default:
                if(snapshot.hasError){
                  return Center(
                      child: Text("Erro ao carregar dados...",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0 ),
                        textAlign: TextAlign.center,)
                  );
                }
                else {
                  dolar = snapshot.requireData["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.requireData["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.account_balance, size: 150.0, color: Colors.amber),

                        TextField(
                          decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(
                            ),
                            prefixText: "R\$",
                          ),
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Dolar",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(
                            ),
                            prefixText: "\$",
                          ),
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Euro",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(
                            ),
                            prefixText: "\€",
                          ),
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        )
                      ],
                    ),
                  );

                }
          }
        })
    );
  }
}
