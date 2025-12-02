extension PrettyNum on num {
  get prettyNumber {
    if (this <= 9) {
      return "0$this";
    }
    return this;
  }
}

extension DateTimeFormatter on DateTime {
  String toHoursMinutes() {
    int hour = this.hour;
    int minute = this.minute;
    return "${hour.prettyNumber}:${minute.prettyNumber} ${(hour > 12 ? "AM" : "PM")}";
  }
}
