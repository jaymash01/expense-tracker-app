import 'dart:async';

import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_event.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/empty_placeholder.dart';
import 'package:expense_tracker/presentation/widgets/category_card.dart';
import 'package:expense_tracker/presentation/widgets/loading_indicator.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  Map<String, dynamic> _params = <String, dynamic>{};
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    context.read<CategoriesBloc>()..add(LoadCategories(_params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('My Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create category',
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createCategory),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (BuildContext context, CategoriesState state) {
          return ScreenSafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<CategoriesBloc>().add(LoadCategories(_params));
                await Future.delayed(Duration.zero);
              },
              child: Column(
                children: <Widget>[
                  _buildSearchBar(),
                  if (state.categories.isEmpty && state.isLoading)
                    LoadingIndicator(isLoading: true),
                  if (state.categories.isEmpty && !state.isLoading)
                    EmptyPlaceholder(
                      title: 'No categories',
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  if (state.categories.isNotEmpty) _buildList(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.spaceM),
      child: TextField(
        controller: _searchTextController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'Search categories',
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (String value) {
          setState(() {
            _params['q'] = value;
          });

          if (_debounceTimer?.isActive ?? false) {
            _debounceTimer?.cancel();
          }

          _debounceTimer = Timer(const Duration(milliseconds: 500), () {
            context.read<CategoriesBloc>().add(LoadCategories(_params));
          });
        },
      ),
    );
  }

  Widget _buildList(CategoriesState state) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.spaceM,
          0,
          AppDimensions.spaceM,
          96.0,
        ),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.categories.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < state.categories.length) {
            final category = state.categories[index];
            return CategoryCard(category: category);
          } else {
            return LoadingIndicator(isLoading: state.isLoading);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
