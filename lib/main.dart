import 'package:flutter/material.dart';
import 'package:flutter_api/models/cepModel.dart';
import 'package:flutter_api/myhomepage_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc bloc = MyHomePageBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (value){bloc.input.add(value);},
              decoration: InputDecoration(
                hintText: 'Digite seu CEP',
                border: OutlineInputBorder()
              ),
            ),
            Center(
              child: StreamBuilder<CepData>(
                stream: bloc.output,
                initialData: CepData(bairro: ""),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Text("Erro ao encontrar");
                  }
                  CepData cep = snapshot.data;
                  return Text("Bairro: ${cep.bairro}");
                },
              ),
            )
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
