
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;


//! Responds to a date picker selection or cancellation
class NumberPickerDelegate extends WatchUi.PickerDelegate {



    //! Constructor
    public function initialize() {
        PickerDelegate.initialize();
    }

    //! Handle a cancel event from the picker
    //! @return true if handled, false otherwise
    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    //! Handle a confirm event from the picker
    //! @param values The values chosen in the picker
    //! @return true if handled, false otherwise
    public function onAccept(values) as Boolean {
        if(values[0] < 25) {
            Properties.setValue("trimester2start", values[0]);
        } 
        else  {
            Properties.setValue("trimester3start", values[0]);
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}
