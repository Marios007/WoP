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
    
    }

    // Called when this View is brought to the foreground. Restore
    // Restore the state of this View and prepare it to be shown. 
    // This includes loading resources into memory.
    function onShow() {
        _today = calculatorGlance.getToday();
        _dateOfBirth = calculatorGlance.getDateOfBirth();
        _currentWoP = calculatorGlance.getDates(_dateOfBirth, _today);
        message = _currentWoP.get(:week)+ " SSW ("+ (_currentWoP.get(:exactWeek)+"W + "+_currentWoP.get(:dayInWeek) +")");
        
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(G.COLOR_WHITE, G.COLOR_TRANSPARENT);
        dc.drawText(0, 6, G.FONT_GLANCE, appTitle, G.TEXT_JUSTIFY_LEFT);
        dc.drawText(0, 26, G.FONT_GLANCE, message, G.TEXT_JUSTIFY_LEFT);
        
        //message = "Week 12 (11W + 3)";
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }


}