import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/comma_text_input_formatter.dart';
import 'package:expense_tracker/core/utils/helpers.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/repositories/expenses_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_event.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_event.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_bloc.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_event.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/app_dropdown.dart';
import 'package:expense_tracker/presentation/widgets/form_label_control.dart';
import 'package:expense_tracker/presentation/widgets/loading_button.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateExpenseScreen extends StatefulWidget {
  final Expense expense;

  const UpdateExpenseScreen({super.key, required this.expense});

  @override
  State<StatefulWidget> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  final ExpensesRepository _expensesRepository = ExpensesRepository();
  final TextEditingController _amountTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _dateTextController = TextEditingController();

  Map<String, dynamic> _formData = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    context.read<CategoriesBloc>().add(LoadCategories(null));

    setState(() {
      _formData['category_id'] = '${widget.expense.category!.id}';
      _formData['amount'] = '${widget.expense.amount}';
      _formData['description'] = widget.expense.description ?? '';
      _formData['expense_date'] = formatDate(
        widget.expense.expenseDate,
        'yyyy-MM-dd',
      );
      _amountTextController.text = _formData['amount'];
      _descriptionTextController.text = _formData['description'];
      _dateTextController.text = _formData['expense_date'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.select(
      (CategoriesBloc bloc) => bloc.state.categories,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Edit Expense'),
      ),
      body: ScreenSafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceM,
            vertical: AppDimensions.spaceXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormLabelControl(
                label: 'Category',
                child: AppDropdown(
                  value: _formData['category_id'],
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
                      _formData['category_id'] = value;
                    });
                  },
                ),
              ),
              SizedBox(height: AppDimensions.spaceM),
              FormLabelControl(
                label: 'Amount',
                child: TextField(
                  controller: _amountTextController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CommaTextInputFormatter(),
                  ],
                  decoration: InputDecoration(prefix: Text('TZS ')),
                  onChanged: (String value) {
                    setState(() {
                      _formData['amount'] = value.replaceAll(',', '');
                    });
                  },
                ),
              ),
              SizedBox(height: AppDimensions.spaceM),
              FormLabelControl(
                label: 'Description (Optional)',
                child: TextField(
                  controller: _descriptionTextController,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 3,
                  onChanged: (String value) {
                    setState(() {
                      _formData['description'] = value;
                    });
                  },
                ),
              ),
              SizedBox(height: AppDimensions.spaceM),
              FormLabelControl(
                label: 'Expense Date',
                child: TextField(
                  readOnly: true,
                  controller: _dateTextController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  onTap: _showExpenseDatePicker,
                ),
              ),
              SizedBox(height: AppDimensions.spaceXL),
              LoadingButton(
                loading: _isLoading,
                child: const Text('Submit'),
                onPressed: () {
                  if (_validateForm()) {
                    submit();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExpenseDatePicker() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: (_formData['expense_date'] ?? '').isNotEmpty
          ? parseDate(_formData['expense_date'])
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        _formData['expense_date'] = formatDate(selected, 'yyyy-MM-dd');
        _dateTextController.text = _formData['expense_date'];
      });
    }
  }

  bool _validateForm() {
    if (_formData['category_id'] == null ||
        (_formData['amount'] ?? '').isEmpty ||
        (_formData['expense_date'] ?? '').isEmpty) {
      appAlert(
        context,
        'Please fill all the required fields',
        type: AlertType.error,
      );
      return false;
    }

    return true;
  }

  void submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final authBloc = context.read<AuthBloc>();
      final token = authBloc.state.token ?? '';
      final body = _formData;

      final response = await _expensesRepository.updateExpense(
        token,
        widget.expense.id,
        body,
      );
      setState(() {
        _isLoading = true;
      });

      appAlert(
        context,
        response.message,
        type: AlertType.success,
        duration: const Duration(seconds: 10),
      );

      appAlert(context, response.message, type: AlertType.success);
      context.read<ExpensesBloc>().add(LoadExpenses(null));
      context.read<DashboardBloc>().add(LoadDashboard());

      Navigator.pop(context);
    } catch (e) {
      appAlert(context, e.toString(), type: AlertType.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _amountTextController.dispose();
    _descriptionTextController.dispose();
    _dateTextController.dispose();
    super.dispose();
  }
}
