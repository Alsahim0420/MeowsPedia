import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../utils/utils.dart';

class SearchCatResultItem extends StatelessWidget {
  const SearchCatResultItem({
    super.key,
    required this.cat,
    this.onTap,
  });

  final Cat cat;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        leading: SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: AppUtils().getCatImage(cat.image?.url),
          ),
        ),
        title: Text(
          cat.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Container(
          color: Colors.transparent,
          width: 100,
          height: 25,
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 15,
                child: FutureBuilder(
                  future: AppUtils().fetchFlag(cat.origin),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          color: Colors.transparent,
          width: 100,
          child: Column(
            children: [
              Text(
                cat.temperament ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
