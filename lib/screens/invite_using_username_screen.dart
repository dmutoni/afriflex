import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_level.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_variant.dart';
import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/helpers/snackbar_helper.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/common/visual/afriflex_or_widget.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InviteUsingUsernameUsername extends ConsumerStatefulWidget {
  const InviteUsingUsernameUsername({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InviteUsingUsernameUsernameState();
}

class _InviteUsingUsernameUsernameState
    extends ConsumerState<InviteUsingUsernameUsername> {
  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
        backgroundColor: ThemeColors.whiteColor,
        title: 'Invite member',
        content: Container(
          padding: const EdgeInsets.all(
            16,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              children: [
                const Text(
                  'Invite a member using their username',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const AfriflexTextInput(
                  label: 'Input a username',
                ),
                AfriflexButton(
                  variant: AfriflexButtonVariant.clear,
                  title: 'Invite',
                  onTap: () {},
                ),
                const AfriflexOrWidget(),
                const Text('Generate a unique invite link'),
                const AfriflexOrWidget(),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(const ClipboardData(text: '@Tontine'));

                    SnackbarHelper.showSnackbar(
                      message: 'Copied to clipboard',
                      level: AfriflexTopSnackbarLevel.alert,
                      variant: AfriflexTopSnackbarVariant.message,
                      context: context,
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Copy & Share ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: '@Tontine ',
                          style: TextStyle(
                            color: ThemeColors.orangeColor,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: 'ID',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AfriflexButton(
                  title: 'Continue',
                  onTap: () {
                    context.pushNamed(
                      AfriflexRoutes.pendingRequestRoute,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
