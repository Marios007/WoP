//! Picker that allows the user to choose a date
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Properties;


class DatePicker extends WatchUi.Picker {

    var months = [] ;
    //! Constructor
    //! @param mode :dueDate to pick the date of birth, :lmp to pick the last period
    public function initialize(mode as Symbol) {
         months = [$.Rez.Strings.month01, $.Rez.Strings.month02, $.Rez.Strings.month03,
                      $.Rez.Strings.month04, $.Rez.Strings.month05, $.Rez.Strings.month06,
                      $.Rez.Strings.month07, $.Rez.Strings.month08, $.Rez.Strings.month09,
                      $.Rez.Strings.month10, $.Rez.Strings.month11, $.Rez.Strings.month12] ;
        var titleText = (mode == :lmp) ? $.Rez.Strings.lmpPickerTitle : $.Rez.Strings.datePickerTitle;
        var yearStart = (mode == :lmp) ? 2025 : 2026;
        var yearStop = 2030;
        var title = new WatchUi.Text({:text=>titleText, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,:font=>Graphics.FONT_SYSTEM_TINY, :color=>Graphics.COLOR_WHITE});
        var separator = new WatchUi.Text({:text=>$.Rez.Strings.dateSeparator, :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});

        //preselect the currently stored date
        var day; var month; var year;
        if (mode == :lmp) {
            day = Properties.getValue("lmpDay");
            month = Properties.getValue("lmpMonth");
            year = Properties.getValue("lmpYear");
        } else {
            day = Properties.getValue("day");
            month = Properties.getValue("month");
            year = Properties.getValue("year");
        }
        var yearIndex = year - yearStart;
        if (yearIndex < 0) { yearIndex = 0; }
        if (yearIndex > yearStop - yearStart) { yearIndex = yearStop - yearStart; }

        Picker.initialize({:title=>title, :pattern=>[new $.WordFactory(months as Array, {:font=>Graphics.FONT_SYSTEM_TINY}), separator, new $.NumberFactory(1, 31, 1, {:font=>Graphics.FONT_NUMBER_MEDIUM}),
            separator, new $.NumberFactory(yearStart, yearStop, 1, {:font=>Graphics.FONT_SYSTEM_TINY})],
            :defaults=>[month - 1, 0, day - 1, 0, yearIndex]});
    }

    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}
