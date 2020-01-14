import 'package:equatable/equatable.dart';

abstract class PeripheralDetailsEvent {
  const PeripheralDetailsEvent();
}

class StartMtuRequestProcess extends PeripheralDetailsEvent {}
class MtuRequestDismissed extends PeripheralDetailsEvent {}
class RequestMtu extends PeripheralDetailsEvent {
  final int mtu;

  RequestMtu(this.mtu);
}
