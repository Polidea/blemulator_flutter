
import 'package:blemulator/src/internal.dart';
import 'package:mockito/mockito.dart';


class DartToPlatformBridgeMock extends Mock implements DartToPlatformBridge {}

class SimulationManagerFactory {
  SimulationManager create() =>  SimulationManager(DartToPlatformBridgeMock());
}