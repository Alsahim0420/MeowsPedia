import 'package:flutter/material.dart';
import 'package:meows_pedia/presentation/presentation.dart';
import 'package:provider/provider.dart';

class CatListPage extends StatelessWidget {
  const CatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);
    final scrollCtrl = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MeowsPedia',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              showSearch(
                context: context,
                delegate: CatSearchDelegate(),
              ).then(
                (cat) {
                  if (cat != null) {
                    Navigator.pushNamed(context, '/detail', arguments: cat);
                  }
                },
              );
            },
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_outlined,
            ),
          ),
          Container(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: catProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RawScrollbar(
                    controller: scrollCtrl,
                    thumbVisibility: true,
                    radius: const Radius.circular(20),
                    thickness: 4,
                    thumbColor: Theme.of(context).colorScheme.primary,
                    child: GridView.builder(
                      controller: scrollCtrl,
                      itemCount: catProvider.cats.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final cat = catProvider.cats[index];
                        return CatListItem(
                            cat: cat,
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: cat);
                            });
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
