using Toybox.WatchUi;
import Toybox.Application;


var model;

class MyConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response){
        if (response == WatchUi.CONFIRM_NO) {
            return false;
        } 
        else {
            WatchUi.switchToView(new DatePicker(), new DatePickerDelegate(), WatchUi.SLIDE_LEFT );
            WatchUi.pushView(new DatePicker(), new DatePickerDelegate(), WatchUi.SLIDE_LEFT );
            return true;
        }
    }
}