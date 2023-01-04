// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseStore on _BaseStore, Store {
  late final _$cameraControllerAtom =
      Atom(name: '_BaseStore.cameraController', context: context);

  @override
  CameraController? get cameraController {
    _$cameraControllerAtom.reportRead();
    return super.cameraController;
  }

  @override
  set cameraController(CameraController? value) {
    _$cameraControllerAtom.reportWrite(value, super.cameraController, () {
      super.cameraController = value;
    });
  }

  late final _$camerasListAtom =
      Atom(name: '_BaseStore.camerasList', context: context);

  @override
  List<CameraDescription> get camerasList {
    _$camerasListAtom.reportRead();
    return super.camerasList;
  }

  @override
  set camerasList(List<CameraDescription> value) {
    _$camerasListAtom.reportWrite(value, super.camerasList, () {
      super.camerasList = value;
    });
  }

  late final _$loadListOfCamerasStatusAtom =
      Atom(name: '_BaseStore.loadListOfCamerasStatus', context: context);

  @override
  HttpStatus get loadListOfCamerasStatus {
    _$loadListOfCamerasStatusAtom.reportRead();
    return super.loadListOfCamerasStatus;
  }

  @override
  set loadListOfCamerasStatus(HttpStatus value) {
    _$loadListOfCamerasStatusAtom
        .reportWrite(value, super.loadListOfCamerasStatus, () {
      super.loadListOfCamerasStatus = value;
    });
  }

  late final _$cameraResolutionListAtom =
      Atom(name: '_BaseStore.cameraResolutionList', context: context);

  @override
  List<ResolutionPreset> get cameraResolutionList {
    _$cameraResolutionListAtom.reportRead();
    return super.cameraResolutionList;
  }

  @override
  set cameraResolutionList(List<ResolutionPreset> value) {
    _$cameraResolutionListAtom.reportWrite(value, super.cameraResolutionList,
        () {
      super.cameraResolutionList = value;
    });
  }

  late final _$getCameraResolutionListStatusAtom =
      Atom(name: '_BaseStore.getCameraResolutionListStatus', context: context);

  @override
  HttpStatus get getCameraResolutionListStatus {
    _$getCameraResolutionListStatusAtom.reportRead();
    return super.getCameraResolutionListStatus;
  }

  @override
  set getCameraResolutionListStatus(HttpStatus value) {
    _$getCameraResolutionListStatusAtom
        .reportWrite(value, super.getCameraResolutionListStatus, () {
      super.getCameraResolutionListStatus = value;
    });
  }

  late final _$selectedResolutionAtom =
      Atom(name: '_BaseStore.selectedResolution', context: context);

  @override
  ResolutionPreset? get selectedResolution {
    _$selectedResolutionAtom.reportRead();
    return super.selectedResolution;
  }

  @override
  set selectedResolution(ResolutionPreset? value) {
    _$selectedResolutionAtom.reportWrite(value, super.selectedResolution, () {
      super.selectedResolution = value;
    });
  }

  late final _$cameraStatusAtom =
      Atom(name: '_BaseStore.cameraStatus', context: context);

  @override
  HttpStatus get cameraStatus {
    _$cameraStatusAtom.reportRead();
    return super.cameraStatus;
  }

  @override
  set cameraStatus(HttpStatus value) {
    _$cameraStatusAtom.reportWrite(value, super.cameraStatus, () {
      super.cameraStatus = value;
    });
  }

  late final _$imagePickedAtom =
      Atom(name: '_BaseStore.imagePicked', context: context);

  @override
  File? get imagePicked {
    _$imagePickedAtom.reportRead();
    return super.imagePicked;
  }

  @override
  set imagePicked(File? value) {
    _$imagePickedAtom.reportWrite(value, super.imagePicked, () {
      super.imagePicked = value;
    });
  }

  late final _$fileLengthAtom =
      Atom(name: '_BaseStore.fileLength', context: context);

  @override
  String? get fileLength {
    _$fileLengthAtom.reportRead();
    return super.fileLength;
  }

  @override
  set fileLength(String? value) {
    _$fileLengthAtom.reportWrite(value, super.fileLength, () {
      super.fileLength = value;
    });
  }

  late final _$decodedImageAtom =
      Atom(name: '_BaseStore.decodedImage', context: context);

  @override
  dynamic get decodedImage {
    _$decodedImageAtom.reportRead();
    return super.decodedImage;
  }

  @override
  set decodedImage(dynamic value) {
    _$decodedImageAtom.reportWrite(value, super.decodedImage, () {
      super.decodedImage = value;
    });
  }

  late final _$loadListOfCamerasAsyncAction =
      AsyncAction('_BaseStore.loadListOfCameras', context: context);

  @override
  Future<void> loadListOfCameras() {
    return _$loadListOfCamerasAsyncAction.run(() => super.loadListOfCameras());
  }

  late final _$getCameraResolutionListAsyncAction =
      AsyncAction('_BaseStore.getCameraResolutionList', context: context);

  @override
  Future<void> getCameraResolutionList() {
    return _$getCameraResolutionListAsyncAction
        .run(() => super.getCameraResolutionList());
  }

  late final _$initCameraAsyncAction =
      AsyncAction('_BaseStore.initCamera', context: context);

  @override
  Future<void> initCamera() {
    return _$initCameraAsyncAction.run(() => super.initCamera());
  }

  late final _$takePictureAsyncAction =
      AsyncAction('_BaseStore.takePicture', context: context);

  @override
  Future<void> takePicture() {
    return _$takePictureAsyncAction.run(() => super.takePicture());
  }

  late final _$_BaseStoreActionController =
      ActionController(name: '_BaseStore', context: context);

  @override
  void setSelectedResolution(dynamic value) {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.setSelectedResolution');
    try {
      return super.setSelectedResolution(value);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cameraController: ${cameraController},
camerasList: ${camerasList},
loadListOfCamerasStatus: ${loadListOfCamerasStatus},
cameraResolutionList: ${cameraResolutionList},
getCameraResolutionListStatus: ${getCameraResolutionListStatus},
selectedResolution: ${selectedResolution},
cameraStatus: ${cameraStatus},
imagePicked: ${imagePicked},
fileLength: ${fileLength},
decodedImage: ${decodedImage}
    ''';
  }
}
