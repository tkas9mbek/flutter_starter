import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/utils/bloc/bloc_load_state.dart';
import 'package:starter_toolkit/utils/bloc/paginated_data.dart';
import 'package:starter_toolkit/utils/bloc/refreshable_bloc.dart';
import 'package:starter_uikit/theme/theme_provider.dart';
import 'package:starter_uikit/widgets/app_bar/base_app_bar.dart';
import 'package:starter_uikit/widgets/app_bar/title_app_bar.dart';
import 'package:starter_uikit/widgets/button/app_elevated_button.dart';
import 'package:starter_uikit/widgets/button/app_outlined_button.dart';
import 'package:starter_uikit/widgets/dialogs/app_cupertino_date_picker.dart';
import 'package:starter_uikit/widgets/form/app_date_picker_field.dart';
import 'package:starter_uikit/widgets/form/app_dropdown_field.dart';
import 'package:starter_uikit/widgets/form/app_time_picker_field.dart';
import 'package:starter_uikit/widgets/form/country/country_code.dart';
import 'package:starter_uikit/widgets/form/country/country_code_field.dart';
import 'package:starter_uikit/widgets/form/otp_code_field.dart';
import 'package:starter_uikit/widgets/misc/app_card.dart';
import 'package:starter_uikit/widgets/misc/app_list_tile.dart';
import 'package:starter_uikit/widgets/misc/grouped_rows_card.dart';
import 'package:starter_uikit/widgets/misc/input_accessory_view_wrapper.dart';
import 'package:starter_uikit/widgets/misc/status_pill.dart';
import 'package:starter_uikit/widgets/misc/thin_horizontal_divider.dart';
import 'package:starter_uikit/widgets/misc/unfocus_area.dart';
import 'package:starter_uikit/widgets/screen/multi_bloc_refresh_indicator.dart';
import 'package:starter_uikit/widgets/screen/paginated_list_view.dart';
import 'package:starter_uikit/widgets/screen/stack_animated_switcher.dart';
import 'package:starter_uikit/widgets/size/fill_remaining_scroll_view.dart';
import 'package:starter_uikit/widgets/size/safe_vertical_box.dart';
import 'package:starter_uikit/widgets/status/app_shimmer.dart';
import 'package:starter_uikit/widgets/status/app_status_screen.dart';
import 'package:starter_uikit/widgets/status/custom_circular_progress_indicator.dart';
import 'package:starter_uikit/widgets/status/empty_information_body.dart';
import 'package:starter_uikit/widgets/status/failure_widget.dart';
import 'package:starter_uikit/widgets/text/auto_formatted_text.dart';
import 'package:starter_uikit/widgets/text/bulleted_text_list.dart';
import 'package:starter_uikit/widgets/text/title_subtitle.dart';

import '../support/pump.dart';

class _FakeRefreshableBloc with RefreshableBloc {}

const _exception = ServerException(statusCode: 500, message: 'boom');

const _countries = [
  CountryCode(name: 'Kyrgyzstan', dialCode: '+996', flag: '🇰🇬'),
  CountryCode(name: 'Kazakhstan', dialCode: '+7', flag: '🇰🇿'),
];

