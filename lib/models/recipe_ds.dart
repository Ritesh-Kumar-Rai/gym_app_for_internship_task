class RecipeStep {
  final int stepNumber;
  final String title;
  final String description;

  RecipeStep({
    required this.stepNumber,
    required this.title,
    required this.description,
  });
}

final List<RecipeStep> pizzaNapoletanaSteps = [
  RecipeStep(
    stepNumber: 1,
    title: "Prepare the Dough",
    description:
        "In a large bowl mix flour, salt, yeast, and water. Knead the mixture until it becomes a smooth and elastic dough.",
  ),
  RecipeStep(
    stepNumber: 2,
    title: "Rest the Dough",
    description:
        "Cover the dough and let it rest at room temperature for 8–12 hours so it can ferment and develop flavor.",
  ),
  RecipeStep(
    stepNumber: 3,
    title: "Divide Dough Balls",
    description:
        "After fermentation, divide the dough into small balls and let them rest for another 1–2 hours.",
  ),
  RecipeStep(
    stepNumber: 4,
    title: "Prepare the Sauce",
    description:
        "Crush fresh tomatoes and add a pinch of salt. Do not cook the sauce for authentic Neapolitan pizza.",
  ),
  RecipeStep(
    stepNumber: 5,
    title: "Shape the Pizza Base",
    description:
        "Stretch the dough ball gently with your hands to form a thin round base. Avoid using a rolling pin.",
  ),
  RecipeStep(
    stepNumber: 6,
    title: "Add Toppings",
    description:
        "Spread the tomato sauce evenly and add fresh mozzarella cheese and basil leaves on top.",
  ),
  RecipeStep(
    stepNumber: 7,
    title: "Bake the Pizza",
    description:
        "Bake the pizza in a very hot oven (around 450–500°C in traditional ovens) for about 60–90 seconds.",
  ),
  RecipeStep(
    stepNumber: 8,
    title: "Finish and Serve",
    description:
        "Drizzle a little olive oil on top and serve immediately while hot.",
  ),
];
