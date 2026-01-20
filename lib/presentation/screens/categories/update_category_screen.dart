import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/data/models/category_model.dart';
import 'package:expense_tracker/data/repositories/categories_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_event.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/form_label_control.dart';
import 'package:expense_tracker/presentation/widgets/loading_button.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final Category category;

  const UpdateCategoryScreen({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  Map<String, dynamic> _formData = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    context.read<CategoriesBloc>().add(LoadCategories(null));

    setState(() {
      _formData['name'] = widget.category.name;
      _formData['description'] = widget.category.description ?? '';
      _nameTextController.text = _formData['name'];
      _descriptionTextController.text = _formData['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Edit Category'),
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
                label: 'Name',
                child: TextField(
                  controller: _nameTextController,
                  keyboardType: TextInputType.name,
                  onChanged: (String value) {
                    setState(() {
                      _formData['name'] = value;
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

  bool _validateForm() {
    if ((_formData['name'] ?? '').isEmpty) {
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

      final response = await _categoriesRepository.updateCategory(
        token,
        widget.category.id,
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
      context.read<CategoriesBloc>().add(LoadCategories(null));

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
    _nameTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }
}
