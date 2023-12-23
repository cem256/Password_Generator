import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:password_generator/app/base/cubit/base_cubit.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

class ThemeCubit extends BaseCubit<ThemeState> with HydratedMixin {
  ThemeCubit() : super(ThemeState.initial());

  void changeTheme({required Brightness brightness}) {
    brightness == Brightness.dark
        ? emit(ThemeState(themeMode: ThemeMode.light))
        : emit(ThemeState(themeMode: ThemeMode.dark));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
