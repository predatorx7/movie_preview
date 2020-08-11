import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A reusable, modal dialog
class Loading {
  BuildContext _dialogcontext;

  /// Shows a modal dialog representing loading
  show(BuildContext context) {
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _dialogcontext = context;
        return WillPopScope(
          onWillPop: () async => false,
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(
                  Size.fromRadius(60),
                ),
                child: Material(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(25),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Dismisses the dialog created by this Object
  void hide() {
    if (_dialogcontext == null) {
      return;
    }
    Navigator.of(_dialogcontext).pop();
  }
}
