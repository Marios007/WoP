using Toybox.WatchUi;
using Toybox.System;

class MyMenuInputDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :one) {
            System.println("Item 1");
        } else if (item == :two) {
            WatchUi.pushView(new AboutView(), new AboutDelegate(), WatchUi.SLIDE_IMMEDIATE );
            return;

        }
    }
}