import Toybox.Application.Storage;
import Toybox.Application.Properties;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;



//! Responds to a date picker selection or cancellation
class DatePickerDelegate extends WatchUi.PickerDelegate {

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
    public function onAccept(values as Array<Number?>) as Boolean {
        //var separator = WatchUi.loadResource($.Rez.Strings.dateSeparator) as String;
        var monthResource = values[0];
        if (monthResource != null) {
            var month = WatchUi.loadResource(monthResource as Symbol) as String;
            var day = values[2];
            var year = values[4];
            if ((day != null) && (year != null)) {
                var date = month + day + year;
                Storage.setValue("day", day);
                Properties.setValue("day", day);
                Storage.setValue("month", convertMonth(month));
                Properties.setValue("month", convertMonth(month));
                Storage.setValue("year", year);
                Properties.setValue("year", year);

                Properties.setValue("dateSet", 1);
            }
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    private function convertMonth(month) {
        switch (month) {
            case WatchUi.loadResource(Rez.Strings.month01):
                return 1;
            case WatchUi.loadResource(Rez.Strings.month02):
                return 2;
            case WatchUi.loadResource(Rez.Strings.month03):
                return 3;
            case WatchUi.loadResource(Rez.Strings.month04):
                return 4;
            case WatchUi.loadResource(Rez.Strings.month05):
                return 5;
            case WatchUi.loadResource(Rez.Strings.month06):
                return 6;
            case WatchUi.loadResource(Rez.Strings.month07):
                return 7;
            case WatchUi.loadResource(Rez.Strings.month08):
                return 8;
            case WatchUi.loadResource(Rez.Strings.month09):
                return 9;
            case WatchUi.loadResource(Rez.Strings.month10):
                return 10;
            case WatchUi.loadResource(Rez.Strings.month11):
                return 11;
            case WatchUi.loadResource(Rez.Strings.month12):
                return 12;
            default:
                return 0;
        }   
    }
}
