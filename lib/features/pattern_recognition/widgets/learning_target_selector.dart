import 'package:flutter/material.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';

class LearningTargetSelector<T> extends StatelessWidget {
  final T selection;
  final ValueChanged<T> onSelectionChanged;
  final List<ButtonSegment<T>> segments;

  const LearningTargetSelector({
    required this.selection,
    required this.onSelectionChanged,
    required this.segments,
    super.key,
  }) : assert(segments.length > 0);

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: SizedBox(
        height: 32.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: () {
            final children = <Widget>[];
            for (int i = 0; i < segments.length; i++) {
              final segment = segments[i];
              final isSelected = segment.value == selection;

              children.add(
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (!isSelected) {
                        onSelectionChanged(segment.value);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        (segment.label as Text).data!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.grey.shade800 : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
              if (i < segments.length - 1) {
                children.add(
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    thickness: 1.2,
                  ),
                );
              }
            }
            return children;
          }(),
        ),
      ),
    );
  }
}
