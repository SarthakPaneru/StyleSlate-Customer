import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository_factory.dart';
import 'package:hamro_barber_mobile/features/profile/viewmodel/profile_avatar_view_model.dart';
import 'package:hamro_barber_mobile/ui_kit/feedback/app_snackbar.dart';
import 'package:hamro_barber_mobile/ui_kit/pickers/app_image_source_sheet.dart';
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

  static const _avatarSize = 120.0;

  // A raw camera capture can be 10+ MB, which nginx in front of the
  // backend rejects with 413 before the request even reaches the app.
  // Downscale + re-encode on pick so both camera and gallery photos
  // upload as a reasonably sized JPEG regardless of the original.
  static const _maxImageDimension = 1024.0;
  static const _imageQuality = 80;

  Future<void> _editPicture(
    BuildContext context,
    ProfileAvatarViewModel viewModel,
  ) async {
    final source = await showAppImageSourceSheet(context);
    if (source == null || !context.mounted) return;

    XFile? pickedFile;
    try {
      pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: _maxImageDimension,
        maxHeight: _maxImageDimension,
        imageQuality: _imageQuality,
      );
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbar.showError(context, AppStrings.imageSourcePickFailed);
      return;
    }
    if (pickedFile == null || !context.mounted) return;

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
    final colorScheme = Theme.of(context).colorScheme;
    final isUploading = viewModel.status == ViewStatus.loading;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: isUploading ? null : () => _editPicture(context, viewModel),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AppAvatarImage(imageUrl: viewModel.imageUrl, size: _avatarSize),
              if (isUploading)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.45),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surface,
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: colorScheme.secondary,
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.editProfilePicture,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
        ),
      ],
    );
  }
}
