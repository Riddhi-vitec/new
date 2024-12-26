import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../imports/common.dart';




Future<XFile?> getImage({bool isFromCamera = false}) async {
  final XFile? image = await ImagePicker().pickImage(
      source: isFromCamera ? ImageSource.camera: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 1000,
      maxHeight: 1000);
  final File file = File(image!.path);
  return image;
}
//Crop image

Future<CroppedFile?> croppedFileFunction(File? file) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: file!.path,
      //user can change this aspect ration according to requirement
      uiSettings: [
        AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        )
      ]
  );
  return croppedFile;
}

getImageSize(File file) {
  final bytes = file.readAsBytesSync().lengthInBytes;
  final kb = bytes / 1024;
  final mb = kb / 1024;
  return mb;
}

List<String> getFileTypesToPickMultimedia({required MultimediaFileType multimediaFileTypes}){
  final Map<MultimediaFileType, List<String>> fileTypesMap = {
    MultimediaFileType.pdfOnly: ['pdf'],
    MultimediaFileType.docOnly: ['doc'],
    MultimediaFileType.videoOnly: ['mp4'],
    MultimediaFileType.allTypes: ['pdf', 'jpg', 'jpeg', 'png', 'mp4'],
  };

  return fileTypesMap[multimediaFileTypes] ?? ['pdf', 'jpg', 'jpeg', 'png', 'mp4'];
}

Future<List<File>> pickMultimedia({
  MultimediaFileType multimediaFileTypes = MultimediaFileType.allTypes,
  int mbAgainstComparisonFactors = 25,
  int kbComparisonFactor1 = 1024,
  int kbComparisonFactor2 = 1024,
  required List<File> alreadyPickedMultimediaFiles,
}) async {
  FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: getFileTypesToPickMultimedia(multimediaFileTypes: multimediaFileTypes),
    allowMultiple: true,
  );
  List<File> multimediaFileList = alreadyPickedMultimediaFiles;
  if (filePickerResult != null &&
      filePickerResult.files.isNotEmpty) {
    for (var file in filePickerResult.files) {
      String? filePath = file.path;
      if (filePath != null) {
        File file = File(filePath);
        final fileLength = await file.length();
        if (fileLength <= mbAgainstComparisonFactors * kbComparisonFactor1 * kbComparisonFactor2) {
          multimediaFileList.add(file);
        }
      }
    }
  }
  return multimediaFileList;
}

Future<Map<bool, String>> downloadMultimedia({
  required String fileNameWithExtension,
  required String sourceUrl,
}) async {
  try {
    final HttpClient client = HttpClient();
    final List<int> downloadData = [];
    Directory downloadDirectory;

    if (Platform.isIOS) {
      downloadDirectory = await getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = Directory('/storage/emulated/0/Download');
      if (!await downloadDirectory.exists()) {
        downloadDirectory = (await getExternalStorageDirectory())!;
      }
    }

    final String filePathName = "${downloadDirectory.path}/$fileNameWithExtension";
    final File savedFile = File(filePathName);
    final bool fileExists = await savedFile.exists();

    if (fileExists) {
      OpenFilex.open(filePathName);
      return {true: filePathName};
    }
    else {

      final HttpClientRequest request = await client.getUrl(Uri.parse(sourceUrl));
      final HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        await response.listen((d) {
          downloadData.addAll(d);
        }).asFuture<void>();

        await savedFile.writeAsBytes(downloadData);
        OpenFilex.open(filePathName);
        return {true: filePathName};

      } else {
        return {false : 'Download Failed: HTTP ${response.statusCode}'};
      }
    }
  } catch (error) {

    return {false: 'Download Failed: $error'};
  }
}

String extractFileNameFromUrl(String url) {
  List<String> parts = url.split('/');
  return parts.last;
}