import 'package:isar/isar.dart';

part 'books.g.dart';

/*
We shall be creating a short Books application containing the following entities:

book_id

book_title

book_author

book_publish_year

book_isbn
 */

@collection
class Book {
  Id id = Isar.autoIncrement;

  String? title, author, publishYear, isbn;
}