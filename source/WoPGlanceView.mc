using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as G;

(:glance)
class WoPGlanceView extends WatchUi.GlanceView {

	var message = "";
	var appTitle;
    var yCenter;
    var _currentWoP;
    var _dateOfBirth;
    var _today;
    var calculatorGlance;
    var xPosWeek;
	var GW;
	var GH;


    function initialize() {
        WatchUi.GlanceView.initialize();
        calculatorGlance = new WoPcalcDates();
        calculatorGlance.setDateOfBirth();
        //var test = new WoPView();
    }

    // Load your resources here
    function onLayout(dc) {
        appTitle = WatchUi.loadResource(Rez.Strings.glance_title);
        yCenter = dc.getHeight() /2; //use alter for adkjusting height of text
        GW = dc.getWidth();
    	GH = dc.getHeight();
    	GH = dc.getHeight();
    
        GH = dc.getHeight();
    
    }

    // Called when this View is brought to the foreground. Restore
    // Restore the state of this View and prepare it to be shown. 
    // This includes loading resources into memory.
    function onShow() {
        _today = calculatorGlance.getToday();
        _dateOfBirth = calculatorGlance.getDateOfBirth();
        _currentWoP = calculatorGlance.getDates(_dateOfBirth, _today);
        xPosWeek = 100/(_currentWoP.get(:week)/0.4);
        message = _currentWoP.get(:week)+ ". SSW ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")");
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(G.COLOR_WHITE, G.COLOR_TRANSPARENT);

        dc.drawText(0, 0, G.FONT_GLANCE, appTitle, G.TEXT_JUSTIFY_LEFT);
        dc.drawText(0, 40, G.FONT_GLANCE, message, G.TEXT_JUSTIFY_LEFT);
        dc.setPenWidth(7);
        dc.setColor(G.COLOR_DK_GRAY, -1);
        dc.drawLine(0, GH/2, GW/3.6, GH/2);
        dc.drawLine(GW/3, GH/2, GW/1.63, GH/2);
        dc.drawLine(GW/1.5, GH/2, GW, GH/2);


        switch (_currentWoP.get(:trimester)) {
            case 1:
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, GH/2, GW/xPosWeek, GH/2);
                break;
            case 2:
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_YELLOW, -1);
                dc.drawLine(GW/3, GH/2, GW/xPosWeek, GH/2);
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, GH/2, GW/3.6, GH/2);
                break;
            case 3:
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_GREEN, -1);
                dc.drawLine(GW/1.5 , GH/2, GW/xPosWeek, GH/2);
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, GH/2, GW/3.6, GH/2);
                dc.setColor(G.COLOR_YELLOW, -1);
                dc.drawLine(GW/3, GH/2, GW/1.63, GH/2);
                break;
            default:
                break;
        } 
        dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK);
        dc.setPenWidth(5);
        dc.drawLine(GW/xPosWeek, GH/2+7, GW/xPosWeek, GH/2-7);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }


}