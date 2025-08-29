import 'package:flutter/material.dart';

class ConfirmedDebateWidget extends StatelessWidget {
  ConfirmedDebateWidget({super.key});
  final Map<String, dynamic> item = {
    'image':
        'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
    'title': 'Tech & Innovation Debate',
    'date': 'July 1, 2025',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              item['image']!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item['date']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 30,
                  child: Stack(
                    children: List.generate(8, (idx) {
                      return Positioned(
                        left: idx * 15.0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                //   child: Stack(
                //     children: List.generate(8, (idx) {
                //       return Positioned(
                //         left: idx * 22.0,
                //         child: CircleAvatar(
                //           radius: 14,
                //           backgroundColor: Colors.grey.shade300,
                //           child: Icon(
                //             Icons.person,
                //             size: 16,
                //             color: Colors.grey.shade700,
                //           ),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
