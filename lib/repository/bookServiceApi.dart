import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/book.dart';

class BookServiceApi {
  final String apiUrl = 'https://gutendex.com/books';

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List booksJson = data['results'];
      return booksJson.map((json)=> Book.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar libros');
    }
  }
}