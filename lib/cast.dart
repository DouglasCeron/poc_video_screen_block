import 'package:cast/cast.dart';
import 'package:flutter/material.dart';

class Cast extends StatefulWidget {
  const Cast({Key? key}) : super(key: key);

  @override
  _CastState createState() => _CastState();
}

class _CastState extends State<Cast> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CastDevice>>(
      future: CastDiscoveryService().search(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error.toString()}',
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.isEmpty) {
          return Column(
            children: [
              Center(
                child: Text(
                  'No Chromecast founded',
                ),
              ),
            ],
          );
        }

        return Column(
          children: snapshot.data!.map((device) {
            return ListTile(
              title: Text(device.name),
              onTap: () {
                _connectToYourApp(context, device);
              },
            );
          }).toList(),
        );
      },
    );
  }
}

Future<void> _connectToYourApp(BuildContext context, CastDevice object) async {
  final session = await CastSessionManager().startSession(object);

  session.stateStream.listen((state) {
    if (state == CastSessionState.connected) {
      _sendMessage(session);
    }
  });

  session.messageStream.listen((message) {
    print('receive message: $message');
  });

  session.sendMessage(CastSession.kNamespaceReceiver, {
    'type': 'LAUNCH',
    'appId': 'YouTube', // set the appId of your app here
  });
}

void _sendMessage(CastSession session) {
  session.sendMessage('urn:x-cast:namespace-of-the-app', {
    'type': 'sample',
  });
}
