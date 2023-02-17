{{> licence.dart }}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../base/common_blocs/user_account_bloc.dart';
import '../../base/common_ui_components/action_button.dart';
import '../../base/common_ui_components/update_button.dart';
import '../../base/extensions/error_model_translations.dart';
import '../../base/models/errors/error_model.dart';{{#ui_toolkit}}
import '../../base/routers/router.gr.dart';{{/ui_toolkit}}
import '../../base/theme/design_system.dart';
import '../../feature_login/ui_components/profile_avatar.dart';
import '../../l10n/l10n.dart';
import '../blocs/counter_bloc.dart';
import '../di/counter_dependencies.dart';

class CounterPage extends StatelessWidget implements AutoRouteWrapper {
  const CounterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiProvider(
        providers: CounterDependencies.from(context).providers,
        child: this,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        drawer: _buildDrawer(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RxBlocBuilder<CounterBlocType, int>(
                state: (bloc) => bloc.states.count,
                builder: (context, countState, bloc) =>
                    _buildCount(context, countState),
              ),
              RxBlocListener<CounterBlocType, ErrorModel>(
                state: (bloc) => bloc.states.errors,
                listener: _onError,
              ),
              RxBlocListener<UserAccountBlocType, ErrorModel>(
                state: (bloc) => bloc.states.errors,
                listener: _onError,
              ),
            ],
          ),
        ),
        floatingActionButton: _buildActionButtons(context),
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text(context.l10n.featureCounter.counterPageTitle),
        actions: [
          RxLoadingBuilder<CounterBlocType>(
            state: (bloc) => bloc.states.isLoading,
            builder: (context, isLoading, tag, bloc) => UpdateButton(
              isActive: !isLoading,
              onPressed: () => bloc.events.reload(),
            ),
          ),
          const ProfileAvatar(),
        ],
      );

          Widget _buildDrawer(BuildContext context) => Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: ListView(
            // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                  color: Colors.blue,
                  ),
                child: Text('Drawer Header'),
                ),{{#ui_toolkit}}
                ListTile(
                  title: const Text('UI_TOOLKIT'),
                  onTap: () {
                    context.router.pop();
                    context.router.push(const UiToolkitRoute());
                  },
                ),{{/ui_toolkit}}
                ListTile(
                  title: const Text('Close the Drawer'),
                  onTap: () {
                    context.router.pop();
                  },
                ),
              ],
            ),
          );

  Widget _buildCount(BuildContext context, AsyncSnapshot<int> snapshot) =>
      snapshot.hasData
          ? Text(
              snapshot.data!.toString(),
              style: context.designSystem.typography.counterText,
            )
          : Text(
              snapshot.connectionState.toString(),
              style: context.designSystem.typography.h2Med16,
            );

  Widget _buildActionButtons(BuildContext context) =>
      RxLoadingBuilder<CounterBlocType>(
        state: (bloc) => bloc.states.isLoading,
        builder: (context, isLoading, tag, bloc) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButton(
              icon: Icon(context.designSystem.icons.plusSign),
              tooltip: context.l10n.featureCounter.increment,
              onPressed: isLoading ? null : bloc.events.increment,
              loading: isLoading && tag == CounterBloc.tagIncrement,
              heroTag: 'increment',
            ),
            const SizedBox(width: 16),
            ActionButton(
              icon: Icon(context.designSystem.icons.minusSign),
              tooltip: context.l10n.featureCounter.decrement,
              onPressed: isLoading ? null : bloc.events.decrement,
              loading: isLoading && tag == CounterBloc.tagDecrement,
              heroTag: 'decrement',
            ),
          ],
        ),
      );

  void _onError(BuildContext context, ErrorModel errorModel) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorModel.translate(context)),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
