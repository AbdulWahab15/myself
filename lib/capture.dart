import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Capture extends StatefulWidget {
  Capture(this.mode);

  int mode;

  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  CameraController controller;
  String videoPath;
  Color red = Color(0xff9d0301);

  Future<void> _initCamFuture;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int count = 0;
  bool check = false;

  @override
  void initState() {
    super.initState();
    _initApp();

    // Get the listonNewCameraSelected of available cameras.
    // Then set the first camera as selected.
  }

  _initApp() async {
    final cameras = await availableCameras();
    final firstCam = cameras.first;
    controller = CameraController(
      firstCam,
      ResolutionPreset.medium,
    );
    _initCamFuture = controller.initialize();
  }

  double width = 100.0, height = 100.0;
  double x = 0.0, y = 0.0;
  String path;
  bool camera = false,
      flash = false,
      timer = false,
      photo = false,
      settings = false,
      hdr = false,
      share = false;
  int cameras = 0,
      flashs = 0,
      timers = 0,
      photos = 0,
      setting = 0,
      hdrs = 0,
      shares = 0;

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
    print(x.toString() + y.toString());
    check = true;
  }

  callCamera() {
    if (widget.mode == 1) {
      print(cameras);
      if (cameras == null) {
//        cameras=widget.mode-1;
        return Transform.translate(
            offset: Offset(x, y),
            child: InkWell(
              onTap: () async {
                print('yay for image');
                try {
                  await _initCamFuture;

                  // Construct the path where the image should be saved using the path
                  // package.

                  final path = join(
                    // Store the picture in the temp directory.
                    // Find the temp directory using the `path_provider` plugin.
                    (await getExternalStorageDirectory()).path,
                    '${DateTime.now()}.png',
                  );

                  print(path);
                  // Attempt to take a picture and log where it's been saved.
                  await controller.takePicture(path);
                  GallerySaver.saveImage(path, albumName: 'Media')
                      .then((bool success) {
                    setState(() {});
                  });
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    'images/ic_outside_indicator.png',
                    width: 50,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      width: width * 2,
                      height: height * 2,
                      child:
                          CameraPreview(controller), // this is my CameraPreview
                    ),
                  ),
                ],
              ),
            ));
      } else if (cameras == 0) {
        return Transform.translate(
            offset: Offset(x, y),
            child: InkWell(
              onTap: () async {
                print('yay for image');
                try {
                  await _initCamFuture;

                  // Construct the path where the image should be saved using the path
                  // package.

                  final path = join(
                    // Store the picture in the temp directory.
                    // Find the temp directory using the `path_provider` plugin.
                    (await getExternalStorageDirectory()).path,
                    '${DateTime.now()}.png',
                  );

                  print(path);
                  // Attempt to take a picture and log where it's been saved.
                  await controller.takePicture(path);
                  GallerySaver.saveImage(path, albumName: 'Media')
                      .then((bool success) {
                    setState(() {});
                  });
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    'images/ic_outside_indicator.png',
                    width: 50,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      width: width * 2,
                      height: height * 2,
                      child:
                          CameraPreview(controller), // this is my CameraPreview
                    ),
                  ),
                ],
              ),
            ));
      } else if (cameras == 1) {
        return Transform.translate(
            offset: Offset(x, y),
            child: InkWell(
              onTap: () async {
                print('yay for video');
                if (count == 0) {
                  try {
                    await _initCamFuture;
//                    final Directory extDir = await getExternalStorageDirectory();
//                    print(extDir);
//                    final String dirPath = '${extDir.path}/Movies/flutter_test';
//                    await Directory(dirPath).create(recursive: true);
//                    final String filePath = '$dirPath/${DateTime.now()}.mp4';

                    path = join(
                      (await getExternalStorageDirectory()).path,
                      '${DateTime.now()}.mp4',
                    );

                    print(path);
                    // Attempt to take a picture and log where it's been saved.
                    await controller.startVideoRecording(path);
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                } else if (count == 1) {
                  _stopVideoRecording();
                  print('savedPath' + path);
                  GallerySaver.saveVideo(path, albumName: 'Video')
                      .then((bool success) {
                    setState(() {
                      print('savedPath' + path);
                    });
                  });
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    'images/ic_outside_indicator.png',
                    width: 50,
                  ),
                  FittedBox(
                    child: Container(
                      width: width * 2,
                      height: height * 2,
                      child:
                          CameraPreview(controller), // this is my CameraPreview
                    ),
                  ),
                ],
              ),
            ));
      }

      return Transform.translate(
          offset: Offset(x, y),
          child: InkWell(
            onTap: () async {
              print('yay for image');
              try {
                await _initCamFuture;

                // Construct the path where the image should be saved using the path
                // package.

                final path = join(
                  // Store the picture in the temp directory.
                  // Find the temp directory using the `path_provider` plugin.
                  (await getExternalStorageDirectory()).path,
                  '${DateTime.now()}.png',
                );

                print(path);
                // Attempt to take a picture and log where it's been saved.
                await controller.takePicture(path);
                GallerySaver.saveImage(path, albumName: 'Media')
                    .then((bool success) {
                  setState(() {});
                });
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: Row(
              children: [
                Image.asset(
                  'images/ic_outside_indicator.png',
                  width: 50,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    width: width * 2,
                    height: height * 2,
                    child:
                        CameraPreview(controller), // this is my CameraPreview
                  ),
                ),
              ],
            ),
          ));
    } else if (widget.mode == 2) {
      return Transform.translate(
          offset: Offset(x, y),
          child: InkWell(
            onTap: () async {
              print('yay for video');
              if (count == 0) {
                try {
                  await _initCamFuture;
//                    final Directory extDir = await getExternalStorageDirectory();
//                    print(extDir);
//                    final String dirPath = '${extDir.path}/Movies/flutter_test';
//                    await Directory(dirPath).create(recursive: true);
//                    final String filePath = '$dirPath/${DateTime.now()}.mp4';

                  path = join(
                    (await getExternalStorageDirectory()).path,
                    '${DateTime.now()}.mp4',
                  );

                  print(path);
                  // Attempt to take a picture and log where it's been saved.
                  await controller.startVideoRecording(path);
                  setState(() {
                    count = 1;
                  });
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              } else if (count == 1) {
                _stopVideoRecording();
                print('savedPath' + path);
                GallerySaver.saveVideo(path, albumName: 'Video')
                    .then((bool success) {
                  setState(() {
                    print('savedPath' + path);
                  });
                });
              }
            },
            child: Row(
              children: [
                Image.asset(
                  'images/ic_outside_indicator.png',
                  width: 50,
                ),
                FittedBox(
                  child: Container(
                    width: width * 2,
                    height: height * 2,
                    child:
                        CameraPreview(controller), // this is my CameraPreview
                  ),
                ),
              ],
            ),
          ));
//      if(cameras==null){
////        cameras=widget.mode-1;
//        return  Transform.translate(
//            offset: Offset(x, y),
//            child: InkWell(
//              onTap: () async {
//
//                print('yay for video');
//                if(count==0)
//                {
//                  try {
//                    await _initCamFuture;
////                    final Directory extDir = await getExternalStorageDirectory();
////                    print(extDir);
////                    final String dirPath = '${extDir.path}/Movies/flutter_test';
////                    await Directory(dirPath).create(recursive: true);
////                    final String filePath = '$dirPath/${DateTime.now()}.mp4';
//
//                    path = join(
//
//                      (await getExternalStorageDirectory()).path,
//                      '${DateTime.now()}.mp4',
//                    );
//
//                    print(path);
//                    // Attempt to take a picture and log where it's been saved.
//                    await controller.startVideoRecording(path);
//
//                  } catch (e) {
//                    // If an error occurs, log the error to the console.
//                    print(e);
//                  }
//                }
//                else if(count==1){
//                  _stopVideoRecording();
//                  print('savedPath'+path);
//                  GallerySaver.saveVideo(path, albumName: 'Video')
//                      .then((bool success) {
//                    setState(() {
//                      print('savedPath'+path);
//                    });
//                  });
//                }
//              },
//              child: Row(
//                children: [
//                  Image.asset(
//                    'images/ic_outside_indicator.png',
//                    width: 50,
//                  ),
//                  FittedBox(
//                    child: Container(
//                      width: width*2 ,
//                      height: height*2,
//                      child: CameraPreview(
//                          controller), // this is my CameraPreview
//                    ),
//                  ),
//                ],
//              ),
//            ));
//      }
//      else if(cameras==0){
//        return  Transform.translate(
//            offset: Offset(x, y),
//            child: InkWell(
//              onTap: () async {
//                print('yay for image');
//                try {
//                  await _initCamFuture;
//
//                  // Construct the path where the image should be saved using the path
//                  // package.
//
//                  final path = join(
//                    // Store the picture in the temp directory.
//                    // Find the temp directory using the `path_provider` plugin.
//                    (await getExternalStorageDirectory()).path,
//                    '${DateTime.now()}.png',
//                  );
//
//                  print(path);
//                  // Attempt to take a picture and log where it's been saved.
//                  await controller.takePicture(path);
//                  GallerySaver.saveImage(path, albumName: 'Media')
//                      .then((bool success) {
//                    setState(() {});
//                  });
//                } catch (e) {
//                  // If an error occurs, log the error to the console.
//                  print(e);
//                }
//              },
//              child: Row(
//                children: [
//                  Image.asset(
//                    'images/ic_outside_indicator.png',
//                    width: 50,
//                  ),
//                  FittedBox(
//                    fit: BoxFit.fitWidth,
//                    child: Container(
//                      width: width*2 ,
//                      height: height*2,
//                      child: CameraPreview(
//                          controller), // this is my CameraPreview
//                    ),
//                  ),
//                ],
//              ),
//            ));
//      }
//      else if(cameras==1){
//        return  Transform.translate(
//            offset: Offset(x, y),
//            child: InkWell(
//              onTap: () async {
//
//                print('yay for video');
//                if(count==0)
//                {
//                  try {
//                    await _initCamFuture;
////                    final Directory extDir = await getExternalStorageDirectory();
////                    print(extDir);
////                    final String dirPath = '${extDir.path}/Movies/flutter_test';
////                    await Directory(dirPath).create(recursive: true);
////                    final String filePath = '$dirPath/${DateTime.now()}.mp4';
//
//                    path = join(
//
//                      (await getExternalStorageDirectory()).path,
//                      '${DateTime.now()}.mp4',
//                    );
//
//                    print(path);
//                    // Attempt to take a picture and log where it's been saved.
//                    await controller.startVideoRecording(path);
//
//                  } catch (e) {
//                    // If an error occurs, log the error to the console.
//                    print(e);
//                  }
//                }
//                else if(count==1){
//                  _stopVideoRecording();
//                  print('savedPath'+path);
//                  GallerySaver.saveVideo(path, albumName: 'Video')
//                      .then((bool success) {
//                    setState(() {
//                      print('savedPath'+path);
//                    });
//                  });
//                }
//              },
//              child: Row(
//                children: [
//                  Image.asset(
//                    'images/ic_outside_indicator.png',
//                    width: 50,
//                  ),
//                  FittedBox(
//                    child: Container(
//                      width: width*2 ,
//                      height: height*2,
//                      child: CameraPreview(
//                          controller), // this is my CameraPreview
//                    ),
//                  ),
//                ],
//              ),
//            ));
//
//      }
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
      count = 0;
    } on CameraException catch (e) {
      print('Exception' + e.toString());
      return null;
    }
  }

  Widget _widget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    bool dialVisible = true;

    final deviceRatio = size.width / size.height;
    return Listener(
      onPointerMove: _updateLocation,
      child: Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldKey,
        drawer: Theme(
            data: Theme.of(context).copyWith(
              // Set the transparency here

              canvasColor: Colors
                  .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
            ),
            child: Drawer(
              // All other codes goes here.
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        RawMaterialButton(
                          child: cameras == 0
                              ? Image.asset(
                                  'images/ic_photo_camera_white_24dp.png')
                              : Image.asset(
                                  'images/ic_videocam_white_24dp.png'),
                          onPressed: () {
                            camera = true;
                          },
                          constraints: BoxConstraints.tightFor(
                            width: 56.0,
                            height: 56.0,
                          ),
                          shape: CircleBorder(),
                          fillColor: red,
                        ),
                        if (camera == true)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RawMaterialButton(
                                  child: Image.asset(
                                      'images/ic_photo_camera_white_24dp.png'),
                                  onPressed: () {
                                    camera = true;
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: red,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RawMaterialButton(
                                  child: Image.asset(
                                      'images/ic_photo_camera_white_24dp.png'),
                                  onPressed: () {
                                    setState(() {
                                      cameras = 0;
                                      camera = false;
                                    });
                                    cameras = 0;
                                    camera = false;
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: red,
                                ),
                              ),
                              RawMaterialButton(
                                child: Image.asset(
                                    'images/ic_videocam_white_24dp.png'),
                                onPressed: () {
                                  setState(() {
                                    cameras = 0;
                                    camera = false;
                                  });
                                },
                                constraints: BoxConstraints.tightFor(
                                  width: 56.0,
                                  height: 56.0,
                                ),
                                shape: CircleBorder(),
                                fillColor: red,
                              ),
//                             RawMaterialButton(
//                               child:
//                               Image.asset('images/ic_videocam_white_24dp.png'),
//                               onPressed: () {
//                                 cameras=1;
//                                 camera=false;
//
//                               },
//                               constraints: BoxConstraints.tightFor(
//                                 width: 56.0,
//                                 height: 56.0,
//                               ),
//                               shape: CircleBorder(),
//                               fillColor: red,
//                             ),
                            ],
                          )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Stack(
                      children: [
                        RawMaterialButton(
                          child:
                              Image.asset('images/ic_flash_on_white_24dp.png'),
                          onPressed: () {
                            flash = true;
                          },
                          constraints: BoxConstraints.tightFor(
                            width: 56.0,
                            height: 56.0,
                          ),
                          shape: CircleBorder(),
                          fillColor: red,
                        ),
                        if (flash == true)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RawMaterialButton(
                                  child: Image.asset(
                                      'images/ic_flash_on_white_24dp.png'),
                                  onPressed: () {
                                    flash = false;
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: red,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RawMaterialButton(
                                  child: Image.asset(
                                      'images/ic_flash_on_white_24dp.png'),
                                  onPressed: () {
                                    flash = false;
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: red,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RawMaterialButton(
                                  child: Image.asset(
                                      'images/ic_flash_auto_white_24dp.png'),
                                  onPressed: () {
                                    flash = false;
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: red,
                                ),
                              ),
                              RawMaterialButton(
                                child: Image.asset(
                                    'images/ic_flash_off_white_24dp.png'),
                                onPressed: () {
                                  flash = false;
                                },
                                constraints: BoxConstraints.tightFor(
                                  width: 56.0,
                                  height: 56.0,
                                ),
                                shape: CircleBorder(),
                                fillColor: red,
                              ),
                            ],
                          )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    RawMaterialButton(
                      child: Image.asset('images/ic_timer_white_24dp.png'),
                      onPressed: () {},
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: red,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    RawMaterialButton(
                      child:
                          Image.asset('images/ic_photo_library_white_24dp.png'),
                      onPressed: () {},
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: red,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    RawMaterialButton(
                      child: Image.asset('images/ic_settings_white_24dp.png'),
                      onPressed: () {},
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: red,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    RawMaterialButton(
                      child: Image.asset('images/ic_hdr_on_white_24dp.png'),
                      onPressed: () {},
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: red,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    RawMaterialButton(
                      child: Image.asset('images/ic_share_white_24dp.png'),
                      onPressed: () {},
                      constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: red,
                    ),
                  ],
                ),
              ),
            )),
        body: Stack(
          children: [
            Positioned(
                left: 10,
                top: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                )),
            Center(
              child: Container(
                width: width,
                height: height,
                child: Image.asset('images/logo_my_self_v2.png'),
              ),
            ),
            if (check == true) callCamera()
//              Transform.translate(
//                offset: Offset(x, y),
//                child: Row(
//                  children: [
//                    Image.asset(
//                      'images/ic_outside_indicator.png',
//                      width: 50,
//                    ),
//                    FittedBox(
//                      fit: BoxFit.fitWidth,
//                      child: Container(
//                        width: width / 2,
//                        height: height / 3,
//                        child: CameraPreview(
//                            controller), // this is my CameraPreview
//                      ),
//                    ),
//                  ],
//                ),
//              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _widget(context);
  }
}
