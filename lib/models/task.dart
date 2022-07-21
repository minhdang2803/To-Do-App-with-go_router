enum ChipSelection { normal, important, urgent }

class Task {
  final int? id;
  final String chipLabel;
  final int backgroundColor;
  final String? title;
  final String? description;
  final String? contextInside;
  Task(
      {required this.backgroundColor,
      required this.chipLabel,
      this.title,
      this.contextInside,
      this.description,
      this.id});

  factory Task.fromJSON(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      chipLabel: json['chipLabel'],
      backgroundColor: json['backgroundColor'],
      title: json['title'],
      description: json['description'],
      contextInside: json['contextInside'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'chipLabel': chipLabel,
      'backgroundColor': backgroundColor,
      'title': title,
      'description': description,
      'contextInside': contextInside,
    };
  }
}
