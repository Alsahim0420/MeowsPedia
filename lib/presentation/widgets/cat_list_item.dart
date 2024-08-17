// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../utils/utils.dart';

class CatListItem extends StatefulWidget {
  final Cat cat;
  final VoidCallback onTap;

  const CatListItem({
    super.key,
    required this.cat,
    required this.onTap,
  });

  @override
  _CatListItemState createState() => _CatListItemState();
}

class _CatListItemState extends State<CatListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          children: [
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: AppUtils().getCatImage(widget.cat.image?.url),
                  ),
                ),
                FutureBuilder(
                  future: AppUtils().fetchFlag(widget.cat.origin),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 40,
                          height: 25,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey.withOpacity(0.6),
                          ),
                          child: Image.network(
                            snapShot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    widget.cat.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Span
                  if (widget.cat.lifeSpan != null)
                    Text(
                      'Life Span: ${widget.cat.lifeSpan} years',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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
