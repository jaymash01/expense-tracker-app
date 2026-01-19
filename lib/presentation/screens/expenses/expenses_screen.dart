import 'dart:async';

import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_bloc.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_event.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_state.dart';
import 'package:expense_tracker/presentation/screens/expenses/expense_filters_sheet.dart';
import 'package:expense_tracker/presentation/widgets/dialogs.dart';
import 'package:expense_tracker/presentation/widgets/empty_placeholder.dart';
import 'package:expense_tracker/presentation/widgets/expense_card.dart';
import 'package:expense_tracker/presentation/widgets/loading_indicator.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Map<String, dynamic> _params = <String, dynamic>{};
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<ExpensesBloc>()..add(LoadExpenses(_params));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        bloc.add(LoadMoreExpenses(_params));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text('Create Expense'),
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (BuildContext context, ExpensesState state) {
          return ScreenSafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ExpensesBloc>().add(LoadExpenses(_params));
                await Future.delayed(Duration.zero);
              },
              child: Column(
                children: <Widget>[
                  _buildSearchBar(),
                  if (state.expenses.isEmpty && state.isLoading)
                    LoadingIndicator(isLoading: true),
                  if (state.expenses.isEmpty && !state.isLoading)
                    EmptyPlaceholder(
                      title: 'No expenses',
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  if (state.expenses.isNotEmpty) _buildList(state),
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
          hintText: 'Search expenses',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: SizedBox(
            width: 96.0,
            child: TextButton(
              onPressed: _showExpenseFiltersSheet,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Filter'),
                  SizedBox(width: AppDimensions.spaceS),
                  Icon(Icons.filter_list_rounded),
                ],
              ),
            ),
          ),
        ),
        onChanged: (String value) {
          setState(() {
            _params['q'] = value;
          });

          if (_debounceTimer?.isActive ?? false) {
            _debounceTimer?.cancel();
          }

          _debounceTimer = Timer(const Duration(milliseconds: 500), () {
            context.read<ExpensesBloc>().add(LoadExpenses(_params));
          });
        },
      ),
    );
  }

  Widget _buildList(ExpensesState state) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.spaceM,
          0,
          AppDimensions.spaceM,
          AppDimensions.spaceM,
        ),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: state.expenses.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < state.expenses.length) {
            final expense = state.expenses[index];
            return ExpenseCard(expense: expense, onTap: () => true);
          } else {
            return LoadingIndicator(isLoading: state.isLoading);
          }
        },
      ),
    );
  }

  void _showExpenseFiltersSheet() {
    Dialogs.showBottomSheet(
      context,
      'Filter Expenses',
      ExpenseFiltersSheet(
        params: _params,
        onClearFilters: () {
          setState(() {
            _params = <String, dynamic>{
              'q': _params['q'],
            }; // Clear but preserve 'q' if available
            context.read<ExpensesBloc>().add(LoadExpenses(_params));
          });
        },
        onApplyFilters: (Map<String, dynamic> params) {
          // First update the params and then reload expenses
          setState(() {
            _params = params;
            context.read<ExpensesBloc>().add(LoadExpenses(_params));
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
