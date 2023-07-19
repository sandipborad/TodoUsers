
class User {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  User({this.userId, this.id, this.title, this.completed});

  User.fromJson(Map<String, dynamic> json) {
    try{
      userId = json['userId'];
      id = json['id'];
      title = json['title'];
      completed = json['completed'];
    }catch(e,stacktrace){
      print('Stack trace ${stacktrace.toString()}');
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['completed'] = completed;
    return data;
  }
}