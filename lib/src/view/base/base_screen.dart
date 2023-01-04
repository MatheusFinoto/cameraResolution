import 'package:camera/camera.dart';
import 'package:camera_resolution/src/components/field_tile.dart';
import 'package:camera_resolution/src/stores/base_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:mobx/mobx.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  BoxDecoration customDecoration(context) {
    return BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[200]
          : Colors.black26,
      borderRadius: BorderRadius.circular(10),
    );
  }

  BaseStore baseStore = BaseStore();

  @override
  void initState() {
    super.initState();
    baseStore.loadListOfCameras();
    baseStore.getCameraResolutionList();

    baseStore.initCamera();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    reaction((_) => baseStore.selectedResolution, (v) {
      print(v);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Camera'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height),
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Propriedades da câmera',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Veja a qualidade da imagem gerada.',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
              const Divider(height: 32),
              Column(
                children: [
                  const FieldTitle(
                    title: 'Resolução da camera',
                  ),
                  const SizedBox(height: 8),
                  Observer(builder: (_) {
                    return Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: customDecoration(context),
                      child: DropdownButton<ResolutionPreset>(
                        items: baseStore.cameraResolutionList
                            .map<DropdownMenuItem<ResolutionPreset>>((element) {
                          return DropdownMenuItem<ResolutionPreset>(
                              value: element,
                              child: Text(
                                baseStore.getCameraResolutionString(
                                    preset: element)['qualidade'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ));
                        }).toList(),
                        onChanged: baseStore.setSelectedResolution,
                        isExpanded: true,
                        value: baseStore.selectedResolution,
                        underline: Container(),
                        hint: const Text(''),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(height: 16),
              const FieldTitle(
                title: 'Informações da resolução',
              ),
              Observer(builder: (context) {
                return Container(
                  decoration: customDecoration(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldTitle(
                                title: 'Pixels',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        baseStore.getCameraResolutionString(
                                                preset: baseStore
                                                    .selectedResolution!)[
                                            'size']['pixels'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldTitle(
                                title: 'Resolução',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        baseStore.getCameraResolutionString(
                                                preset: baseStore
                                                    .selectedResolution!)[
                                            'size']['resolucao'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Observer(
                builder: (_) {
                  switch (baseStore.cameraStatus) {
                    case HttpStatus.none:
                      return Container();
                    case HttpStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    case HttpStatus.success:
                      return Stack(
                        children: [
                          CameraPreview(baseStore.cameraController!),
                          Positioned(
                              bottom: 16,
                              child: SizedBox(
                                height: 60,
                                width: size.width - 32,
                                // color: Colors.red,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      baseStore.takePicture();
                                    },
                                    child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: const Center(
                                          child: Icon(Icons.camera_alt_outlined,
                                              size: 45),
                                        )),
                                  ),
                                ),
                              )),
                        ],
                      );

                    case HttpStatus.error:
                      return Container();
                    case HttpStatus.fail:
                      return Container();
                  }
                },
              ),
              const SizedBox(height: 16),
              const FieldTitle(
                title: 'Imagem capturada',
              ),
              const SizedBox(height: 8),
              Observer(
                builder: (_) {
                  if (baseStore.imagePicked == null) {
                    return Container();
                  } else {
                    return Column(
                      children: [
                        Image.file(baseStore.imagePicked!),
                        const SizedBox(height: 8),
                        SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  GallerySaver.saveImage(
                                          baseStore.imagePicked!.path)
                                      .then((bool? success) {
                                    if (success == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('Imagem Salva com sucesso'),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Não foi possível salvar a imagem'),
                                      ));
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'SALVAR IMAGEM',
                                ))),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              const FieldTitle(
                title: 'Informações da imagem capturada',
              ),
              const SizedBox(height: 8),
              Observer(builder: (context) {
                return Container(
                  decoration: customDecoration(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldTitle(
                                title: 'Bytes',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        baseStore.fileLength ?? 'Sem dados',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldTitle(
                                title: 'MegaBytes',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        baseStore.fileLength == null
                                            ? 'Sem dados'
                                            : '${int.parse(baseStore.fileLength!) / 1024 / 1024}'
                                                .substring(0, 7),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
