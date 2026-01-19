import 'dart:io';

import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_event.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/form_label_control.dart';
import 'package:expense_tracker/presentation/widgets/loading_button.dart';
import 'package:expense_tracker/presentation/widgets/loading_container.dart';
import 'package:expense_tracker/presentation/widgets/popup_menu_item_content.dart';
import 'package:expense_tracker/presentation/widgets/avatar.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final AuthRepository _authRepository = AuthRepository();
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  File? _photo;
  Map<String, dynamic> _formData = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final user = context.read<AuthBloc>().state.user;

    if (user != null) {
      _nameTextController.text = user.name ?? '';
      _emailTextController.text = user.email ?? '';

      setState(() {
        _formData['name'] = user.name;
        _formData['email'] = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text('Edit Account'),
      ),
      body: ScreenSafeArea(
        includeTop: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceM,
            vertical: AppDimensions.spaceXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildPhoto(context),
              SizedBox(height: AppDimensions.spaceXL),
              FormLabelControl(
                label: 'Full Name',
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
                label: 'Email',
                child: TextField(
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _formData['email'] = value;
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

  Widget _buildPhoto(BuildContext context) {
    final state = context.read<AuthBloc>().state;

    return Center(
      child: SizedBox(
        width: 96.0,
        height: 96.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: 96.0,
              height: 96.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(48)),
                border: Border.all(
                  color: context.colorScheme.outline,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Avatar(
                  path: state.user?.photoUrl,
                  file: _photo,
                  size: 80.0,
                ),
              ),
            ),
            Positioned(
              top: 4.0,
              right: 0.0,
              child: LoadingContainer(
                loading: false,
                size: 30.0,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.photo_camera_rounded),
                  iconColor: context.colorScheme.onPrimary,
                  iconSize: 14.0,
                  position: PopupMenuPosition.under,
                  onSelected: (String value) {
                    if (value == 'Choose Photo') {
                      openImagePicker(ImageSource.gallery);
                    } else if (value == 'Take Photo') {
                      openImagePicker(ImageSource.camera);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                        value: 'Choose Photo',
                        child: PopupMenuItemContent(
                          icon: Icon(Icons.photo_rounded),
                          label: 'Choose Photo',
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Take Photo',
                        child: PopupMenuItemContent(
                          icon: Icon(Icons.camera_alt_rounded),
                          label: 'Take Photo',
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openImagePicker(ImageSource source) {
    _imagePicker.pickImage(source: source).then((XFile? image) {
      if (image != null) {
        setState(() {
          _photo = File(image.path);
        });
      }
    });
  }

  bool _validateForm() {
    if ((_formData['name'] ?? '').isEmpty ||
        (_formData['email'] ?? '').isEmpty) {
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

      final response = await _authRepository.updateAccount(
        token,
        _photo?.path,
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
      authBloc.add(AuthUserFetched(token));

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
    _emailTextController.dispose();
    super.dispose();
  }
}
