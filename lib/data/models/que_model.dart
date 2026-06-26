class QueModel {
  final String id;
  final String title;
  final String desc;
  final List<Que> ques;

  QueModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.ques,
  });
  factory QueModel.fromJson(String id, Map<String, dynamic> json) {
    return QueModel(
      id: id,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      ques: (json['ques'] as List<dynamic>?)
              ?.map((e) => Que.fromJson(e))
              .toList() ?? [],
    );
  }
}

class Que {
  final String id;
  final String text;
  final List<String> opts;
  Que({
    required this.id,
    required this.text,
    required this.opts,
  });
  factory Que.fromJson(Map<String, dynamic> json) {
    return Que(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      opts: List<String>.from(json['opts'] ?? []),
    );
  }
}
