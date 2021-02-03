import 'dart:async';

import 'package:dio/dio.dart';

import 'models/cepModel.dart';

class MyHomePageBloc {

  // ignore: close_sinks
  final StreamController<String> _streamController = StreamController<String>();

  Sink<String> get input => _streamController.sink;

  Stream get output => _streamController.stream
      .where((cep) => cep.isNotEmpty && cep.length > 7) //você pode adicionar condições antes de chamar os dados
      .asyncMap((cep) => _searchCep(cep));//receber os dados já mapeando



  // ignore: missing_return
  Future<CepData> _searchCep(String number) async{
      try {
        Response response = await Dio().get("https://viacep.com.br/ws/$number/json/");
        if(response.statusCode == 200 && response.data != null){
          return CepData.fromJson(response.data);
        }
      }catch(e){
        print(e);
      }
  }

}