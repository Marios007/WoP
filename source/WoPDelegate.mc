using Toybox.WatchUi;

(:glance)
class WoPDelegate extends WatchUi.BehaviorDelegate {
    
    var model;

    // Set up the callback to the view
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }

    function onNextPage() {
        WatchUi.pushView(new WoPView2(), new WoPDelegate2(), WatchUi.SLIDE_UP);
        return true;
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

    function onSelect() {
        WatchUi.pushView(new WoPView2(), new WoPDelegate2(), WatchUi.SLIDE_UP);
        return true;
    }

}