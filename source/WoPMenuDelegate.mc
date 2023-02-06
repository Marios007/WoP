using Toybox.WatchUi;
using Toybox.System;

class MyMenuInputDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_1) {
            System.println("Item 1");
        } else if (item == :item_2) {
            System.println("Item 2");
        }
    }
}