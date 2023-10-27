// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:just_audio/just_audio.dart';

// class NotificationHelper {
//   static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   static init() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     var android = const AndroidInitializationSettings('app_icon');
//     var iOS = const IOSInitializationSettings();
//     var initSettings = InitializationSettings(android: android, iOS: iOS);

//     flutterLocalNotificationsPlugin.initialize(initSettings,
//         onSelectNotification: (data) {
//       onSelectNotification(data ?? '');
//       return;
//     });
//   }

//   static Future onSelectNotification(String payload) async {
//     // debugPrint("payload : $payload");
//     // showDialog(
//     //   context: context,
//     //   builder: (_) {
//     //     return AlertDialog(
//     //       title: Text("PayLoad"),
//     //       content: Text("Payload : $payload"),
//     //     );
//     //   },
//     // );
//   }

//   static Future showNotificationWithDefaultSound(
//       {required String title,
//       required String description,
//       String? uuid,
//       bool? canPlayAudio = false}) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         // sound: RawResourceAndroidNotificationSound('alert'),
//         // playSound: true,
//         uuid ?? '0001',
//         'Notification',
//         // 'Show notification to driver',
//         icon: "app_icon",
//         importance: Importance.max,
//         styleInformation: BigTextStyleInformation(description),
//         showWhen: true,
//         enableVibration: true,
//         enableLights: true,
//         priority: Priority.high);
//     var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       1,
//       title,
//       description,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }

//   // static playAudio() async {
//   //   // AudioPlayer player = AudioPlayer();
//   //   String audioasset = "Assets/Audio/alert.mp3";
//   //   // ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
//   //   // Uint8List audiobytes =
//   //   //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//   //   // player.setVolume(1);
//   //   // int result = await player.playBytes(audiobytes);

//   //   await player.setAsset(audioasset);
//   //   // setAudioSource(AudioSource.uri(Uri.parse('asset:/your_file.mp3')),
//   //   // initialPosition: Duration.zero, preload: true);
//   //   await player.play();
//   // }
// }
