import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'deeplogitechapi_backend.dart';

// ----------------------------------------------------------------------------
// BACKEND PART FOR REST API
// Created ends point for get, post and delete.
// ----------------------------------------------------------------------------

Future initiate() async {
  // Make API call to get all data from website
  final response = await http.Client().get(Uri.parse('https://time.com'));

  // Check if response is successful
  if (response.statusCode != 200) return response.body;

  // Parse the HTML document
  var document = parse(response.body);

  // Get all the elements with class 'latest-stories__item-headline' to fetch latest news.
  final title = document
      .getElementsByClassName("latest-stories__item-headline")
      .toList()
      .map((e) => e.innerHtml.trim());

  // Get all the elements with class 'latest-stories__item' to fetch latest news url.
  final link = document
      .getElementsByClassName("latest-stories__item")
      .toList()
      .map((e) => e.querySelectorAll('a').first.attributes['href']);
  print(link);

  // Combining data from title and link to create a list of map.
  List<Map<String, dynamic>> linkMap = [];

  // For loop to add the title and link to the list
  for (int i = 0; i < 5; i++) {
    linkMap.add({
      'title': title.elementAt(i),
      'link': "https://time.com/${link.elementAt(i)!}",
    });
  }

  return linkMap;
}

class DeepLogitechApi {
  DeepLogitechApi();
  Future _initiate() async {
    // Make API call to get all data from website
    final response = await http.Client().get(Uri.parse('https://time.com'));

    // Check if response is successful
    if (response.statusCode != 200) return response.body;

    // Parse the HTML document
    var document = parse(response.body);

    // Get all the elements with class 'latest-stories__item-headline' to fetch latest news.
    final title = document
        .getElementsByClassName("latest-stories__item-headline")
        .toList()
        .map((e) => e.innerHtml.trim());

    // Get all the elements with class 'latest-stories__item' to fetch latest news url.
    final link = document
        .getElementsByClassName("latest-stories__item")
        .toList()
        .map((e) => e.querySelectorAll('a').first.attributes['href']);
    print(link);

    // Combining data from title and link to create a list of map.
    List<Map<String, dynamic>> linkMap = [];

    // For loop to add the title and link to the list
    for (int i = 0; i < 5; i++) {
      linkMap.add({
        'title': title.elementAt(i),
        'link': "https://time.com/${link.elementAt(i)!}",
      });
    }

    return linkMap;
  }

  Handler get router {
    final app = Router();

    app.get('/', (Request req) async {
      var item = await _initiate();
      return Response.ok(
        json.encode(
          item,
        ),
        headers: {
          'Content-Type': ContentType.json.mimeType,
        },
      );
    });

    return app;
  }
}
