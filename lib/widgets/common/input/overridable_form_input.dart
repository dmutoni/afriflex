import 'package:flutter/material.dart';

class OverridableErrorFormField<T> extends FormField<T> {
  @override
  final Key? key;
  @override
  final Widget Function(FormFieldState<dynamic>) builder;
  @override
  final FormFieldSetter<T>? onSaved;
  @override
  final FormFieldValidator<T>? validator;
  @override
  final T? initialValue;

  const OverridableErrorFormField({
    this.key,
    required this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
  }) : super(
          key: key,
          builder: builder,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
        );

  @override
  OverridableErrorFormFieldState<T> createState() =>
      OverridableErrorFormFieldState<T>();
}

class OverridableErrorFormFieldState<T> extends FormFieldState<T> {
  String? _overrideErrorText;

  OverridableErrorFormFieldState() : super();

  @override
  String? get errorText => _overrideErrorText ?? super.errorText;

  set errorText(String? value) => _overrideErrorText = value;

  @override
  bool get hasError => _overrideErrorText?.isNotEmpty ?? super.hasError;

  void clearError() => setState(() => _overrideErrorText = null);

  @override
  void reset() {
    setState(() => _overrideErrorText = null);
    super.reset();
  }
}
