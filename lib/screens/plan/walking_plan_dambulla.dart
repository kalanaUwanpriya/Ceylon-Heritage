import 'package:flutter/material.dart';

import '../../data/historical_places_data.dart';
import 'walking_plan_page.dart';

/// Customized Walking Plan screen entry point for Dambulla.
/// Reuses the existing [WalkingPlanPage] pre-bound to the Dambulla destination.
class WalkingPlanDambullaPage extends StatelessWidget {
  const WalkingPlanDambullaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WalkingPlanPage(destination: dambulla);
  }
}
