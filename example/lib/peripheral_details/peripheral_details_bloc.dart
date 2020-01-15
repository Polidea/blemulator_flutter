import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_state.dart';
import 'package:bloc/bloc.dart';
import 'package:fimber/fimber.dart';
import './bloc.dart';

class PeripheralDetailsBloc
    extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  BleAdapter _bleAdapter;
  final BlePeripheral _chosenPeripheral;

  PeripheralDetailsBloc(this._bleAdapter, this._chosenPeripheral) {
    listen((state) {
      Fimber.d("state: ${state}");
    },
    onDone: () {
      Fimber.d("done");
    }
    );
  }

  @override
  PeripheralDetailsState get initialState =>
      PeripheralDetailsState(peripheral: _chosenPeripheral, mtuRequestState: MtuRequestState());

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {
    Fimber.d("New event ${event.toString()}");
    if (event is StartMtuRequestProcess) {
      yield PeripheralDetailsState.clone(state, mtuRequestState: MtuRequestState.clone(state.mtuRequestState, showMtuDialog: true));
    } else if (event is MtuRequestDismissed) {
      yield PeripheralDetailsState.clone(state, mtuRequestState: MtuRequestState.clone(state.mtuRequestState, showMtuDialog: false));
    } else if (event is RequestMtu) {
      yield* requestMtu(event.mtu);
    }

  }

  @override
  void onTransition(Transition<PeripheralDetailsEvent, PeripheralDetailsState> transition) {
    Fimber.d('state[${transition.currentState}] \t=>'
        'event[${transition.event.toString()}] \t=>'
        'state[${transition.nextState}]');
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    Fimber.e("Some error", ex: error, stacktrace: stacktrace);
  }

  @override
  Future<void> close() {
    Fimber.d("close");
    return super.close();
  }

  Stream<PeripheralDetailsState> requestMtu(int mtu) async * {
    yield PeripheralDetailsState.clone(state,
        mtuRequestState: MtuRequestState.clone(state.mtuRequestState, showMtuDialog: false, status: MtuRequestStatus.ongoing)
    );

    try {
      try {
        await _bleAdapter.connect(state.peripheral.id);
      } catch (exception) {
        Fimber.e("connection problem", ex: exception);
      }
      int negotiatedMtu = await _bleAdapter.requestMtu(
          state.peripheral.id, mtu);
      BlePeripheral peripheral = BlePeripheral(
          state.peripheral.name,
          state.peripheral.id,
          state.peripheral.rssi,
          state.peripheral.isConnected,
          state.peripheral.category,
          negotiatedMtu
      );
      yield PeripheralDetailsState.clone(state,
          peripheral: peripheral,
          mtuRequestState: MtuRequestState.clone(state.mtuRequestState, status: MtuRequestStatus.success)
      );
      yield PeripheralDetailsState.clone(state,
          peripheral: peripheral,
          mtuRequestState: MtuRequestState.clone(state.mtuRequestState, status: MtuRequestStatus.idle)
      );
    } catch(exception) {
      Fimber.e("MTU request fail", ex: exception);
      yield PeripheralDetailsState.clone(state,
          mtuRequestState: MtuRequestState.clone(state.mtuRequestState, status: MtuRequestStatus.error)
      );
      yield PeripheralDetailsState.clone(state,
          mtuRequestState: MtuRequestState.clone(state.mtuRequestState, status: MtuRequestStatus.idle)
      );
    }
  }
}
