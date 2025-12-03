import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(image, height: 250),
        const Spacer(),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
