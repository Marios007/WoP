import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;

class WoPView extends WatchUi.View {

    private var sAppTitle;
    private var _textTop;
    private var textTop;
    private var textWoP;
    private var _currentWoP;
    private var _currentWoPLabel;
    private var _countdownDaysLabel;
    private var _countdownDays;
    private var _dateOfBirth;
    private var _durationPregnancy = new Time.Duration(24192000) ; //280d in sec
    var calculator = new WoPcalcDates();

    function initialize() {
        
        sAppTitle = WatchUi.loadResource(Rez.Strings.view_title);
        textTop = WatchUi.loadResource(Rez.Strings.text_top);
        textWoP = WatchUi.loadResource(Rez.Strings.wop);
        calculator.setDateOfBirth();
        View.initialize();

    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _textTop = findDrawableById("textTop");
        _currentWoPLabel = findDrawableById("week");
        _countdownDaysLabel = findDrawableById("countdown");
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {

        _dateOfBirth = calculator.getDateOfBirth();
        var today = calculator.getToday();
        // calculate countdown and set text
        _textTop.setText(textTop);

        _countdownDays = calculator.calculateCountdown(_dateOfBirth, today);
        _countdownDaysLabel.setText("Noch " + _countdownDays + " Tage" );

        //calculate week an set text
        _currentWoP = calculator.getDates(_dateOfBirth, today);
        _currentWoPLabel.setText(_currentWoP.get(:week)+ " " + textWoP + " ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")"));

    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {

    }

}