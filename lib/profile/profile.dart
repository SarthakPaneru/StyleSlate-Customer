import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository_factory.dart';
import 'package:hamro_barber_mobile/features/profile/viewmodel/profile_avatar_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/surfaces/app_avatar_image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileAvatarViewModel(createProfileRepository())..loadImageUrl(),
      child: const _ProfileAvatarView(),
    );
  }
}

class _ProfileAvatarView extends StatelessWidget {
  const _ProfileAvatarView();

  Future<void> _pickAndUpload(BuildContext context, ProfileAvatarViewModel viewModel) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final success = await viewModel.uploadImage(File(pickedFile.path));
    if (!context.mounted) return;

    if (success) {
      AppSnackbar.showSuccess(context, AppStrings.profilePictureUpdated);
      await viewModel.loadImageUrl();
    } else {
      AppSnackbar.showError(
        context,
        viewModel.errorMessage ?? AppStrings.profilePictureUploadFailed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileAvatarViewModel>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAvatarImage(imageUrl: viewModel.imageUrl, size: 120),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => _pickAndUpload(context, viewModel),
          child: const Text(AppStrings.editProfilePicture),
        ),
      ],
    );
  }
}
