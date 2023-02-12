import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;

class WoPView extends WatchUi.View {

    private var _textTop;
    private var textTop;
    private var textWoP;
    private var _currentWoP;
    private var _currentWoPLabel;
    private var _countdownDaysLabel;
    private var _countdownDays;
    private var _dateOfBirth;
    private var _trimesterLabel;
    private var center_x;
    private var center_y;
    private var sAppTitle;

    var calculator = new WoPcalcDates();

    function initialize() {
        View.initialize();

        textTop = WatchUi.loadResource(Rez.Strings.text_top);
        textWoP = WatchUi.loadResource(Rez.Strings.wop);
        sAppTitle = WatchUi.loadResource(Rez.Strings.view_title);
        calculator.setDateOfBirth();

    }

    // Load your resources here
    function onLayout(dc) as Void {
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
        calculator.setDateOfBirth();
        _dateOfBirth = calculator.getDateOfBirth();
        var today = calculator.getToday();
        // calculate countdown and set text
        _textTop.setText(textTop);
        _countdownDays = calculator.calculateCountdown(_dateOfBirth, today);
        _countdownDaysLabel.setText("Noch " + _countdownDays + " Tage" );

        //calculate week an set text
        _currentWoP = calculator.getDates();
        _currentWoPLabel.setText(_currentWoP.get(:week)+ " " + textWoP + " ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")"));
        _trimesterLabel.setText("Im " + _currentWoP.get(:trimester) + ". Trimester");
    }

    // Update the view
    function onUpdate(dc) as Void {
         // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        circleStatus(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {

    }

    // drawing the grey arc and the status of pregancy as arc
    function circleStatus(dc) {
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        var radius;
        if (center_x < center_y) {
            radius = center_x-3;
        } 
        else {
            radius = center_y-3;
        }

        //draw 1 gray arcs
        dc.setPenWidth(((dc.getWidth()/25)).toNumber());
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 0, 360);
        // draw week on arc 
        var angle = _currentWoP.get(:angle);
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.setPenWidth(((dc.getWidth()/20)).toNumber());
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, angle);
        
        System.println("Angle: " + (_currentWoP.get(:angle)));
        // draw 3 black rectangle to seperate grey arc
        dc.setPenWidth(((dc.getWidth()/10)).toNumber());
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 236, 232);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, 340);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 92, 88);
        dc.setPenWidth(((dc.getWidth()/10)).toNumber());
        // draw white arc for current week on the circle
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle+3, angle-3);

    }

}