import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;

class WoPView3 extends WatchUi.View {

    private var _textTop;
    private var _currentWoP;
    private var _currentWoPLabel;
    private var _countdownDaysLabel;
    private var _countdownDays;
    private var _dateOfBirth;
    private var _trimesterLabel;
    private var center_x;
    private var center_y;
    var calculator = new WoPcalcDates();
    var stats = new WoPstats();

    function initialize() {
        View.initialize();
        calculator.getDateOfBirth();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.MainLayoutNew(dc));

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
        _textTop.setText(WatchUi.loadResource(Rez.Strings.text_top));
        _countdownDays = calculator.calculateCountdown(_dateOfBirth, today);
        //calculate week an set text
        _currentWoP = calculator.getDates();
    }

    // Update the view
    function onUpdate(dc) as Void {
         // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        drawText(dc);
        circleStatus(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function drawText(dc) {
        var spacing = 2;
        var weekNumberWidth = dc.getTextWidthInPixels(_currentWoP.get(:week).toString(), Graphics.FONT_MEDIUM);
        var textWopWidth = dc.getTextWidthInPixels(WatchUi.loadResource(Rez.Strings.wop), Graphics.FONT_XTINY);
        var exactWeekWidth = dc.getTextWidthInPixels(" ("+ (_currentWoP.get(:exactWeek)+"W + "), Graphics.FONT_MEDIUM);
        var exactDayWidth = dc.getTextWidthInPixels(_currentWoP.get(:dayInWeek) +")",Graphics.FONT_SMALL);
        var label1X = (dc.getWidth() - (weekNumberWidth + spacing + textWopWidth + spacing + exactWeekWidth + spacing + exactDayWidth)) / 2;
        var label2X = label1X + weekNumberWidth  + spacing;
        var label3X = label2X + textWopWidth  + spacing;
        System.println("DrawText");
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(label1X, dc.getHeight()/2, Graphics.FONT_MEDIUM, _currentWoP.get(:week), Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(label2X, dc.getHeight()/2,Graphics.FONT_XTINY, WatchUi.loadResource(Rez.Strings.wop), Graphics.TEXT_JUSTIFY_LEFT| Graphics.TEXT_JUSTIFY_VCENTER );
        dc.drawText(label3X, dc.getHeight()/2,Graphics.FONT_MEDIUM, " ("+ (_currentWoP.get(:exactWeek)+"W + "), Graphics.TEXT_JUSTIFY_LEFT| Graphics.TEXT_JUSTIFY_VCENTER);


    }


    // drawing the grey arc and the status of pregnancy as arc
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
        dc.setPenWidth(((dc.getWidth()/32)).toNumber());
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 0, 360);
        // draw week on arc 
        var angle = _currentWoP.get(:angle);
        dc.setPenWidth(((dc.getWidth()/25)).toNumber());
        switch (_currentWoP.get(:trimester)) {
            case 1:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, angle);
                //_trimesterLabel.setColor(Graphics.COLOR_RED);
                //_trimesterLabel.setText( _currentWoP.get(:trimester) + WatchUi.loadResource(Rez.Strings.first) + WatchUi.loadResource(Rez.Strings.trimester));
                break;
            case 2:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, 342);
                dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, angle);
                //_trimesterLabel.setColor(Graphics.COLOR_YELLOW);
                //_trimesterLabel.setText( _currentWoP.get(:trimester) + WatchUi.loadResource(Rez.Strings.second) + WatchUi.loadResource(Rez.Strings.trimester));
                break;
            case 3:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, 342);
                dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, 236);
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 232, angle);
                //_trimesterLabel.setColor(Graphics.COLOR_GREEN);
                //_trimesterLabel.setText( _currentWoP.get(:trimester) + WatchUi.loadResource(Rez.Strings.third) + WatchUi.loadResource(Rez.Strings.trimester));
                break;
            case 4:
                break;
        }

        // draw 3 black rectangle to seperate grey arc
        dc.setPenWidth(((dc.getWidth()/15)).toNumber());
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 236, 232);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, 340);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 92, 88);
        dc.setPenWidth(((dc.getWidth()/15)).toNumber());
        // draw white arc for current week on the circle
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle+2, angle-2);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle+3, angle+2);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle-2, angle-3);
    }

}