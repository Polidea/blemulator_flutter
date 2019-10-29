



class Communicator {

  static Function _disconnect;

  static register(Function disconnect) {
    print('[com]register---------------${_disconnect}');
    print('[com]register2---------------${disconnect}');
    _disconnect = disconnect;
  }

  static disconnect() {
    print('[com]disconnect---------------${_disconnect}');
    _disconnect();
  }
}

//Communicator communicator = Communicator();