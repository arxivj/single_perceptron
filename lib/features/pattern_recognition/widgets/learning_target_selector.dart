import 'package:flutter/material.dart';
import 'package:single_perceptron/features/shared/widgets/neu_container.dart';

class LearningTargetSelector<T> extends StatefulWidget {
  final T initialSelection;
  final ValueChanged<T> onSelectionChanged;
  final List<ButtonSegment<T>> segments;

  const LearningTargetSelector({
    required this.initialSelection,
    required this.onSelectionChanged,
    required this.segments,
    super.key,
  }) : assert(segments.length > 0);

  @override
  State<LearningTargetSelector<T>> createState() => _LearningTargetSelectorState<T>();
}

class _LearningTargetSelectorState<T> extends State<LearningTargetSelector<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection;
  }

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
            for (int i = 0; i < widget.segments.length; i++) {
              final segment = widget.segments[i];
              final isSelected = segment.value == _selected;

              children.add(
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (!isSelected) {
                      setState(() {
                        _selected = segment.value;
                      });
                      widget.onSelectionChanged(_selected);
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
              );
              if (i < widget.segments.length - 1) {
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
