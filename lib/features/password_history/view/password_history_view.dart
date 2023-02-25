import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_generator/app/l10n/l10n.g.dart';
import 'package:password_generator/app/widgets/default_container_widget.dart';
import 'package:password_generator/app/widgets/drawer_widget.dart';
import 'package:password_generator/core/extensions/context_extensions.dart';
import 'package:password_generator/features/password_history/cubit/password_history_cubit.dart';

class PasswordHistoryView extends StatelessWidget {
  const PasswordHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.history.tr().toUpperCase()),
      ),
      drawer: const DrawerWidget(),
      body: BlocConsumer<PasswordHistoryCubit, PasswordHistoryState>(
        listener: (context, state) {
          if (state.isCopied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: context.durationDefault,
                margin: context.paddingAllVeryHigh,
                content: Text(
                  LocaleKeys.password_copied.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (state.isDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: context.durationDefault,
                margin: context.paddingAllVeryHigh,
                content: Text(
                  LocaleKeys.password_deleted.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.history.isEmpty) {
            return Center(
              child: Text(
                LocaleKeys.history_empty.tr(),
                style: context.textTheme.titleMedium,
              ),
            );
          } else {
            return Container(
              padding: context.paddingAllDefault,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.password_history.tr().toUpperCase(),
                  ),
                  SizedBox(
                    height: context.lowValue,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(height: context.mediumValue);
                      },
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        return _PasswordHistoryTile(password: state.history[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _PasswordHistoryTile extends StatelessWidget {
  const _PasswordHistoryTile({required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              password,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          Wrap(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.content_copy),
                onPressed: () => context.read<PasswordHistoryCubit>().copyPassword(password: password),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.delete_forever),
                onPressed: () => context.read<PasswordHistoryCubit>().deleteFromHistory(password: password),
              ),
            ],
          )
        ],
      ),
    );
  }
}
