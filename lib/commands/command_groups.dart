import 'package:flutter/foundation.dart';
import 'package:pathplanner/commands/command.dart';

abstract class CommandGroup extends Command {
  List<Command> commands;

  CommandGroup({required super.type, required this.commands});

  CommandGroup.fromDataJson(
    Map<String, dynamic> json, {
    required super.type,
    String? condition,
  })  : condition = condition ?? json['condition'] as String?,
        commands = [
          for (Map<String, dynamic> cmdJson in (json['commands'] ?? []))
            Command.fromJson(cmdJson),
        ];

  String? condition;


  @override
  Map<String, dynamic> dataToJson() {
    return {
      'commands': [
        for (Command command in commands) command.toJson(),
      ],
    };
  }

  static List<Command> cloneCommandsList(List<Command> commands) {
    return [
      for (Command command in commands) command.clone(),
    ];
  }
}

class SequentialCommandGroup extends CommandGroup {
  SequentialCommandGroup({required super.commands}) : super(type: 'sequential');

  SequentialCommandGroup.fromDataJson(super.json)
      : super.fromDataJson(type: 'sequential');

  @override
  Command clone() {
    return SequentialCommandGroup(
        commands: CommandGroup.cloneCommandsList(commands));
  }

  @override
  bool operator ==(Object other) =>
      other is SequentialCommandGroup &&
      other.runtimeType == runtimeType &&
      listEquals(other.commands, commands);

  @override
  int get hashCode => Object.hash(type, commands);
}

class ParallelCommandGroup extends CommandGroup {
  ParallelCommandGroup({required super.commands}) : super(type: 'parallel');

  ParallelCommandGroup.fromDataJson(super.json)
      : super.fromDataJson(type: 'parallel');

  @override
  Command clone() {
    return ParallelCommandGroup(
        commands: CommandGroup.cloneCommandsList(commands));
  }

  @override
  bool operator ==(Object other) =>
      other is ParallelCommandGroup &&
      other.runtimeType == runtimeType &&
      listEquals(other.commands, commands);

  @override
  int get hashCode => Object.hash(type, commands);
}

class RaceCommandGroup extends CommandGroup {
  RaceCommandGroup({required super.commands}) : super(type: 'race');

  RaceCommandGroup.fromDataJson(super.json) : super.fromDataJson(type: 'race');

  @override
  Command clone() {
    return RaceCommandGroup(commands: CommandGroup.cloneCommandsList(commands));
  }

  @override
  bool operator ==(Object other) =>
      other is RaceCommandGroup &&
      other.runtimeType == runtimeType &&
      listEquals(other.commands, commands);

  @override
  int get hashCode => Object.hash(type, commands);
}

class DeadlineCommandGroup extends CommandGroup {
  DeadlineCommandGroup({required super.commands}) : super(type: 'deadline');

  DeadlineCommandGroup.fromDataJson(super.json)
      : super.fromDataJson(type: 'deadline');

  @override
  Command clone() {
    return DeadlineCommandGroup(
        commands: CommandGroup.cloneCommandsList(commands));
  }

  @override
  bool operator ==(Object other) =>
      other is DeadlineCommandGroup &&
      other.runtimeType == runtimeType &&
      listEquals(other.commands, commands);

  @override
  int get hashCode => Object.hash(type, commands);
}
