import 'package:flutter/material.dart';
import 'package:meows_pedia/presentation/presentation.dart';
import 'package:provider/provider.dart';

class CatListScreen extends StatelessWidget {
  const CatListScreen({super.key});

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
          PopupMenuButton<SortOption>(
            onSelected: (SortOption result) {
              catProvider.updateSortOption(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
              PopupMenuItem<SortOption>(
                value: SortOption.country,
                child: Row(
                  children: [
                    if (catProvider.sortOption == SortOption.country)
                      Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text('Country'),
                  ],
                ),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption.affection,
                child: Row(
                  children: [
                    if (catProvider.sortOption == SortOption.affection)
                      Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text('Affection'),
                  ],
                ),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption.energy,
                child: Row(
                  children: [
                    if (catProvider.sortOption == SortOption.energy)
                      Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text('Energy'),
                  ],
                ),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption.intelligence,
                child: Row(
                  children: [
                    if (catProvider.sortOption == SortOption.intelligence)
                      Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text('Intelligence'),
                  ],
                ),
              ),
            ],
            icon: Icon(
              Icons.filter_list_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            color: Theme.of(context).colorScheme.background,
          ),
          Transform.rotate(
            angle: !catProvider.isAscending ? 0 : 3.14,
            child: IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                catProvider.toggleSortOrder();
              },
              icon: const Icon(Icons.sort),
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
                ? SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/image_logo.png'),
                        const Text(
                          'Loading the meows',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ))
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
