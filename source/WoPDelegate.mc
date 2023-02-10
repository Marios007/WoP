using Toybox.WatchUi;

(:glance)
class WoPDelegate extends WatchUi.BehaviorDelegate {
    
    var model;
    
        // Set up the callback to the view
    function initialize(model) {
    	self.model = model;
        WatchUi.BehaviorDelegate.initialize();
    }
    
    function onNextPage() {
        return true;
    }
    
    function onSelect() {
    	// update data
        //model.();
        return true;
    }

    function onBack() {
	//pop the main view to close the application
	WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
	return true;
    }
}