using Toybox.WatchUi;


class WoPDelegate3 extends WatchUi.BehaviorDelegate {
    
    var calculator;
    var drawer;
        // Set up the callback to the view
    function initialize(mCalc, mDrawer) {
        drawer = mDrawer;
        calculator = mCalc;
        WatchUi.BehaviorDelegate.initialize();
    }
    
    function onNextPage() {
        return true;
    }

    function onMenu() {
        WatchUi.pushView(new MenuSettingsView(), new $.Menu2Delegate(), WatchUi.SLIDE_LEFT);
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