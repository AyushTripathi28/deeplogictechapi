import 'package:deeplogitech_api/deeplogitechapi_backend.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

// ----------------------------------------------------------------------------
// Backend service for web scraping latest news from Times.com using dart.
// ----------------------------------------------------------------------------

void main(List<String> arguments) async {
  // Create server
  const port = 8080;
  final ip = "localhost"; //InternetAddress.anyIPv4;

  final app = Router();

  // Create routes
  app.mount('/getTimeStories/', DeepLogitechApi().router);

  // Listen for incoming connections
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  withHotreload(
      () => serve(handler, ip, port)); //InternetAddress.anyIPv4 // port
}
