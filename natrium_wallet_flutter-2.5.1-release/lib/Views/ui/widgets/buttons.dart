import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/Controllers/appstate_container.dart';
import 'package:natrium_wallet_flutter/styles.dart';
import 'package:natrium_wallet_flutter/Views/ui/util/exceptions.dart';
import 'package:natrium_wallet_flutter/Views/ui/widgets/outline_button.dart';
import 'package:natrium_wallet_flutter/Views/ui/widgets/flat_button.dart';

enum AppButtonType {
  PRIMARY,
  PRIMARY_OUTLINE,
  SUCCESS,
  SUCCESS_OUTLINE,
  TEXT_OUTLINE
}

class AppButton {
  // Primary button builder
  static Widget buildAppButton(BuildContext context, AppButtonType type,
      String buttonText, List<double> dimens,
      {Function onPressed, bool disabled = false}) {
    final theme = StateContainer.of(context).curTheme;
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      boxShadow: [theme.boxShadowButton],
    );
    final margin = EdgeInsetsDirectional.fromSTEB(
        dimens[0], dimens[1], dimens[2], dimens[3]);

    switch (type) {
      case AppButtonType.PRIMARY:
        return _buildButtonContainer(
          context,
          decoration,
          margin,
          disabled ? theme.primary60 : theme.primary,
          disabled ? theme.background40 : theme.background40,
          buttonText,
          AppStyles.textStyleButtonPrimary(context),
          onPressed,
          disabled,
        );
      case AppButtonType.PRIMARY_OUTLINE:
        return _buildOutlineButtonContainer(
          context,
          theme.backgroundDark,
          margin,
          disabled ? theme.primary60 : theme.primary,
          disabled ? theme.primary60 : theme.primary,
          buttonText,
          disabled
              ? AppStyles.textStyleButtonPrimaryOutlineDisabled(context)
              : AppStyles.textStyleButtonPrimaryOutline(context),
          onPressed,
          disabled,
        );
      case AppButtonType.SUCCESS:
        return _buildButtonContainer(
          context,
          decoration,
          margin,
          theme.success,
          theme.success30,
          buttonText,
          AppStyles.textStyleButtonPrimaryGreen(context),
          onPressed,
          disabled,
        );
      case AppButtonType.SUCCESS_OUTLINE:
        return _buildOutlineButtonContainer(
          context,
          theme.backgroundDark,
          margin,
          theme.success,
          theme.success,
          buttonText,
          AppStyles.textStyleButtonSuccessOutline(context),
          onPressed,
          disabled,
        );
      case AppButtonType.TEXT_OUTLINE:
        return _buildOutlineButtonContainer(
          context,
          theme.backgroundDark,
          margin,
          theme.text,
          theme.text,
          buttonText,
          AppStyles.textStyleButtonTextOutline(context),
          onPressed,
          disabled,
        );
      default:
        throw UIException("Invalid Button Type $type");
    }
  }

  static Widget _buildButtonContainer(
      BuildContext context,
      BoxDecoration decoration,
      EdgeInsetsGeometry margin,
      Color color,
      Color splashColor,
      String buttonText,
      TextStyle textStyle,
      Function onPressed,
      bool disabled) {
    return Expanded(
      child: Container(
        decoration: decoration,
        height: 55,
        margin: margin,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          color: color,
          child: AutoSizeText(
            buttonText,
            textAlign: TextAlign.center,
            style: textStyle,
            maxLines: 1,
            stepGranularity: 0.5,
          ),
          onPressed: () {
            if (onPressed != null && !disabled) {
              onPressed();
            }
          },
          highlightColor: splashColor,
          splashColor: splashColor,
        ),
      ),
    );
  }

  static Widget _buildOutlineButtonContainer(
      BuildContext context,
      Color backgroundColor,
      EdgeInsetsGeometry margin,
      Color borderColor,
      Color highlightColor,
      String buttonText,
      TextStyle textStyle,
      Function onPressed,
      bool disabled) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [StateContainer.of(context).curTheme.boxShadowButton],
        ),
        height: 55,
        margin: margin,
        child: OutlineButton(
          color: backgroundColor,
          textColor: borderColor,
          borderSide: BorderSide(
              color: borderColor, width: 2.0),
          highlightedBorderColor: borderColor,
          splashColor: StateContainer.of(context).curTheme.primary30,
          highlightColor: highlightColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          child: AutoSizeText(
            buttonText,
            textAlign: TextAlign.center,
            style: textStyle,
            maxLines: 1,
            stepGranularity: 0.5,
          ),
          onPressed: () {
            if (onPressed != null && !disabled) {
              onPressed();
            }
          },
        ),
      ),
    );
  }
}
