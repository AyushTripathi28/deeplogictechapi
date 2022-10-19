import 'package:deeplogitech_api/deeplogitechapi_backend.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

// ----------------------------------------------------------------------------
// Backend service for web scraping latest news from Times.com using dart.
// ----------------------------------------------------------------------------

void main(List<String> arguments) async {
  // Create server
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final ip = InternetAddress.anyIPv4;

  Response _rootHandler(Request req) {
    return Response.ok('Deep LogicTech Get API Assignment@ /getTimeStories\n');
  }

  final app = Router()..get('/', _rootHandler);
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
