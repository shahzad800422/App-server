import 'package:cpod_server/cpod_server.dart';
import 'package:dotenv/dotenv.dart' show load, env;

Future<void> main() async {
  load();
  var email = env['email'];
  var password = env['password'];

  var server = CpodServer();
  var apiKey = env['apiKey'];

  server.apiKey = apiKey;
  print(server.apiKey);

  var s = await server.geLessonVoca('4432');
  print(s);
}
