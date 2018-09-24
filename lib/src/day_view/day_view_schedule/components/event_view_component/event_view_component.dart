import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import '_day_builder.dart';

typedef Set<ItemWithStartDuration> GetEventsOfDayCallback(
  DateTime day,
);

@immutable
class EventViewComponent implements ScheduleComponent {
  EventViewComponent({
    @required this.getEventsOfDay,
    this.eventsArranger = const ChainsEventsArranger(),
    @required this.eventItemBuilder,
  });

  final GetEventsOfDayCallback getEventsOfDay;
  final EventViewArranger eventsArranger;

  final ItemWithStartDurationBuilder eventItemBuilder;

  @override
  List<Positioned> buildItems({
    @required BuildContext context,
    @required DayViewProperties properties,
    @required SchedulePositioner positioner,
  }) {
    List<Positioned> builtItems = <Positioned>[];
    List<DateTime> days = properties.days;

    for (int i = 0; i < days.length; i++) {
      DateTime day = days[i];
      SchedulingArea area = positioner.getNumberedArea(DayViewArea.dayArea, i);
      Set<ItemWithStartDuration> events = getEventsOfDay(day);

      builtItems.addAll(
        _buildDay(
          context: context,
          events: events,
          area: area,
        ),
      );
    }

    return builtItems;
  }

  List<Positioned> _buildDay({
    @required BuildContext context,
    @required Set<ItemWithStartDuration> events,
    @required SchedulingArea area,
  }) {
    DayBuilder dayBuilder = new DayBuilder(
      context: context,
      events: events,
      area: area,
      eventsArranger: eventsArranger,
      eventItemBuilder: eventItemBuilder,
    );
    return dayBuilder.build();
  }
}
