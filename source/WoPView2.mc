import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;

class WoPView2 extends WatchUi.View {

    private var center_x;
    private var center_y;
    private var _currentWoP;
    private var _textTop;
    var calculator = new WoPcalcDates();

    function initialize() {
        View.initialize();
        calculator.setDateOfBirth();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.SecondPageLayout(dc));
        center_x = dc.getWidth()/2;
        center_y = dc.getHeight()/2;
        _textTop = findDrawableById("textTop");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _currentWoP = calculator.getDates();
        
    }

    // Update the view
    function onUpdate(dc) as Void {
         // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        circleStatus(dc);
        _textTop.setText(WatchUi.loadResource(Rez.Strings.text_top_page2));
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
        dc.setPenWidth(((dc.getWidth()/20)).toNumber());
        switch (_currentWoP.get(:trimester)) {
            case 1:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, angle);
                break;
            case 2:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, 342);
                dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, angle);

                break;
            case 3:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, 342);
                dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 344, 236);
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 232, angle);
                break;
            case 4:
                break;
        }

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