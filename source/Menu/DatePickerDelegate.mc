
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;



//! Responds to a date picker selection or cancellation
class DatePickerDelegate extends WatchUi.PickerDelegate {



    var monthDict as Dictionary = { 
        WatchUi.loadResource(Rez.Strings.month01) => 1,
        WatchUi.loadResource(Rez.Strings.month02) => 2,
        WatchUi.loadResource(Rez.Strings.month03) => 3,
        WatchUi.loadResource(Rez.Strings.month04) => 4,
        WatchUi.loadResource(Rez.Strings.month05) => 5,
        WatchUi.loadResource(Rez.Strings.month06) => 6,
        WatchUi.loadResource(Rez.Strings.month07) => 7,
        WatchUi.loadResource(Rez.Strings.month08) => 8,
        WatchUi.loadResource(Rez.Strings.month09) => 9,
        WatchUi.loadResource(Rez.Strings.month10) => 10,
        WatchUi.loadResource(Rez.Strings.month11) => 11,
        WatchUi.loadResource(Rez.Strings.month12) => 12,
        } as Dictionary;


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
        //var separator = WatchUi.loadResource($.Rez.Strings.dateSeparator) as String;
        var monthResource = values[0];
        if (monthResource != null) {
            var month = WatchUi.loadResource(monthResource) as String;
            var day = values[2];
            var year = values[4];
            if ((day != null) && (year != null)) {
                Properties.setValue("day", day);
                Properties.setValue("month", convertMonth(month as String));
                Properties.setValue("year", year);
                Properties.setValue("dateSet", 1);
            }
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }


    private function convertMonth(month as String) {
        return monthDict[month] as Dictionary;
    }

}
