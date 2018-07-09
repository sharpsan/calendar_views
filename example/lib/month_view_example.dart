import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/month_view.dart';

import 'weekday_drop_down_button.dart';

class MonthViewExample extends StatefulWidget {
  @override
  _MonthViewExampleState createState() => new _MonthViewExampleState();
}

class _MonthViewExampleState extends State<MonthViewExample> {
  DateTime _month;
  int _firstWeekday;

  bool _showExtendedDaysBefore;
  bool _showExtendedDaysAfter;

  @override
  void initState() {
    super.initState();

    _month = new DateTime.now();
    _firstWeekday = DateTime.monday;

    _showExtendedDaysBefore = true;
    _showExtendedDaysAfter = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MonthView Example"),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            child: new Text(
              "${_month.year}.${_month.month.toString().padLeft(2, "0")}",
            ),
          ),
          new Divider(
            height: 0.0,
          ),
          new Expanded(
            child: new Container(
              color: Colors.green.shade200,
              child: new MonthView(
                showExtendedDaysBefore: _showExtendedDaysBefore,
                showExtendedDaysAfter: _showExtendedDaysAfter,
                month: _month,
                firstWeekday: _firstWeekday,
                dayOfMonthBuilder: _dayOfMonthBuilder,
              ),
            ),
          ),
          new Divider(),
          new Expanded(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text("First Day of Month"),
                    trailing: new WeekdayDropDownButton(
                        value: _firstWeekday,
                        onChanged: (value) {
                          setState(() {
                            _firstWeekday = value;
                          });
                        }),
                  ),
                  new Divider(),
                  new CheckboxListTile(
                    title: new Text("Show Extended Days Before"),
                    value: _showExtendedDaysBefore,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysBefore = value;
                      });
                    },
                  ),
                  new Divider(),
                  new CheckboxListTile(
                    title: new Text("Show Extended Days After"),
                    value: _showExtendedDaysAfter,
                    onChanged: (value) {
                      setState(() {
                        _showExtendedDaysAfter = value;
                      });
                    },
                  ),
                  new Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayOfMonthBuilder(
    BuildContext context,
    DayOfMonthProperties properties,
  ) {
    return new Center(
      child: new Text(
        "${properties.date.day}",
        style: new TextStyle(
          fontWeight:
              properties.isExtended ? FontWeight.normal : FontWeight.bold,
        ),
      ),
    );
  }
}
