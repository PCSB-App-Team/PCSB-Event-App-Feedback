import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
class Body extends  StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}
class _DownloadPageState extends State<Body> {
  String downloadMessage = 'Initialising...';
  bool _isDownloading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Download Feedback Form by Clicking on the Download Button",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Download",
              icon: Icon(Icons.file_download),
              press: () async{
                setState(() {
                  _isDownloading = !_isDownloading;
                });
                var dir = await getExternalStorageDirectory();
                Dio dio = Dio();
                dio.download(
                    'https://sample-videos.com/img/Sample-jpg-image-5mb.jpg',
                    '${dir.path}/sample.jpg',
                    onReceiveProgress: (actualbytes, totalbytes) {
                      var percentage = actualbytes / totalbytes * 100;
                      setState(() {
                        downloadMessage = 'Downloading... ${percentage.floor()} %';
                      });
                    });
              },
            ),
            SizedBox(height: 8),
            Text(downloadMessage ?? ''),
          ],
        ),
      ),
    );
  }
}
