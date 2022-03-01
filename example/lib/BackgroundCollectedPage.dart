import 'package:flutter/material.dart';

import 'dart:async';
import './BackgroundCollectingTask.dart';

import 'dart:developer';

class BackgroundCollectedPage extends StatefulWidget {
  @override
  State<BackgroundCollectedPage> createState() =>
      _BackgroundCollectedPageState();
}

class _BackgroundCollectedPageState extends State<BackgroundCollectedPage> {
  String _currentText = 'data';

  late Timer _updateData;

  final BackgroundCollectingTask task = BackgroundCollectingTask();

  @override
  void initState() {
    super.initState();

    _updateData = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentText = task.currentValue;
        log('current Value: ' + task.stringSamples.last);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Collected data'),
          actions: <Widget>[
            // Progress circle
            (task.inProgress
                ? FittedBox(
                    child: Container(
                        margin: new EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))))
                : Container(/* Dummy */)),
            // Start/stop buttons
            (task.inProgress
                ? IconButton(icon: Icon(Icons.pause), onPressed: task.pause)
                : IconButton(
                    icon: Icon(Icons.play_arrow), onPressed: task.resume)),
          ],
        ),
        body: Container(child: Text(_currentText)));
  }
}
