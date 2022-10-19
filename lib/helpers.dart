import 'package:shelf/shelf.dart';

// ----------------------------------------------------------------------------
// Helper function for middleware to allow web services methods over web.
// ----------------------------------------------------------------------------

Middleware handleCors() {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };

  // Return a middleware that adds CORS headers to all responses.
  return createMiddleware(
    requestHandler: (Request req) {
      if (req.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }
      return null;
    },
    responseHandler: (Response res) {
      return res.change(headers: corsHeaders);
    },
  );
}
