import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({this.text, this.label, this.onPressed});

  final String text;
  final String label;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: label,
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(text),
            ),
            new Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    this.date,
    this.label,
    this.time,
    this.selectDate,
    this.selectTime
  });

  final DateTime date;
  final TimeOfDay time;
  final String label;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != date) {
      selectDate(picked);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: time);
    if (picked != null && picked != time) {
      selectTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            // ignore: undefined_class
            text: new DateFormat.yMMMd().format(date),
            label: label,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        new Padding(padding: const EdgeInsets.only(left: 10.0)),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            text: time.format(context),
            onPressed: () {
              _selectTime(context);
            },
          ),
        )
      ],
    );
  }
}

class DateAndTimePickerDemo extends StatefulWidget {
  static const String routeName = "material/date-time-picker";

  @override
  State createState() {
    return new _DateAndTimePickerDemoState();
  }
}

class _DateAndTimePickerDemoState extends State<DateAndTimePickerDemo> {
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 30);
  DateTime _toDate = new DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 30);
  final List<String> _allActivities = <String>[
    'hiking',
    'swimming',
    'boating',
    'fishing'
  ];
  String _activity = 'fishing';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Date and time pickers'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new DropdownButtonHideUnderline(
          child: new ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event name',
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.display1,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: UnderlineInputBorder(),
                ),
                style: Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 20.0),
              ),
              new _DateTimePicker(
                date: _fromDate,
                time: _fromTime,
                label: 'From',
                selectDate: (DateTime newDate) {
                  setState(() {
                    _fromDate = newDate;
                  });
                },
                selectTime: (TimeOfDay newTime) {
                  setState(() {
                    _fromTime = newTime;
                  });
                },
              ),
              new _DateTimePicker(
                date: _toDate,
                time: _toTime,
                label: 'To',
                selectDate: (DateTime newDate) {
                  setState(() {
                    _toDate = newDate;
                  });
                },
                selectTime: (TimeOfDay newTime) {
                  setState(() {
                    _toTime = newTime;
                  });
                },
              ),
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Activitys',
                  hintText: 'Choose an activity',
                ),
                isEmpty: _activity == null,
                child: new DropdownButton<String>(
                  value: _activity,
                  isDense: true,
                  items: _allActivities.map((String activity) {
                    return new DropdownMenuItem<String>(
                      child: new Text(activity),
                      value: activity,
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _activity = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
