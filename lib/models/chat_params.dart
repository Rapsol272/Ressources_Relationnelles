import 'package:flutter_firebase/models/user.dart';

class ChatParams{
  final String uid;
  final AppUserData peer;

  ChatParams(this.uid, this.peer);

  String getChatGroupId() {
    if (uid.hashCode <= peer.uid.hashCode) {
      return '$uid-${peer.uid}';
    } else {
      return '${peer.uid}-$uid';
    }
  }
}