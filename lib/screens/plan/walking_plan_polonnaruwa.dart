import 'package:flutter/material.dart';

import '../../data/historical_places_data.dart';
import 'walking_plan_page.dart';

/// Customized Walking Plan screen entry point for Polonnaruwa.
/// Reuses the existing [WalkingPlanPage] pre-bound to the Polonnaruwa destination.
class WalkingPlanPolonnaruwaPage extends StatelessWidget {
  const WalkingPlanPolonnaruwaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WalkingPlanPage(destination: polonnaruwa);
  }
}
