import 'package:flutter/material.dart';
import 'package:pathplanner/commands/named_condition.dart';
import 'package:pathplanner/widgets/editor/tree_widgets/commands/duplicate_command_button.dart';
import 'package:undo/undo.dart';

class NamedConditionWidget extends StatelessWidget {
  final NamedCondition command;
  final VoidCallback? onUpdated;
  final VoidCallback? onRemoved;
  final ChangeStack undoStack;
  final VoidCallback? onDuplicateCommand;

  const NamedConditionWidget({
    super.key,
    required this.command,
    this.onUpdated,
    this.onRemoved,
    required this.undoStack,
    this.onDuplicateCommand,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              undoStack.add(Change(
                command.condition,
                () {
                  command.condition = value as String?;
                  onUpdated?.call();
                },
                (oldValue) {
                  command.condition = oldValue;
                  onUpdated?.call();
                },
              ));
            },
          ),
        ),
        DuplicateCommandButton(
          onPressed: onDuplicateCommand,
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: 'Remove Command',
          waitDuration: const Duration(milliseconds: 500),
          child: IconButton(
            onPressed: onRemoved,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            icon: Icon(Icons.close, color: colorScheme.error),
          ),
        ),
      ],
    );
  }
}
