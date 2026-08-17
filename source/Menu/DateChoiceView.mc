import Toybox.Lang;
import Toybox.WatchUi;

//! First-run menu that lets the user choose whether to enter
//! the date of birth or the date of the last period
class DateChoiceMenu extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title=>WatchUi.loadResource(Rez.Strings.dateChoiceTitle)});
        Menu2.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.group1Title), null, "dueDate", null));
        Menu2.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.lmpPickerTitle), null, "lmp", null));
    }
}

class DateChoiceDelegate extends WatchUi.Menu2InputDelegate {

    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("lmp")) {
            WatchUi.pushView(new DatePicker(:lmp), new DatePickerDelegate(:lmp), WatchUi.SLIDE_LEFT );
        } else {
            WatchUi.pushView(new DatePicker(:dueDate), new DatePickerDelegate(:dueDate), WatchUi.SLIDE_LEFT );
        }
    }

    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