void main() {
  final smokeCases = <String, Widget Function()>{
    'TitleAppBar': () => const Scaffold(appBar: TitleAppBar(title: 'Title')),
    'AppElevatedButton': () => Builder(
      builder: (context) =>
          AppElevatedButton.big(context: context, text: 'Go', onPressed: () {}),
    ),
    'AppOutlinedButton': () => Builder(
      builder: (context) => AppOutlinedButton.medium(
        context: context,
        text: 'Go',
        onPressed: () {},
      ),
    ),
    'CustomCircularProgressIndicator': () =>
        const CustomCircularProgressIndicator.adaptive(),
    'EmptyInformationBody': () => const EmptyInformationBody(text: 'Empty'),
    'FailureWidget.large': () =>
        FailureWidget.large(exception: _exception, onRetry: () {}),
    'FailureWidget.small': () =>
        FailureWidget.small(exception: _exception, onRetry: () {}),
    'AppShimmer': () => const AppShimmer(
      mode: AppShimmerMode.static,
      child: AppShimmerBox(width: 100, height: 20),
    ),
    'AppShimmerCircle': () => const AppShimmer(
      mode: AppShimmerMode.static,
      child: AppShimmerCircle(size: 40),
    ),
    'AppShimmerText': () =>
        const AppShimmer(mode: AppShimmerMode.static, child: AppShimmerText()),
    'AppStatusScreen (primary only)': () => AppStatusScreen(
      icon: const Icon(Icons.check),
      title: 'Title',
      subtitle: 'Subtitle',
      primaryButtonLabel: 'Continue',
      onPrimaryPressed: () {},
    ),
    'AppStatusScreen (primary + secondary)': () => AppStatusScreen(
      icon: const Icon(Icons.error),
      title: 'Title',
      subtitle: 'Subtitle',
      primaryButtonLabel: 'Retry',
      onPrimaryPressed: () {},
      secondaryButtonLabel: 'Cancel',
      onSecondaryPressed: () {},
    ),
    'OtpCodeField': () => OtpCodeField(onCompleted: (_) {}),
    'CountryCodeField': () => CountryCodeField(
      countries: _countries,
      selected: _countries.first,
      onChanged: (_) {},
    ),
    'TitleSubtitle': () =>
        const TitleSubtitle(title: 'Title', subtitle: 'Subtitle'),
    'UnfocusArea': () => const UnfocusArea(child: Text('child')),
    'ThinHorizontalDivider': () => const ThinHorizontalDivider(),
    'AppCard': () => AppCard(onTap: () {}, child: const Text('card')),
    'GroupedRowsCard + AppListTile': () => GroupedRowsCard(
      children: [
        AppListTile(title: 'Row', subtitle: 'Sub', value: 'v', onTap: () {}),
        const AppListTile(title: 'Danger', danger: true),
      ],
    ),
    'StatusPill': () => Builder(
      builder: (context) => StatusPill(
        label: 'Done',
        color: ThemeProvider.of(context).theme.success,
      ),
    ),
    'SafeVerticalBox': () => const SafeVerticalBox(height: 20),
    'FillRemainingScrollView': () =>
        const FillRemainingScrollView(child: Text('content')),
    'StackAnimatedSwitcher': () =>
        const StackAnimatedSwitcher(child: Text('content')),
    'PaginatedListView (loaded, end reached)': () => PaginatedListView<int>(
      data: const PaginatedData(
        page: 1,
        pagesCount: 1,
        items: [1, 2, 3],
        itemsCount: 3,
        perPage: 3,
      ),
      status: BlocLoadState.loaded,
      onLoadMore: () {},
      itemBuilder: (context, item, index) => Text('$item'),
    ),
    'PaginatedListView (loading more)': () => PaginatedListView<int>(
      data: const PaginatedData(
        page: 1,
        pagesCount: 2,
        items: [1, 2, 3],
        itemsCount: 6,
        perPage: 3,
      ),
      status: BlocLoadState.loading,
      onLoadMore: () {},
      itemBuilder: (context, item, index) => Text('$item'),
    ),
    'BaseAppBar': () =>
        const Scaffold(appBar: BaseAppBar(height: 52, child: Text('Custom'))),
    'BulletedTextList': () => const BulletedTextList(texts: ['One', 'Two']),
    'AutoFormattedText': () =>
        const AutoFormattedText('Pay **now**', tag: '**'),
    'InputAccessoryViewWrapper': () =>
        const InputAccessoryViewWrapper(child: Text('form')),
    'AppCupertinoDatePicker': () => SizedBox(
      height: 190,
      child: AppCupertinoDatePicker(
        selectedDate: DateTime(2024, 3, 15),
        onSelectedItemChanged: (_) {},
      ),
    ),
    'AppDropdownField': () => const FormBuilder(
      child: AppDropdownField<String>(
        name: 'fruit',
        label: 'Fruit',
        options: ['Apple', 'Pear'],
        initialValue: 'Pear',
      ),
    ),
    'AppDatePickerField': () => const FormBuilder(
      child: AppDatePickerField(name: 'date', label: 'Date'),
    ),
    'AppTimePickerField': () => const FormBuilder(
      child: AppTimePickerField(name: 'time', label: 'Time'),
    ),
    'MultiBlocRefreshIndicator': () => MultiBlocRefreshIndicator(
      blocs: [_FakeRefreshableBloc()],
      onRefresh: () async {},
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [Text('row')],
      ),
    ),
  };

  // These render an endless spinner animation, so pumpAndSettle would hang.
  const endlessAnimationCases = {
    'CustomCircularProgressIndicator',
    'PaginatedListView (loading more)',
  };

  smokeCases.forEach(
    (name, build) => testWidgets('$name builds', (tester) async {
      await tester.pumpWidget(wrapWidget(build()));

      if (endlessAnimationCases.contains(name)) {
        await tester.pump(const Duration(milliseconds: 300));
      } else {
        await tester.pumpAndSettle();
      }

      expect(tester.takeException(), isNull);
    }),
  );
}
