import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stanford/articles/article_conpository.dart';
import '../utils/type_defs.dart';
import '../widgets/article_tile.dart';

class LocaleArticlesPage extends ConsumerWidget {
  const LocaleArticlesPage(this.locale, {super.key});
  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(articlesByLocalProvider(locale)).when(
        data: (articlesList) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleTile(
                  title: articlesList[index].title,
                  exciteLine: articlesList[index].exciteLine);
            },
            itemCount: articlesList.length,
          );
        },
        error: (error, _) {
          return const Center(child: Text("ERROR"));
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
