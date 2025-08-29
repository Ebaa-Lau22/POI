import 'package:flutter/material.dart';
import 'package:poi/core/theme/app_colors.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Debate Blogs',
          style: TextStyle(fontFamily: "Merriweather", fontSize: 14),
        ),
      ),
      body: ListView(
        children: [
          ArticlePost(
            authorName: 'Ahmad Ali',
            authorImage: 'https://i.pravatar.cc/150?img=3',
            title: 'The Art of Persuasion in Debates',
            snippet:
                'Debating is not just talking; it is the art of convincing and influencing others in a structured and logical way',
            onReadMore: () {
              print('Show more tapped!');
            },
          ),
          ArticlePost(
            authorName: 'Ahmad Ali',
            authorImage: 'https://i.pravatar.cc/150?img=3',
            title: 'The Art of Persuasion in Debates',
            snippet:
                'Debating is not just talking; it is the art of convincing and influencing others in a structured and logical way',
            onReadMore: () {
              print('Show more tapped!');
            },
          ),
        ],
      ),
    );
  }
}

class ArticlePost extends StatefulWidget {
  final String authorName;
  final String authorImage;
  final String title;
  final String snippet;
  final VoidCallback onReadMore;

  const ArticlePost({
    super.key,
    required this.authorName,
    required this.authorImage,
    required this.title,
    required this.snippet,
    required this.onReadMore,
  });

  @override
  State<ArticlePost> createState() => _ArticlePostState();
}

class _ArticlePostState extends State<ArticlePost> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    print(isFavorite ? 'Liked!' : 'Unliked!');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author + Like icon
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.authorImage),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.authorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: "Lato",
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 24,
                    color: isFavorite ? AppColors.darkRed: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 8),

            // Snippet + "Show more"
            RichText(
              text: TextSpan(
                text: '${widget.snippet}... ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: widget.onReadMore,
                      child: Text(
                        'Show more',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sansation",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
