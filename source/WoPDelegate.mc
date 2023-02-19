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

    function onSelect() {
        WatchUi.pushView(new WoPView2(), new WoPDelegate2(), WatchUi.SLIDE_UP);
        return true;
    }

    function onBack() {
	//pop the main view to close the application
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	return true;
    }
}