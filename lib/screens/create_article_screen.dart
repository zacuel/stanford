import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stanford/articles/article_conpository.dart';
import 'package:stanford/authentication/auth_controller.dart';
import '../utils/type_defs.dart';
import '../models/article.dart';

class CreateArticleScreen extends ConsumerStatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateArticleScreenState();
}

class _CreateArticleScreenState extends ConsumerState<CreateArticleScreen> {
  late PageController _pageController;
  bool _isInternetArticle = false;
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _exciteLineController = TextEditingController();
  final _contentController = TextEditingController();
  Locale locale = Locale.local;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _exciteLineController.text = 'Check this out!';
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _titleController.dispose();
    _urlController.dispose();
    _exciteLineController.dispose();
    _contentController.dispose();
  }

  _backButton() {
    if (_pageController.page == 0) {
      Routemaster.of(context).pop();
    }
    if (_pageController.page == 1) {
      _pageController.jumpToPage(0);
    } else {
      _pageController.jumpToPage(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lets Create Content Together"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _backButton,
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _itemZero,
          _itemOne,
          _itemTwo,
        ],
      ),
    );
  }

  void _submitArticle() {
    final userId = ref.read(citizenProvider)!.uid;
    if (_exciteLineController.text.trim() == '') {
      // TODO create randomized exciteline list
      _exciteLineController.text = "hey check this out!";
    }
    final newArticle = Article(
      authorId: userId,
      title: _titleController.text,
      locale: locale,
      datePosted: DateTime.now(),
      exciteLine: _exciteLineController.text,
      url: _isInternetArticle ? _urlController.text : null,
      content: _contentController.text,
    );
    ref.read(articlesConpositoryProvider).createArticle(newArticle);
    Routemaster.of(context).pop();
  }

  Widget get _itemZero {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //TODO decide on better language.
        const Text(
            "Is this primarily a pre-existing article with an active web address?"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isInternetArticle = true;
                });
                _pageController.jumpToPage(1);
              },
              child: const Text('yes'),
            ),
            ElevatedButton(
              onPressed: () {
                _isInternetArticle = false;
                _pageController.jumpToPage(1);
              },
              child: const Text('no'),
            ),
          ],
        )
      ],
    );
  }

  Widget get _itemOne {
    return Column(
      children: [
        const Text('what is the title of your posting'),
        TextField(
          controller: _titleController,
        ),
        if (_isInternetArticle)
          Column(
            children: [
              const Text('what is the url of your post?'),
              TextField(
                controller: _urlController,
              ),
            ],
          ),
        const Text(
            'what is your main content. feel free to cut and paste from other sources while we fasten up the form formulation'),
        //TOD formate this text field.
        TextField(
          controller: _contentController,
        ),
        ElevatedButton(
            onPressed: () {
              if (_titleController.text.trim() != '' &&
                  (_urlController.text.trim() != '' ||
                      _contentController.text.trim() != '')) {
                _pageController.jumpToPage(2);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('why are you like this')));
              }
            },
            child: const Text('Proceed'))
      ],
    );
  }

  Widget get _itemTwo {
    return Column(
      children: [
        const Text(
            'What\'s something to say that might entice a potential reader?'),
        TextField(
          controller: _exciteLineController,
        ),
        const Text('What is the locational scope of concern?'),
        Container(
          width: 400,
          margin: const EdgeInsets.all(20),
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RadioListTile<Locale>(
                title: const Text("Local"),
                value: Locale.local,
                groupValue: locale,
                onChanged: (Locale? value) {
                  setState(() {
                    locale = value!;
                  });
                },
              ),
              RadioListTile<Locale>(
                title: const Text("Michigan"),
                value: Locale.state,
                groupValue: locale,
                onChanged: (Locale? value) {
                  setState(() {
                    locale = value!;
                  });
                },
              ),
              RadioListTile<Locale>(
                title: const Text("National"),
                value: Locale.national,
                groupValue: locale,
                onChanged: (Locale? value) {
                  setState(() {
                    locale = value!;
                  });
                },
              ),
              RadioListTile<Locale>(
                title: const Text("Global"),
                value: Locale.global,
                groupValue: locale,
                onChanged: (Locale? value) {
                  setState(() {
                    locale = value!;
                  });
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: _submitArticle, child: const Text('Submit Article'))
      ],
    );
  }
}
