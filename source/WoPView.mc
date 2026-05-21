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
    private var _strTextTop;
    private var _strCountdown1;
    private var _strCountdown2;
    private var _strWop;
    private var _strFirst;
    private var _strSecond;
    private var _strThird;
    private var _strTrimester;
    private var _strWrongDate1;
    private var _strWrongDate2;
    private var _strWrongDate3;

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
        _strTextTop    = WatchUi.loadResource(Rez.Strings.text_top);
        _strCountdown1 = WatchUi.loadResource(Rez.Strings.text_countdown1);
        _strCountdown2 = WatchUi.loadResource(Rez.Strings.text_countdown2);
        _strWop        = WatchUi.loadResource(Rez.Strings.wop);
        _strFirst      = WatchUi.loadResource(Rez.Strings.first);
        _strSecond     = WatchUi.loadResource(Rez.Strings.second);
        _strThird      = WatchUi.loadResource(Rez.Strings.third);
        _strTrimester  = WatchUi.loadResource(Rez.Strings.trimester);
        _strWrongDate1 = WatchUi.loadResource(Rez.Strings.text_wrong_date1);
        _strWrongDate2 = WatchUi.loadResource(Rez.Strings.text_wrong_date2);
        _strWrongDate3 = WatchUi.loadResource(Rez.Strings.text_wrong_date3);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _dateOfBirth = calculator.getDateOfBirth();
        var today = calculator.getToday();
        // calculate countdown and set text
        _textTop.setText(_strTextTop);
        _countdownDays = calculator.calculateCountdown(_dateOfBirth, today);
        _countdownDaysLabel.setText(_strCountdown1 + _countdownDays + _strCountdown2);

        //calculate week an set text
        _currentWoP = calculator.getDates();
        _currentWoPLabel.setText(_currentWoP.get(:week) + _strWop + " ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")"));

        trimester = _currentWoP.get(:trimester);
        switch (trimester){
            case 1:
                _trimesterLabel.setColor(Graphics.COLOR_RED);
                _trimesterLabel.setText(trimester + _strFirst + _strTrimester);
                break;
            case 2:
                _trimesterLabel.setColor(Graphics.COLOR_YELLOW);
                _trimesterLabel.setText(trimester + _strSecond + _strTrimester);
                break;
            case 3:
                _trimesterLabel.setColor(Graphics.COLOR_GREEN);
                _trimesterLabel.setText(trimester + _strThird + _strTrimester);
                break;
            case 0 :
                _trimesterLabel.setColor(Graphics.COLOR_WHITE);
                _textTop.setText("");
                _currentWoPLabel.setText(_strWrongDate1);
                _trimesterLabel.setText(_strWrongDate2);
                _countdownDaysLabel.setText(_strWrongDate3);
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