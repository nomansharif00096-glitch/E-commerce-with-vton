import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // hide stack trace for normal logs
    errorMethodCount: 5, // show some stack trace on errors
    lineLength: 120, // width of the log box
    colors: true, // enable colors
    printEmojis: true, // add emojis
  ),
);
