//!
//! Copyright 2016 by HarryOnline
//!
//! Show About
//!

using Toybox.WatchUi as Ui;
using Toybox.System;

class AboutDelegate extends Ui.BehaviorDelegate {

  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onSelect() {
    Ui.popView(SLIDE_IMMEDIATE);
    Ui.popView(SLIDE_IMMEDIATE);
    return true;
  }
}

