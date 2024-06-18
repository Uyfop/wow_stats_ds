import 'package:wow_stats_ds/models/ability.dart';

abstract class SimulationData {
  Future<List<Ability>> getAbilities();
  Future<double> runSimulation();
}
