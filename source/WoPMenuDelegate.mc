using Toybox.WatchUi;
using Toybox.System;
import Toybox.Application.Storage;

class MyMenuInputDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :one) {
            WatchUi.pushView(new DatePicker(), new DatePickerDelegate(), WatchUi.SLIDE_IMMEDIATE );
        } else if (item == :two) {
            WatchUi.pushView(new AboutView(), new AboutDelegate(), WatchUi.SLIDE_IMMEDIATE );
            return;

        }
    }
}