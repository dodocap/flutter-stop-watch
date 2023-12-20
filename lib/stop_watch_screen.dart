import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  bool _isRunning = false;
  int _time = 0;
  final List<String> _lapTimeList = [];

  void _onClickPlayPause() {
    setState(() {
      _isRunning = !_isRunning;
    });

    _isRunning ? _start() : _pause();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _onClickReset() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _lapTimeList.clear();
      _time = 0;
    });
  }

  void _onClickRecordLapTime(String time) {
    _lapTimeList.insert(0, '${_lapTimeList.length + 1}등 $time');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('스톱워치'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$sec',
                style: const TextStyle(fontSize: 50),
              ),
              Text(
                hundredth,
              ),
            ],
          ),
          SizedBox(
            width: 100,
            height: 200,
            child: ListView(
              children: _lapTimeList.map((e) => Center(child: Text(e))).toList(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: _onClickReset,
                child: const Icon(
                  Icons.refresh,
                  color: Colors.orange,
                ),
              ),
              FloatingActionButton(
                onPressed: _onClickPlayPause,
                child: Icon(
                  _isRunning ? Icons.pause : Icons.play_arrow,
                  color: Colors.blue,
                ),
              ),
              FloatingActionButton(
                onPressed: () => _onClickRecordLapTime('$sec.$hundredth'),
                child: const Icon(
                  Icons.add,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
