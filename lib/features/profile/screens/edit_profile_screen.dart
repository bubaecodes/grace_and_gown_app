import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/profile/controllers/profile_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:grace_and_gown_app/utils/validators/validation.dart';
import 'package:toastification/toastification.dart';

/// Edit the personal details the Profile header shows.
///
/// Fields seed from [ProfileController]'s reactive values and are written
/// back on save, so the header card updates immediately.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    // Registers the controller when the screen is opened directly (a test
    // or deep link) — a no-op once ProfileScreen has already put it.
    final profile = Get.put(ProfileController());
    _name = TextEditingController(text: profile.name.value);
    _email = TextEditingController(text: profile.email.value);
    _phone = TextEditingController(text: profile.phone.value);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  /// Validates the form, writes the values back and pops to the Profile tab.
  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ProfileController.instance.saveProfile(
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
    );

    CustomSnackBar.showSafe(
      title: 'Profile Updated',
      message: 'Your details have been saved.',
      type: ToastificationType.success,
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(title: 'My Details'),
              SizedBox(height: 6.h),
              Text(
                'Update the details we use for bookings and deliveries.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 18.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldLabel(context, 'Full Name'),
                    AppFormTextField(
                      controller: _name,
                      validator: (value) =>
                          AppValidator.validateEmptyText('Full Name', value),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person_outline_rounded,
                    ),
                    SizedBox(height: 14.h),
                    _fieldLabel(context, 'Email'),
                    AppFormTextField(
                      controller: _email,
                      validator: AppValidator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: 'Enter your email',
                      prefixIcon: Icons.mail_outline_rounded,
                    ),
                    SizedBox(height: 14.h),
                    _fieldLabel(context, 'Phone'),
                    AppFormTextField(
                      controller: _phone,
                      validator: (value) =>
                          AppValidator.validateEmptyText('Phone', value),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      hintText: 'Enter your phone number',
                      prefixIcon: Icons.phone_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              _PrimaryAction(label: 'Save Changes', onTap: _save),
            ],
          ),
        ),
      ),
    );
  }
}

/// Field label styled like the auth forms (see login_form.dart).
Widget _fieldLabel(BuildContext context, String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      label,
      style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
          .copyWith(
        color: AppColors.secondary(context),
        fontSize: 15.4.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

/// Back arrow + screen title, matching the other Profile sub-screens.
class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.back(),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: AppColors.strong(context),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4.sp,
              color: AppColors.heading(context),
            ),
          ),
        ),
      ],
    );
  }
}

/// The full-width sage "Save Changes" button.
class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.sageGreen,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.accent(context)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
