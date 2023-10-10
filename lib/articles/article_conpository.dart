import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stanford/utils/firebase_providers.dart';
import '../utils/constants.dart';
import '../utils/type_defs.dart';
import '../models/article.dart';

final articlesByLocalProvider = StreamProvider.family((ref, Locale locale) {
  return ref.watch(articlesConpositoryProvider).getCommunityByLocale(locale);
});

final articlesConpositoryProvider = Provider<ArticlesConpository>((ref) {
  return ArticlesConpository(firestore: ref.read(firestoreProvider));
});

class ArticlesConpository {
  final FirebaseFirestore _firestore;
  ArticlesConpository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _allArticles =>
      _firestore.collection(FirestoreConstants.articlesCollection);

  Future<void> createArticle(Article article) async {
    try {
      await _allArticles.add(article.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Article>> getCommunityByLocale(Locale locale) {
    return _allArticles
        .where('locale', isEqualTo: locale.index)
        .snapshots()
        .map((event) {
      List<Article> articles = [];
      for (var doc in event.docs) {
        articles.add(Article.fromMap(doc.data() as Map<String, dynamic>));
      }
      return articles;
    });
  }
}
