import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:mobx/mobx.dart';

// import '../model/session_model.dart';

part 'base_store.g.dart';

enum HttpStatus { none, loading, success, error, fail }

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  @observable
  CameraController? cameraController;

  @observable
  List<CameraDescription> camerasList = [];

  @observable
  HttpStatus loadListOfCamerasStatus = HttpStatus.none;

  @action
  Future<void> loadListOfCameras() async {
    try {
      loadListOfCamerasStatus = HttpStatus.loading;

      camerasList = await availableCameras();

      if (camerasList.isEmpty) {
        loadListOfCamerasStatus = HttpStatus.error;
      } else {
        initCamera();
        loadListOfCamerasStatus = HttpStatus.success;
      }
    } catch (error) {
      loadListOfCamerasStatus = HttpStatus.fail;
    }
  }

  @observable
  List<ResolutionPreset> cameraResolutionList = [];

  @observable
  HttpStatus getCameraResolutionListStatus = HttpStatus.none;

  @action
  Future<void> getCameraResolutionList() async {
    try {
      getCameraResolutionListStatus = HttpStatus.loading;

      cameraResolutionList.add(ResolutionPreset.low);
      cameraResolutionList.add(ResolutionPreset.medium);
      cameraResolutionList.add(ResolutionPreset.high);
      cameraResolutionList.add(ResolutionPreset.veryHigh);
      cameraResolutionList.add(ResolutionPreset.ultraHigh);
      cameraResolutionList.add(ResolutionPreset.max);

      getCameraResolutionListStatus = HttpStatus.success;
    } catch (e) {
      getCameraResolutionListStatus = HttpStatus.fail;
    }
  }

  @observable
  ResolutionPreset? selectedResolution = ResolutionPreset.max;

  @action
  void setSelectedResolution(value) {
    selectedResolution = value;
    initCamera();
  }

  Map<String, dynamic> getCameraResolutionString(
      {required ResolutionPreset preset}) {
    switch (preset) {
      case ResolutionPreset.low:
        return {
          "qualidade": "Baixa",
          "size": {
            "pixels": "240p",
            "resolucao": "352x288 on iOS, 320x240 on Android"
          }
        };

      case ResolutionPreset.medium:
        return {
          "qualidade": "Média",
          "size": {
            "pixels": "480p",
            "resolucao": "640x480 iOS, 720x480 Android"
          }
        };

      case ResolutionPreset.high:
        return {
          "qualidade": "Alta",
          "size": {"pixels": "720p", "resolucao": "1280x720"}
        };

      case ResolutionPreset.veryHigh:
        return {
          "qualidade": "Muito Alto",
          "size": {"pixels": "1080p", "resolucao": "1920x1080"}
        };

      case ResolutionPreset.ultraHigh:
        return {
          "qualidade": "Ultra Alta",
          "size": {"pixels": "2160p", "resolucao": "3840x2160"}
        };

      case ResolutionPreset.max:
        return {
          "qualidade": "Maxima",
          "size": {"pixels": "Resolução maxima disponível", "resolucao": ""}
        };

      default:
        return {};
    }
  }

  @observable
  HttpStatus cameraStatus = HttpStatus.none;

  @action
  Future<void> initCamera() async {
    try {
      cameraStatus = HttpStatus.loading;

      cameraController = CameraController(
        camerasList[0],
        selectedResolution!,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await cameraController!.initialize();

      cameraStatus = HttpStatus.success;
    } catch (e) {
      print(e.toString());
    }
  }

  @observable
  File? imagePicked;

  @observable
  String? fileLength;

  @observable
  var decodedImage;

  @action
  Future<void> takePicture() async {
    try {
      XFile file = await cameraController!.takePicture();

      imagePicked = File(file.path);

      var fLen = await imagePicked!.length();

      fileLength = fLen.toString();
      foo(imagePicked!);
    } catch (e) {}
  }

  void foo(File file) {
    final size = ImageSizeGetter.getSize(FileInput(file));
    print('width = ${size.width}, height = ${size.height}');
  }
}
