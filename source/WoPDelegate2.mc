using Toybox.WatchUi;

(:glance)
class WoPDelegate2 extends WatchUi.BehaviorDelegate {
    
    var model;
    
        // Set up the callback to the view
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }
    
    function onNextPage() {
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