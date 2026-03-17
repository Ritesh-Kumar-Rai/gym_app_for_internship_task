import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'premium_water_bowl.dart';
import 'package:confetti/confetti.dart'; // add confetti package

class HydrationCardPremium extends StatefulWidget {
  const HydrationCardPremium({super.key});

  @override
  State<HydrationCardPremium> createState() => _HydrationCardPremiumState();
}

class _HydrationCardPremiumState extends State<HydrationCardPremium> {
  int consumed = 250;
  int target = 1500;
  final int step = 250;

  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  double get progress => target == 0 ? 0 : consumed / target;

  bool get targetReached => progress >= 1.0;

  void addWater() {
    HapticFeedback.lightImpact();
    setState(() {
      consumed += step;
      if (consumed > target) consumed = target;
    });
    if (targetReached) confettiController.play();
  }

  void removeWater() {
    HapticFeedback.lightImpact();
    setState(() {
      consumed -= step;
      if (consumed < 0) consumed = 0;
    });
  }

  Future<void> setTarget() async {
    final controller = TextEditingController();
    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Set Daily Target (ml)"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Example: 2000"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              Navigator.pop(dialogContext, value);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (result != null && result > 0) {
      setState(() {
        target = result;
        if (consumed > target) consumed = target;
      });
    }
  }

  Color getWaterColor() {
    if (progress >= 1) return Colors.green;
    return Colors.blue;
  }

  Color getPercentageColor() {
    if (progress >= 1) return Colors.green;
    if (progress < 0.3) return Colors.red;
    return Colors.blue;
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Confetti
        ConfettiWidget(
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          emissionFrequency: 0.05,
          numberOfParticles: 30,
          maxBlastForce: 20,
          minBlastForce: 10,
          colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(16),
          width: 320,
          decoration: BoxDecoration(
            color: targetReached ? Colors.green.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black12)],
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 3,
            ), // glass border
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Today's Water Consumption 💧",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "You have ${target - consumed}ml remained water to reach to your goal😁",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              WaterBowlPremium(
                progress: progress,
                color: getWaterColor(),
                text:
                    "$consumed ml / ${target ~/ 1000}.${(target % 1000) ~/ 100}L",
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(progress * 100).toStringAsFixed(0)}% ",
                    style: TextStyle(
                      color: getPercentageColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Hydrated",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    iconSize: 36,
                    onPressed: removeWater,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    iconSize: 36,
                    onPressed: addWater,
                  ),
                  OutlinedButton(
                    onPressed: setTarget,
                    child: const Text("Set Target"),
                  ),
                ],
              ),
              if (targetReached)
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "🎉 Target Reached!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
