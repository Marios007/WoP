using Toybox.WatchUi;
import Toybox.Application.Properties;


class WoPDelegate2 extends WatchUi.BehaviorDelegate {
    
    var model;
    
        // Set up the callback to the view
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }
    
    function onNextPage() {
        WatchUi.pushView(new WoPView3(), new WoPDelegate3(), WatchUi.SLIDE_UP);
        return true;
    }

    function onMenu() {
        WatchUi.pushView(new MenuSettingsView(), new $.Menu2Delegate(model), WatchUi.SLIDE_LEFT);
        return true;
    }

    function onSelect() {
        WatchUi.pushView(new WoPView3(), new WoPDelegate3(), WatchUi.SLIDE_UP);
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