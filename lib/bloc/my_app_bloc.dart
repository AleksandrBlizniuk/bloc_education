import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_app_event.dart';
part 'my_app_state.dart';

class MyAppBloc {
  MyAppBloc() {
    _counterEventController.stream.listen((event) { //Function listen called every time when stream receive a new value
      _counterController.sink.add(count++); //because it's very simple sample here no states but just count++ instead.
    });
    _counterController.sink.add(0);
  }

  int count = 1;
  final StreamController<int> _counterController = StreamController<int>(); //output Stream
  final StreamController<void> _counterEventController = StreamController<void>(); //input Stream

  Stream<int> get counterStream => _counterController.stream; // _counterController and _counterEventController private fields, that's why here is getters.
// for communicate with UI. UI needs access to stream and sink of stream controllers.
  Sink<void> get eventSink => _counterEventController.sink;

  void dispose(){ //needs to close streams when they don't use anymore.
    _counterController.close();
    _counterEventController.close();
  }
}
