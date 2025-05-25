//! Picker that allows the user to choose a date
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;


class NumberPicker extends WatchUi.Picker {

    //! Constructor
    public function initialize(start, end) {
        var title = new WatchUi.Text({:text=>"Select Number", :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM,:font=>Graphics.FONT_SYSTEM_TINY, :color=>Graphics.COLOR_WHITE});
        
        Picker.initialize({:title=>title, :pattern=>[new $.NumberFactory(start, end, 1, {:font=>Graphics.FONT_NUMBER_MEDIUM})]});
    }

    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
    
}