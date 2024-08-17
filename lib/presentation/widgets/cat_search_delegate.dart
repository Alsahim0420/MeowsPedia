import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/presentation/providers/cat_provider.dart';

import 'widgets.dart';

class CatSearchDelegate extends SearchDelegate<Cat?> {
  CatSearchDelegate()
      : super(
          searchFieldLabel: "Name of the cat",
          textInputAction: TextInputAction.search,
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildCatList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildCatList(context);
  }

  Widget _buildCatList(BuildContext context) {
    if (query.isEmpty) {
      return const NotFindSearchWidget(
        text: "You haven't done a search yet",
      );
    }
    final catProvider = Provider.of<CatProvider>(context);
    final List<Cat> filteredCats = catProvider.cats
        .where((cat) => cat.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredCats.isEmpty) {
      return NotFindSearchWidget(
        text: "No cats found for: $query",
      );
    }

    return ListView.builder(
      itemCount: filteredCats.length,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        final cat = filteredCats[index];
        return SearchCatResultItem(
          cat: cat,
          onTap: () => close(context, cat),
        );
      },
    );
  }
}
