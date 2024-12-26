import 'dart:io';

class DownloadFileRepository{

  static Future<Map<bool, List<int>>> downloadFile(
      {required String sourceUrl, required String filePathName}) async {
    final HttpClient client = HttpClient();
    List<int> downloadData = [];
    try {
      final HttpClientRequest request =
          await client.getUrl(Uri.parse(sourceUrl));
      final HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        await response.listen((d) {
          downloadData.addAll(d);
        }).asFuture<void>();

        return {true: downloadData};
      } else {
        downloadData = [response.statusCode];
        return {false: downloadData};
      }
    } catch (e) {
      downloadData = [-1];
      return {false: downloadData};
    }
  }
}