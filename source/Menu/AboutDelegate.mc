using Toybox.WatchUi as Ui;
using Toybox.System;

class AboutDelegate extends Ui.BehaviorDelegate {

  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onSelect() {
    Ui.popView(SLIDE_LEFT);
    return true;
  }
}

