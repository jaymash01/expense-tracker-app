import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/helpers.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_event.dart';
import 'package:expense_tracker/presentation/widgets/app_dropdown.dart';
import 'package:expense_tracker/presentation/widgets/form_label_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseFiltersSheet extends StatefulWidget {
  final Map<String, dynamic> params;
  final VoidCallback onClearFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const ExpenseFiltersSheet({
    super.key,
    required this.params,
    required this.onClearFilters,
    required this.onApplyFilters,
  });

  @override
  State<StatefulWidget> createState() => _ExpenseFiltersSheetState();
}

class _ExpenseFiltersSheetState extends State<ExpenseFiltersSheet> {
  final TextEditingController _startDateTextController =
      TextEditingController();
  final TextEditingController _endDateTextController = TextEditingController();

  Map<String, dynamic> _params = <String, dynamic>{};

  @override
  void initState() {
    super.initState();

    _startDateTextController.text = widget.params['start_date'] ?? '';
    _endDateTextController.text = widget.params['end_date'] ?? '';
    _params = widget.params;

    context.read<CategoriesBloc>().add(LoadCategories(null));
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.select(
      (CategoriesBloc bloc) => bloc.state.categories,
    );

    return Padding(
      padding: EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormLabelControl(
            label: 'Category',
            child: AppDropdown(
              value: _params['category_id'],
              hint: 'Select category',
              items: categories
                  .map(
                    (element) => <String, String>{
                      'label': element.name,
                      'value': '${element.id}',
                    },
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _params['category_id'] = value;
                });
              },
            ),
          ),
          SizedBox(height: AppDimensions.spaceM),
          Row(
            children: <Widget>[
              Expanded(
                child: FormLabelControl(
                  label: 'Start Date',
                  child: TextField(
                    readOnly: true,
                    controller: _startDateTextController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    onTap: _showStartDatePicker,
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.spaceM),
              Expanded(
                child: FormLabelControl(
                  label: 'End Date',
                  child: TextField(
                    readOnly: true,
                    controller: _endDateTextController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    onTap: _showEndDatePicker,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spaceL),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    widget.onClearFilters();
                    Navigator.pop(context);
                  },
                  child: Text('Clear'),
                ),
              ),
              SizedBox(width: AppDimensions.spaceM),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApplyFilters(_params);
                    Navigator.pop(context);
                  },
                  child: Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showStartDatePicker() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: (_params['start_date'] ?? '').isNotEmpty
          ? parseDate(_params['start_date'])
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        _params['start_date'] = formatDate(selected, 'yyyy-MM-dd');
        _startDateTextController.text = _params['start_date'];
      });
    }
  }

  void _showEndDatePicker() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: (_params['end_date'] ?? '').isNotEmpty
          ? parseDate(_params['end_date'])
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        _params['end_date'] = formatDate(selected, 'yyyy-MM-dd');
        _endDateTextController.text = _params['end_date'];
      });
    }
  }

  @override
  void dispose() {
    _startDateTextController.dispose();
    _endDateTextController.dispose();
    super.dispose();
  }
}
