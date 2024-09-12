import 'package:pathplanner/commands/command.dart';

class NamedCondition extends Command {
  String? condition;

  NamedCondition({this.condition = 'null'}) : super(type: 'condition');

  NamedCondition.fromDataJson(Map<String, dynamic> json)
      : this(condition: json['condition'] ?? 'null');

  @override
  Map<String, dynamic> dataToJson() {
    return {
      'condition': condition,
    };
  }

  @override
  Command clone() {
    return NamedCondition(condition: condition);
  }

  @override
  bool operator ==(Object other) =>
      other is NamedCondition &&
      other.runtimeType == runtimeType &&
      other.condition == condition;

  @override
  int get hashCode => Object.hash(type, condition);
}
