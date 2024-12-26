import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.searchController,
    required this.triggerSearchEvent,
  }) ;

  final TextEditingController searchController;
  final VoidCallback triggerSearchEvent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // Add padding around the search bar
        padding:  EdgeInsets.symmetric(horizontal: searchBarPadding),
        // Use a Material design search bar
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: AppStrings.textfield_addSearchBar_text,
            // Add a clear button to the search bar
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => searchController.clear(),
            ),
            // Add a search icon or button to the search bar
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: triggerSearchEvent,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(searchBarRadius),
            ),
          ),
        ),
      ),
    );
  }
}