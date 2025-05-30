import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Properties;

var itemBirthday;
var itemWOPSetting;
var itemTrimester2Setting;
var itemTrimester3Setting;
var itemInfo;
var subLabel_birthday;
var sublabel_wopSetting;
var subLabel_tri2;
var subLabel_tri3;

class MenuSettingsView extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title=>new $.DrawableMenuTitle()});

        subLabel_birthday = Properties.getValue("day")+"."+Properties.getValue("month")+"."+Properties.getValue("year");
        itemBirthday = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.set_birthday), subLabel_birthday, "birthday", null);
        if (Properties.getValue("weekSetting") == 1) {
            sublabel_wopSetting = WatchUi.loadResource(Rez.Strings.SettingsArea0);
        } else if (Properties.getValue("weekSetting") == 0) {
            sublabel_wopSetting = WatchUi.loadResource(Rez.Strings.SettingsArea1);
        }
        itemWOPSetting = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.wop_Settings), sublabel_wopSetting, "settings", null);
        subLabel_tri2 = "Week: " + Properties.getValue("trimester2start");
        itemTrimester2Setting = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.trimester2_settings), subLabel_tri2, "triSetting2", null);
        subLabel_tri3 ="Week: " +  Properties.getValue("trimester3start");
        itemTrimester3Setting = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.trimester3_settings), subLabel_tri3, "triSetting3", null);

        itemInfo = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.info), null, "info", null);
        Menu2.addItem(itemBirthday);
        Menu2.addItem(itemWOPSetting);
        Menu2.addItem(itemTrimester2Setting);
        Menu2.addItem(itemTrimester3Setting);
        Menu2.addItem(itemInfo);
	}

    function onShow() as Void {
        subLabel_birthday = Properties.getValue("day")+"."+Properties.getValue("month")+"."+Properties.getValue("year");
        itemBirthday = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.set_birthday), subLabel_birthday, "birthday", null);
        if (Properties.getValue("weekSetting") == 1) {
            sublabel_wopSetting = WatchUi.loadResource(Rez.Strings.SettingsArea0);
        } else if (Properties.getValue("weekSetting") == 0) {
            sublabel_wopSetting = WatchUi.loadResource(Rez.Strings.SettingsArea1);
        }
        itemWOPSetting = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.wop_Settings), sublabel_wopSetting, "settings", null);
        subLabel_tri2 = "Week: " + Properties.getValue("trimester2start");
        itemTrimester2Setting = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.trimester2_settings), subLabel_tri2, "triSetting2", null);
        subLabel_tri3 ="Week: " +  Properties.getValue("trimester3start");
        itemTrimester3Setting = new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.trimester3_settings), subLabel_tri3, "triSetting3", null);

        Menu2.updateItem(itemBirthday, 0);
        Menu2.updateItem(itemWOPSetting, 1);
        Menu2.updateItem(itemTrimester2Setting, 2);
        Menu2.updateItem(itemTrimester3Setting, 3);

	}
}

//! This is the menu input delegate for the main menu of the application
class Menu2Delegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("birthday")) {
            WatchUi.pushView(new DatePicker(), new DatePickerDelegate(), WatchUi.SLIDE_LEFT );
        } 
        else if (id.equals("settings")) {
            $.pushBasicCustom();
        }
        else if (id.equals("triSetting2")) {
            WatchUi.pushView(new NumberPicker(12, 14), new NumberPickerDelegate(), WatchUi.SLIDE_LEFT );
        } 
        else if (id.equals("triSetting3")) {
            WatchUi.pushView(new NumberPicker(26, 29), new NumberPickerDelegate(), WatchUi.SLIDE_LEFT );
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

