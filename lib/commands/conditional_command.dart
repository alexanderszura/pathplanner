import 'package:flutter/foundation.dart';
import 'package:pathplanner/commands/command.dart';
import 'package:pathplanner/commands/command_groups.dart';

class ConditionalCommandGroup extends CommandGroup {
  @override
  String? condition;

  ConditionalCommandGroup({this.condition, required super.commands})
      : super(type: 'conditional');

  ConditionalCommandGroup.fromDataJson(super.json)
      : condition = json['condition'] as String?,
        super.fromDataJson(type: 'conditional');

  @override
  Map<String, dynamic> dataToJson() {
    final json = super.dataToJson();

    // Very Very Bad coding but it works
    try {
      json['condition'] = json['commands'][0]['data']['condition'];
      json['commands'].removeAt(0);
    } on Exception catch (_) {}

    return json;
  }
  @override
  Command clone() {
    return ConditionalCommandGroup(
      condition: condition,
      commands: CommandGroup.cloneCommandsList(commands),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ConditionalCommandGroup &&
      other.runtimeType == runtimeType &&
      other.condition == condition &&
      listEquals(other.commands, commands);

  @override
  int get hashCode => Object.hash(type, condition, commands);
}
