import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class ListDetailScreen extends StatefulWidget {
  final String title;
  final String imagePath;
  final String paragraphs;
  final String filepath;

  const ListDetailScreen({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.paragraphs,
    required this.filepath,
  }) : super(key: key);

  @override
  _ListDetailScreenState createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  late List<bool> _readStatus;
  String _htmlContent = '';

  @override
  void initState() {
    super.initState();
    _readStatus = List.generate(widget.paragraphs.length, (index) => false);
    loadHtml();
  }

  void _toggleReadStatus(int index) {
    setState(() {
      _readStatus[index] = !_readStatus[index];
    });
  }

  Future<void> loadHtml() async {
    String html = await DefaultAssetBundle.of(
      context,
    ).loadString(widget.filepath);
    setState(() {
      _htmlContent = html;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(225, 79, 76, 182),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Color.fromARGB(225, 79, 76, 182),
              ),
            ),
          ),
          const SizedBox(height: 0),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18),
              child: Html(
                style: {"body": Style(color: const Color.fromRGBO(0, 0, 0, 1))},
                // data: widget.paragraphs,
                data: _htmlContent,
                extensions: [
                  TagExtension(
                    tagsToExtend: {"img"},
                    builder: (ExtensionContext context) {
                      final attrs = context.attributes;
                      final src = attrs['src'] ?? '';

                      if (src.isNotEmpty) {
                        if (src.startsWith('assets/html/')) {
                          return Image.asset(
                            src,
                            width: 100,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Text('Image not found'),
                          );
                        } else if (!src.startsWith('http')) {
                          return Image.asset(
                            'assets/images/$src',
                            width: 100,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Text('Image not found'),
                          );
                        } else {
                          return Image.network(
                            src,
                            width: 100,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Text('Image failed to load'),
                          );
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
