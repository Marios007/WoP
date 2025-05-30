using Toybox.WatchUi;

class WoPDelegate2 extends WatchUi.BehaviorDelegate {
    
    var calculator;
    var drawer;
    
        // Set up the callback to the view
    function initialize(mCalc, mDrawer) {
        WatchUi.BehaviorDelegate.initialize();
        calculator = mCalc;
        drawer = mDrawer;
    }
    
    function onNextPage() {
        WatchUi.pushView(new WoPView3(calculator, drawer), new WoPDelegate3(calculator, drawer), WatchUi.SLIDE_UP);
        return true;
    }

    function onMenu() {
        WatchUi.pushView(new MenuSettingsView(), new $.Menu2Delegate(), WatchUi.SLIDE_LEFT);
        return true;
    }

    function onSelect() {
        WatchUi.pushView(new WoPView3(calculator, drawer), new WoPDelegate3(calculator, drawer), WatchUi.SLIDE_UP);
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
    function onHide() as Void {
        // Clean up resources when view is hidden
        calculator = null;
        drawer = null;
    }
}