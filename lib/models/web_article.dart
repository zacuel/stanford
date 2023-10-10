import '../utils/type_defs.dart';

class WebArticle {
  // TODO fields for author and source... try to gather automatically.
  final String url;
  final String title;
  final String exciteLine;
  final DateTime datePosted;
  final Locale locale;
  final List<String> upVotes;
}
