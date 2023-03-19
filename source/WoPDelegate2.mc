using Toybox.WatchUi;
import Toybox.Application.Properties;


class WoPDelegate2 extends WatchUi.BehaviorDelegate {
    
    var model;
    
        // Set up the callback to the view
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }
    
    function onNextPage() {
        WatchUi.pushView(new WoPView3(), new WoPDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onMenu() {
    // Generate a new Menu with a drawable Title
        menu = new WatchUi.Menu2({:title=>new $.DrawableMenuTitle()});

        var subLabel = Properties.getValue("day")+"."+Properties.getValue("month")+"."+Properties.getValue("year");
        menu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.set_birthday), subLabel, "birthday", null));
        menu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.info), null, "info", null));
        WatchUi.pushView(menu, new $.Menu2Delegate(menu.getItem(0)), WatchUi.SLIDE_LEFT);
        return true;
    }

    function onPreviousPage() {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }

    function onBack() {
	//pop the main view to close the application
	WatchUi.popView(WatchUi.SLIDE_DOWN);
	return true;
    }
}