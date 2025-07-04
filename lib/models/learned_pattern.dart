enum LearningTarget { positive, negative }

class LearnedPattern {
  final List<bool> ledStates;

  final LearningTarget target;

  LearnedPattern({required this.ledStates, required this.target});
}
