using Toybox.WatchUi;

(:glance)
class WoPDelegate extends WatchUi.BehaviorDelegate {
    
    var model;
    
        // Set up the callback to the view
    function initialize(model) {
    	self.model = model;
        WatchUi.BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    	// update data
        //model.();
        return true;
    }


}