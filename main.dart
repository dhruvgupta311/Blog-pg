import 'package:flutter/material.dart';
import './models/Category.dart';
import './models/Comments.dart';
import './models/Tag.dart';
class Post {
  final String title;
  final String content;
  final List<Comment> comments;
  final List<Tag> tags;
  final List<Category> categories;

  Post({
    required this.title,
    required this.content,
    required this.comments,
    required this.tags,
    required this.categories,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Post> _posts = [
    Post(
      title: 'First Post',
      content: 'I have submitted the internshala intership first assignment!!',
      comments: [
        Comment(text: 'Great Work!', author: 'User1'),
        Comment(text: 'I enjoyed reading your app code', author: 'User2'),
      ],
      tags: [
        Tag(name: 'Comments', color: Colors.blue),
      ],
      categories: [
        Category(name: 'Technology'),
        Category(name: 'Flutter'),
      ],
    ),
    Post(
      title: 'Second Post',
      content: 'May be my Project get selected and i got the intern',
      comments: [
        Comment(text: 'Hope for best', author: 'User1'),
        Comment(text: 'ALl the best', author: 'User2'),
      ],
      tags: [
        Tag(name: 'Comments', color: Colors.blue),
      ],
      categories: [
        Category(name: 'Technology'),
        Category(name: 'Flutter'),
      ],
    ),
    // Add more posts here...
  ];

  bool _isDarkMode = false;
  String newTitle = '';
  String newContent = '';
  List<Tag> newTags = [];
  List<Category> newCategories = [];

  void _addNewPost() {
    final newPost = Post(
      title: newTitle,
      content: newContent,
      comments: [], // Empty comments list for new posts
      tags: newTags,
      categories: newCategories,
    );

    setState(() {
      _posts.add(newPost);
      newTitle = '';
      newContent = '';
      newTags = [];
      newCategories = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Paathshala Spark Blog'),
              actions: [
                IconButton(
                  icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.light_mode),
                    title: Text('Light Mode'),
                    onTap: () {
                      setState(() {
                        _isDarkMode = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode),
                    title: Text('Dark Mode'),
                    onTap: () {
                      setState(() {
                        _isDarkMode = true;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: Text('Add New Post'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(labelText: 'Title'),
                                  onChanged: (value) {
                                    setState(() {
                                      newTitle = value;
                                    });
                                  },
                                ),
                                TextField(
                                  decoration: InputDecoration(labelText: 'Content'),
                                  onChanged: (value) {
                                    setState(() {
                                      newContent = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Add'),
                              onPressed: () {
                                _addNewPost();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            body: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.content),
                    trailing: Wrap(
                      spacing: 8.0,
                      children: post.tags
                          .map(
                            (tag) => Chip(
                              label: Text(tag.name),
                              backgroundColor: tag.color,
                            ),
                          )
                          .toList(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsPage(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PostDetailsPage extends StatelessWidget {
  final Post post;

  PostDetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(post.content),
          ),
          SizedBox(height: 16.0),
          Text(
            'Categories',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: post.categories
                .map(
                  (category) => Chip(
                    label: Text(category.name),
                    backgroundColor: Colors.green,
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16.0),
          Text(
            'Comments',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: post.comments.length,
              itemBuilder: (context, index) {
                final comment = post.comments[index];
                return ListTile(
                  leading: Icon(Icons.comment),
                  title: Text(comment.text),
                  subtitle: Text('By ${comment.author}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
