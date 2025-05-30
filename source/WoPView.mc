import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;
import Toybox.Application.Properties;

class WoPView extends WatchUi.View {

    private var _textTop;
    private var _currentWoP;
    private var _currentWoPLabel;
    private var _countdownDaysLabel;
    private var _countdownDays;
    private var _dateOfBirth;
    private var _trimesterLabel;
    private var center_x;
    private var center_y;
    var trimester;
    var calculator;
    var drawer;
    var dialog;

    function initialize(mCalc, mDrawer) {
        drawer = mDrawer;
        calculator = mCalc;
        calculator.getDateOfBirth();
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        if (Properties.getValue("dateSet") == 0 ) {
            var message = WatchUi.loadResource(Rez.Strings.PopUpMessage);
            dialog = new WatchUi.Confirmation(message);
            WatchUi.pushView(dialog,new MyConfirmationDelegate(),WatchUi.SLIDE_IMMEDIATE);
        }
    // set layout and
        setLayout(Rez.Layouts.MainLayout(dc));
        _textTop = findDrawableById("textTop");
        _currentWoPLabel = findDrawableById("week");
        _countdownDaysLabel = findDrawableById("countdown");
        _trimesterLabel = findDrawableById("trimester");
        center_x = dc.getWidth()/2;
        center_y = dc.getHeight()/2;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _dateOfBirth = calculator.getDateOfBirth();
        var today = calculator.getToday();
        // calculate countdown and set text
        _textTop.setText(WatchUi.loadResource(Rez.Strings.text_top));
        _countdownDays = calculator.calculateCountdown(_dateOfBirth, today);
        _countdownDaysLabel.setText(WatchUi.loadResource(Rez.Strings.text_countdown1) + _countdownDays + WatchUi.loadResource(Rez.Strings.text_countdown2) );

        //calculate week an set text
        _currentWoP = calculator.getDates();
        _currentWoPLabel.setText(_currentWoP.get(:week) + WatchUi.loadResource(Rez.Strings.wop) + " ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")"));
        
        trimester = _currentWoP.get(:trimester);
        switch (trimester){
            case 1:
                _trimesterLabel.setColor(Graphics.COLOR_RED);
                _trimesterLabel.setText(trimester + WatchUi.loadResource(Rez.Strings.first) + WatchUi.loadResource(Rez.Strings.trimester));
                break;
            case 2:
                _trimesterLabel.setColor(Graphics.COLOR_YELLOW);
                _trimesterLabel.setText(trimester + WatchUi.loadResource(Rez.Strings.second) + WatchUi.loadResource(Rez.Strings.trimester));
                break;
            case 3:
                _trimesterLabel.setColor(Graphics.COLOR_GREEN);
                _trimesterLabel.setText(trimester + WatchUi.loadResource(Rez.Strings.third) + WatchUi.loadResource(Rez.Strings.trimester));
                break;
            case 0 :
                _trimesterLabel.setColor(Graphics.COLOR_WHITE);
                _textTop.setText("");
                _currentWoPLabel.setText(WatchUi.loadResource(Rez.Strings.text_wrong_date1));
                _trimesterLabel.setText(WatchUi.loadResource(Rez.Strings.text_wrong_date2));
                _countdownDaysLabel.setText(WatchUi.loadResource(Rez.Strings.text_wrong_date3));
                break;
        }
    }

    // Update the view
    function onUpdate(dc) as Void {
         // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        drawer.drawStatusCircle(dc, center_x, center_y, trimester, _currentWoP.get(:angle),_currentWoP.get(:tri2angle), _currentWoP.get(:tri3angle));
    }


    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}