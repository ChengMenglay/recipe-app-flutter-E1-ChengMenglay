import 'package:flutter/material.dart';
import 'package:lab_3/features/explore/presentation/widgets/explore_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const ExploreWidget());
  }
}
