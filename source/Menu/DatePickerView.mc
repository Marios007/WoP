//! Picker that allows the user to choose a date
import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;


class DatePicker extends WatchUi.Picker {

    //! Constructor
    public function initialize() {
        var months = [$.Rez.Strings.month01, $.Rez.Strings.month02, $.Rez.Strings.month03,
                      $.Rez.Strings.month04, $.Rez.Strings.month05, $.Rez.Strings.month06,
                      $.Rez.Strings.month07, $.Rez.Strings.month08, $.Rez.Strings.month09,
                      $.Rez.Strings.month10, $.Rez.Strings.month11, $.Rez.Strings.month12] as Array<Symbol>;
        var title = new WatchUi.Text({:text=>$.Rez.Strings.datePickerTitle, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,:font=>Graphics.FONT_SYSTEM_TINY, :color=>Graphics.COLOR_WHITE});
        var separator = new WatchUi.Text({:text=>$.Rez.Strings.dateSeparator, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
        Picker.initialize({:title=>title, :pattern=>[new $.WordFactory(months, {:font=>Graphics.FONT_SYSTEM_TINY}), separator, new $.NumberFactory(1, 31, 1, {:font=>Graphics.FONT_NUMBER_MEDIUM}),
            separator, new $.NumberFactory(2023, 2025, 1, {:font=>Graphics.FONT_SYSTEM_TINY})]});
    }

    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}