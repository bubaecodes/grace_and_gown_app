import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/profile/controllers/addresses_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:grace_and_gown_app/utils/validators/validation.dart';
import 'package:toastification/toastification.dart';

/// Saved delivery and pickup addresses: the list, per-card default/delete
/// actions, and an add-address bottom sheet.
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressesController());

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(title: 'Addresses'),
              SizedBox(height: 6.h),
              Text(
                'Where we deliver gowns and pick up rentals.',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                final list = controller.addresses;

                if (list.isEmpty) {
                  return const _EmptyAddresses();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < list.length; i++)
                      _AddressCard(address: list[i], index: i),
                  ],
                );
              }),
              SizedBox(height: 8.h),
              _PrimaryAction(
                label: 'Add Address',
                onTap: () => _showAddSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Add-address sheet, styled like the booking sheet: elevated surface,
  /// rounded top and a drag handle.
  void _showAddSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.elevatedSurface(context),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      // Let the keyboard push the fields up instead of covering them.
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const _AddAddressSheet(),
      ),
    );
  }
}

/// One saved address: label + Default badge, details, then its actions.
class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address, required this.index});

  final AddressEntry address;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = AddressesController.instance;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                address.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3.sp,
                  color: AppColors.strong(context),
                ),
              ),
              if (address.isDefault) ...[
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.sageGreen,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    'Default',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          for (final line in [
            address.recipient,
            address.line,
            address.city,
            address.phone,
          ])
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary(context),
                ),
              ),
            ),
          SizedBox(height: 8.h),
          Row(
            children: [
              if (!address.isDefault)
                InkWell(
                  onTap: () => controller.setDefault(index),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                    child: Text(
                      'Set as default',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.link(context),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: () => controller.removeAt(index),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shown when every address has been deleted.
class _EmptyAddresses extends StatelessWidget {
  const _EmptyAddresses();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 44.h),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64.sp,
            height: 64.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.fieldFill(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_outlined,
              size: 30.sp,
              color: AppColors.accent(context),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No addresses yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Prata',
              fontSize: 18.sp,
              letterSpacing: 0.5.sp,
              color: AppColors.strong(context),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add a delivery or pickup address so fittings and rentals go '
                'smoothly.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet form for adding an address (Label, Recipient, Address line,
/// City, Phone). Validated inline, then appended to the list.
class _AddAddressSheet extends StatefulWidget {
  const _AddAddressSheet();

  @override
  State<_AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<_AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();

  final _label = TextEditingController();
  final _recipient = TextEditingController();
  final _line = TextEditingController();
  final _city = TextEditingController();
  final _phone = TextEditingController();

  @override
  void dispose() {
    _label.dispose();
    _recipient.dispose();
    _line.dispose();
    _city.dispose();
    _phone.dispose();
    super.dispose();
  }

  /// Closes the sheet and appends the address when every field validates.
  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    AddressesController.instance.add(
      AddressEntry(
        label: _label.text.trim(),
        recipient: _recipient.text.trim(),
        line: _line.text.trim(),
        city: _city.text.trim(),
        phone: _phone.text.trim(),
      ),
    );

    CustomSnackBar.showSafe(
      title: 'Address Added',
      message: '${_label.text.trim()} address saved to your list.',
      type: ToastificationType.success,
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color:
                          AppColors.secondary(context).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Add Address',
                  style: TextStyle(
                    fontFamily: 'Prata',
                    fontSize: 18.sp,
                    letterSpacing: 0.6.sp,
                    color: AppColors.heading(context),
                  ),
                ),
                SizedBox(height: 14.h),
                _fieldLabel(context, 'Label'),
                AppFormTextField(
                  controller: _label,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Label', value),
                  textInputAction: TextInputAction.next,
                  hintText: 'Home, Studio, ...',
                  prefixIcon: Icons.label_outline_rounded,
                ),
                SizedBox(height: 12.h),
                _fieldLabel(context, 'Recipient'),
                AppFormTextField(
                  controller: _recipient,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Recipient', value),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  hintText: 'Who receives the delivery',
                  prefixIcon: Icons.person_outline_rounded,
                ),
                SizedBox(height: 12.h),
                _fieldLabel(context, 'Address line'),
                AppFormTextField(
                  controller: _line,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Address line', value),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: 'Street address',
                  prefixIcon: Icons.location_on_outlined,
                ),
                SizedBox(height: 12.h),
                _fieldLabel(context, 'City'),
                AppFormTextField(
                  controller: _city,
                  validator: (value) =>
                      AppValidator.validateEmptyText('City', value),
                  textInputAction: TextInputAction.next,
                  hintText: 'Area, city',
                  prefixIcon: Icons.map_outlined,
                ),
                SizedBox(height: 12.h),
                _fieldLabel(context, 'Phone'),
                AppFormTextField(
                  controller: _phone,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Phone', value),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  hintText: 'Contact number',
                  prefixIcon: Icons.phone_outlined,
                ),
                SizedBox(height: 18.h),
                _PrimaryAction(label: 'Save Address', onTap: _submit),
              ],
            ),
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

/// The full-width sage primary button.
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
