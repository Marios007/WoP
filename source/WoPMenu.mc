using Toybox.WatchUi;

class MyBehaviorDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        var menu = new WatchUi.Menu();
        var delegate;
        menu.setTitle(WatchUi.loadResource(Rez.Strings.menu_name));
        menu.addItem(WatchUi.loadResource(Rez.Strings.set_birthday), :one);
        menu.addItem(WatchUi.loadResource(Rez.Strings.info), :two);
        
        delegate = new MyMenuInputDelegate(); // a WatchUi.MenuInputDelegate

        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        
        return true;
    }
}