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
    var center_x; 
    var center_y; 

    var calculator = new WoPcalcDates();

    function initialize() {
        View.initialize();

        sAppTitle = WatchUi.loadResource(Rez.Strings.view_title);
        textTop = WatchUi.loadResource(Rez.Strings.text_top);
        textWoP = WatchUi.loadResource(Rez.Strings.wop);
        calculator.setDateOfBirth();
        

    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _textTop = findDrawableById("textTop");
        _currentWoPLabel = findDrawableById("week");
        _countdownDaysLabel = findDrawableById("countdown");
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
        _textTop.setText(textTop);

        _countdownDays = calculator.calculateCountdown(_dateOfBirth, today);
        _countdownDaysLabel.setText("Noch " + _countdownDays + " Tage" );

        //calculate week an set text
        _currentWoP = calculator.getDates(_dateOfBirth, today);
        _currentWoPLabel.setText(_currentWoP.get(:week)+ " " + textWoP + " ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")"));



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

    function circleStatus(dc) {
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        var radius;
        if (center_x < center_y) {
            radius = center_x-3;
            } 
        else {
            radius = center_y-3;
            }
        //draw 3 gray arcs
        dc.setPenWidth(((dc.getWidth()/25)).toNumber());
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 0, 360);
        //dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 328, 214);
        //dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 206, 94);
    
        dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_BLACK);
        dc.setPenWidth(((dc.getWidth()/20)).toNumber());
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, _currentWoP.get(:angle));
        System.println("Angle: " + (_currentWoP.get(:angle)));

        dc.setPenWidth(((dc.getWidth()/10)).toNumber());
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 236, 232);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, 340);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 92, 88);
    }

}