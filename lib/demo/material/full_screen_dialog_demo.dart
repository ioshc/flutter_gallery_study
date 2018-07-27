import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class _TimeFormField extends StatelessWidget {
  const _TimeFormField({this.labelText, this.helperText, this.timeText, this.onTap});

  final String labelText;
  final String helperText;
  final String timeText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onTap,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
          helperText: helperText,
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(timeText),
            ),
            new Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    this.labelText,
    this.helperText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
  });

  final String labelText;
  final String helperText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 3,
          child: new _TimeFormField(
            labelText: labelText,
            helperText: helperText,
            timeText: new DateFormat('EEE, MMM d yyyy').format(selectedDate),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: selectedDate.subtract(const Duration(days: 30)),
                lastDate: selectedDate.add(const Duration(days: 30)),
              ).then((DateTime value) {
                if (value != null) {
                  selectDate(value);
                }
              });
            },
          ),
        ),
        new Padding(padding: const EdgeInsets.only(left: 10.0)),
        new Expanded(
          flex: 1,
          child: new _TimeFormField(
            timeText: selectedTime.format(context),
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: selectedTime,
              ).then((TimeOfDay value) {
                if (value != null) {
                  selectTime(value);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}

class FullScreenDialogDemo extends StatefulWidget {
  @override
  State createState() {
    return new _FullScreenDialogDemoState();
  }
}

class _FullScreenDialogDemoState extends State<FullScreenDialogDemo> {
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = TimeOfDay.now();
  DateTime _toDate = DateTime(2018, 8, 4);
  TimeOfDay _toTime = TimeOfDay.now();
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Event Name TBD'),
        leading: new IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, DismissDialogAction.cancel);
          },
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.pop(context, DismissDialogAction.save);
            },
            child: const Text(
              'SAVE',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          child: new ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Event Name',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Location',
                  hintText: 'where is the event',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              new _Dropdown(
                labelText: 'From',
                selectedDate: _fromDate,
                selectedTime: _fromTime,
                selectDate: (DateTime value) {
                  setState(() {
                    _fromDate = value;
                  });
                },
                selectTime: (TimeOfDay value) {
                  setState(() {
                    _fromTime = value;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              new _Dropdown(
                labelText: 'To',
                selectedDate: _toDate,
                selectedTime: _toTime,
                selectDate: (DateTime value) {
                  setState(() {
                    _toDate = value;
                  });
                },
                selectTime: (TimeOfDay value) {
                  setState(() {
                    _toTime = value;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              new InputDecorator(
                decoration: new InputDecoration(),
                child: new Row(
                  children: <Widget>[
                    new Checkbox(value: _checked, onChanged: (value){
                      setState(() {
                        _checked = !_checked;
                      });
                    }),
                    const Text('All day'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
