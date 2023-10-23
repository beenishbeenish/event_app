import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:event_app/Provider/events_class.dart';
import 'package:event_app/Provider/language_class.dart';
import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:event_app/Views/event_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<ScanQrScreen> {
  late Barcode result;
  late String brData;
  String error = '';
  bool loading = false;
  QRViewController? controller;

  // late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  FlutterSecureStorage storage = const FlutterSecureStorage();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    final eventModal = Provider.of<EventClass>(context, listen: false);
    // eventModal.getEventData(eventId: '63346d6464c8dabd865f4ad3',);
    // moveToNextScreen(eventId: );
  }

  moveToNextScreen({required String eventId}) async {
    if (eventId != null) {
      setState(() {
        loading = true;
        error = '';
      });

      final languageModal = Provider.of<LanguageClass>(context, listen: false);
      final eventModal = Provider.of<EventClass>(context, listen: false);
      eventModal
          .getEventData(
              eventId: eventId,
              contextEventD: context,
              languageModal: languageModal)
          .then((value) async {
        if (eventModal.eventResponseModel?.status == true) {
          //
          await controller!.pauseCamera();
          await storage.write(key: 'event_id', value: eventId);
          await storage.write(
              key: 'event_code',
              value: eventModal.eventResponseModel?.event!.eventCode);

          AppGlobal.eventCode =
              eventModal.eventResponseModel?.event!.eventCode ?? '';

          AppGlobal.eventId = eventId.toString();

          loading = false;
          //eventModal.refreshScreenState();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const EventInfoScreen(title: '')));
        } else {
          loading = false;
          // eventModal.refreshScreenState();
          error = languageModal.languageResponseModel != null
              ? languageModal.languageResponseModel!.infoScreen.tryAgain
              : 'Please try Again';
        }
      });

      // print('status is ${eventModal.eventResponseModel!.status}');

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          // buildQrView(context),
          Positioned(top: 20, left: 10, child: backButtonWidget(context)),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              left: MediaQuery.of(context).size.width * 0.10,
              child: scanText(context)),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.21,
              left: MediaQuery.of(context).size.width * 0.10,
              child: scanTextDetails(context)),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.71,
            left: MediaQuery.of(context).size.width * 0.12,
            child: Text(
              error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 17,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.71,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Center(
              child: loading
                  ? Container(
                      child: SpinKitFadingCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kColorPrimary,
                            ),
                          );
                        },
                      ),
                    )
                  : null,
            ),
          )
        ],
      )),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width * 0.75;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.black,
          borderRadius: 5,
          borderLength: 30,
          borderWidth: 0,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Widget backButtonWidget(context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 15.0,
              color: Colors.white,
            )),
        InkWell(
          onTap: () {
            // moveToNextScreen(eventId: '63240c9b41979cbd3af2da03');
            // Navigator.of(context).pop();
          },
          child: Text(
            languageModel.languageResponseModel != null
                ? languageModel.languageResponseModel!.infoScreen.cancel
                : 'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget scanText(context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Row(
      children: [
        Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.infoScreen.qrScan
              : 'Scan QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget scanTextDetails(context) {
    final languageModel = Provider.of<LanguageClass>(context);

    return Row(
      children: [
        Text(
          languageModel.languageResponseModel != null
              ? languageModel.languageResponseModel!.infoScreen.scanQr
              : 'Scan QR code to join',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    // setState(() {
    this.controller = controller;
    // });
    controller.pauseCamera();
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      await controller.resumeCamera();

      //setState(() {
      result = scanData;
      brData = result.code!;
      error = '';
      controller.pauseCamera();
      // Navigator.pop(context, brData);
      // });

      moveToNextScreen(eventId: brData);
    });
    // controller = controller;
    // controller.scannedDataStream.listen((scanData) async {
    //   setState(() {
    //     result = scanData;
    //     // loading=true;
    //     brData = result.code!;
    //     error='';
    //     print('data.... is ${brData}');
    //     moveToNextScreen(eventId:brData);
    //
    //     // Navigator.pop(context, brData);
    //   });
    //
    // });
    //
    // controller.pauseCamera();
    // controller.resumeCamera();
    // final eventModel = Provider.of<EventClass>(context);
    // print('event modak,,,${eventModel.loading}');
    // setState(() {
    //   this.controller = controller;
    // });
    // controller.scannedDataStream.listen((scanData) async {
    //   await controller.pauseCamera();
    //   print('print data,,,,'+ scanData.toString());
    //
    // });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('nopermission')),
      );
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
