class NotificationDataModel {
  int? id;
  String? title;
  String? dateTime;
  String? desc;

  NotificationDataModel({this.id, this.title, this.dateTime, this.desc});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime,
      'desc': desc,
    };
  }

  factory NotificationDataModel.fromMap(Map<String, dynamic> map) {
    return NotificationDataModel(
      id: map['id'],
      title: map['title'],
      dateTime: map['dateTime'],
      desc: map['desc'],
    );
  }
}

List<NotificationDataModel> dummyNotificationList = [
  NotificationDataModel(
      id: 1,
      title: 'You have Assign to New Order',
      dateTime: '26/08/2022 10:50 AM',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua consectetur adipiscing elit.'),
  NotificationDataModel(
      id: 2,
      title: 'You have Assign to New Order',
      dateTime: '26/08/2022 10:50 AM',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua consectetur adipiscing elit.'),
  NotificationDataModel(
      id: 3,
      title: 'You have Assign to New Order',
      dateTime: '26/08/2022 10:50 AM',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua consectetur adipiscing elit.'),
  NotificationDataModel(
      id: 4,
      title: 'You have Assign to New Order',
      dateTime: '26/08/2022 10:50 AM',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua consectetur adipiscing elit.'),
  NotificationDataModel(
      id: 5,
      title: 'You have Assign to New Order',
      dateTime: '26/08/2022 10:50 AM',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua consectetur adipiscing elit.'),
  NotificationDataModel(
      id: 6,
      title: 'You have Assign to New Order',
      dateTime: '26/08/2022 10:50 AM',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua consectetur adipiscing elit.')
];
