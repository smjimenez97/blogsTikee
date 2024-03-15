import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apiblogs/controllers/blogController.dart';

class BlogListView extends StatefulWidget {
  @override
  _BlogListViewState createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final blogController = Provider.of<BlogController>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!blogController.isLoadingMore && !blogController.reachedEnd) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final blogController = Provider.of<BlogController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: blogController.blogs.length +
                (blogController.reachedEnd ? 0 : 1),
            itemBuilder: (context, index) {
              if (index < blogController.blogs.length) {
                final blog = blogController.blogs[index];
                final dateParts = blog.createdAt.split('T')[0].split('-');
                final formattedDate = '${dateParts[0]}/${dateParts[1]}/${dateParts[2]}';

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fecha: $formattedDate', 
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            blog.photoUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          blog.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          blog.content.substring(0, 50),
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(blog.title),
                                content: Text(blog.content),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cerrar'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('Ver más'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      blogController.loadMoreBlogsManually();
                    },
                    child: Text('Cargar más'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
