import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Properties;



class MenuSettingsView extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title=>new $.DrawableMenuTitle()});

        var subLabel = Properties.getValue("day")+"."+Properties.getValue("month")+"."+Properties.getValue("year");
        Menu2.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.set_birthday), subLabel, "birthday", null));
        Menu2.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.info), null, "info", null));
	}
}



//! This is the menu input delegate for the main menu of the application
class Menu2Delegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize(p) {
        Menu2InputDelegate.initialize();
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("birthday")) {
            WatchUi.pushView(new DatePicker(), new DatePickerDelegate(), WatchUi.SLIDE_LEFT );
        } 
        else if (id.equals("info")) {
            WatchUi.pushView(new AboutView(), new AboutDelegate(), WatchUi.SLIDE_LEFT );
        } 
        else {
            WatchUi.requestUpdate();
        }
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.requestUpdate();
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}

