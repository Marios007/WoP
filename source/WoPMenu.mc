using Toybox.WatchUi;

class MyBehaviorDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        var menu = new WatchUi.Menu();
        var delegate;
        menu.setTitle("My Menu");
        menu.addItem("Item One", :one);
        menu.addItem("Item Two", :two);
        delegate = new MyMenuInputDelegate(); // a WatchUi.MenuInputDelegate
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}