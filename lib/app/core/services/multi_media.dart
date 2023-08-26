import 'package:url_launcher/url_launcher.dart';

class MultiMedia {
  Future<void> goToFaceBook({required String url}) async {
    final Uri openUrlFace = Uri.parse("fb://facewebmodal/f?href=$url");

    final Uri openUrlBrowser = Uri.parse(url);
    if (await canLaunchUrl(openUrlFace)) {
      await launchUrl(openUrlFace,
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      await launchUrl(openUrlBrowser,
          mode: LaunchMode.externalNonBrowserApplication);
    }

    // if(await canLaunch(openUrlFace) )
    //   {
    //      await  launch(openUrlFace,forceSafariVC: false,universalLinksOnly: true);
    //   }
    // else{
    //   throw 'Could not launch$openUrlFace ';
    // }
  }

  Future<void> goToInstagram({required String url}) async {
    final Uri openUrlInstagram = Uri.parse("fb://facewebmodal/f?href=$url");

    final Uri openUrlBrowser = Uri.parse(url);
    if (await canLaunchUrl(openUrlBrowser)) {
      await launchUrl(openUrlBrowser,
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      await launchUrl(openUrlBrowser,
          mode: LaunchMode.externalNonBrowserApplication);
    }
  }

  void goToEmail({required String email}) async {
    if (!await launch(
      'mailto:$email?subject=${Uri.encodeFull('koko')}&body=${Uri.encodeFull('bad')}',
      forceSafariVC: false, //ios
      forceWebView: false, //android
      enableJavaScript: false, //android
    )) ;
  }

  void goToEmail2({required String email}) async {
    final Uri emailUrl = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': 'hello مرحبا'});
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    } else {
      throw 'Could not launch$emailUrl';
    }
  }

  Future<void> goToWhats({required String phone}) async {
    String url = "whatsapp://send?phone=+963$phone";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch$url ';
    }
  }

  Future<void> goToTel({required String phone}) async {
    String url = "tel:+963$phone";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch$url ';
    }
  }



  Future<void> openMapWithDirection({required double latitude, required double longitude}) async {
    String url="google.navigation:q=$latitude,$longitude&mode=d";
    if (await canLaunch(url)) {
      await launch(
        url,

        forceSafariVC: false, //ios
        forceWebView: false, //android
        enableJavaScript: false, //android
      );
    } else {
      throw 'Could not open the Map';
    }
  }






}
