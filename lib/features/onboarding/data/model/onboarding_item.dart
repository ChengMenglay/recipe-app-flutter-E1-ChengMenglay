
class OnboardingItem{
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

final onboardingItems = [
  OnboardingItem(
    image: "assets/Illustrations/onboarding_1.png",
    title: "Welcome to Our App",
    description: "This is the first onboarding screen.",
  ),
  OnboardingItem(
    image: "assets/Illustrations/onboarding_2.png",
    title: "Track Your Activity",
    description: "See useful insights every day.",
  ),
  OnboardingItem(
    image: "assets/Illustrations/onboarding_3.png",
    title: "Get Started!",
    description: "You are ready to begin your journey.",
  ),
];