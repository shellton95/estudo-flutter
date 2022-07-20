// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // criando a chave de formulario para validação
 
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  String _result = 'Informe Seus Dados';

  void _resetView(){
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
        _result = 'Informe Seus Dados';
    });
  }

  void _calcular(){
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);

    setState(() {
        if(imc < 18.6){
          //toStringAsPrecision(4)-> precisão dos ultimos 4 numeros apos a virgula
          _result = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
        }else if(imc >= 18.6 && imc < 29.9){
          _result = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if(imc >= 24.9 && imc < 29.9){
           _result = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
        } else if(imc >= 29.9 && imc < 34.9){
          _result = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        } else if(imc >= 29.9 && imc < 39.9){
          _result = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        } else if(imc >= 40){
          _result = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
        }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC Capitulo 16"),
          centerTitle: true, // colocando o titulo no centro do appBar
          backgroundColor: Colors.green, // colocando uma cor de fundo no appBar
          actions: [ // na actions vou colocar os botões
            IconButton(
              onPressed: _resetView, 
              icon: const Icon(Icons.refresh)
            )
          ],
        ),
        body: SingleChildScrollView( // tbm usando para resolver o problema do overflow da pagina, e bom usar esse quando e uma unica pagina, o Flexible e bom usar quando e uma lista
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form( // formulario
            key: _formKey, // chave do formulario criado logo acima
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center, // alinhando ao centro, aqui mexe na horizontal
                  crossAxisAlignment: CrossAxisAlignment.stretch, // aqui mexe na vertical, no caso estou alargando ele ate o final da tela
                children:  [ 
                  const Icon(Icons.person_outline, size: 120.0, color: Colors.green,), // icone de pessoa e altura de 120 e cor 
                   TextFormField(
                    keyboardType: TextInputType.number, // informando que o campo sera do tipo numero
                    controller: pesoController,
                    validator: (value) { // validação do formulario
                        if(value == ''){
                          return "Insira seu Peso";
                        }
                    },
                    decoration: const InputDecoration(
                      labelText: "Peso (KG)",
                      labelStyle: TextStyle( color: Colors.green ) , // dando cor ao label do text
                    ),
                    textAlign: TextAlign.center, // alinhando o texto ao centro da tela
                    style: const TextStyle( color: Colors.green, fontSize: 25),
                  ),
                   TextFormField(
                    keyboardType: TextInputType.number, // informando que o campo sera do tipo numero
                    controller: alturaController,
                    validator: (value){ // validação do formulario
                      if(value == ''){
                        return "Insira sua Altura";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle( color: Colors.green ) , // dando cor ao label do text
                    ),
                    textAlign: TextAlign.center, // alinhando o texto ao centro da tela
                    style: const TextStyle( color: Colors.green, fontSize: 25),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10), // precisei colocar em um container para poder aplicar uma margem
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate() ){ // ira verificart se o formulario esta valido, tive que colocar  o "!" no currentState por conta do erro
                          _calcular();
                        }
                      }, 
                      child: const Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 20),),
                      color: Colors.green,
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child:  Text(
                      _result, 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
      
  }
}
