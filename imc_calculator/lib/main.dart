import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";
  double _Imc = 0.0;
  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calculate () {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) /100;
      double _Imc = weight / (height*height);
      if(_Imc < 18.5){
        _infoText = "Você esta abaixo do peso ideal, seu IMC atual é ${(_Imc).toStringAsFixed(2)}";
      }
      else if( _Imc > 18.5 && _Imc < 24.9){
        _infoText = "Você esta no peso ideal, seu IMC atual é ${(_Imc).toStringAsFixed(2)}";
      }
      else if( _Imc > 24.9 && _Imc < 30.0){
        _infoText = "Você esta acima do peso ideal, seu IMC atual é ${(_Imc).toStringAsFixed(2)}";
      }
      else if( _Imc > 30){
        _infoText = "Você esta no grau de obesidade, procure um medico/nutricionista, seu IMC atual é ${(_Imc).toStringAsFixed(2)}";
      }


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Imc"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child:Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Icon(Icons.person_outline, size: 120.0, color: Colors.green),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 20.0),
              controller: weightController,
              validator: (value) {
                if(value!.isEmpty){
                  return "Insira sua Altura";
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 20.0),
              controller: heightController,
              validator: (value) {
                if(value!.isEmpty){
                  return "Insira sua Altura";
                }
              },
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.green,
                  ),
                )),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 20.0),
            )
          ]),
        ),
      ),
    );
  }
}
