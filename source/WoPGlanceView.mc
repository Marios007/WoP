using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as G;

(:glance)
class WoPGlanceView extends WatchUi.GlanceView {

	hidden var message = "";
	var appTitle;
    var yCenter;

    function initialize() {
        
        WatchUi.GlanceView.initialize();
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
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(G.COLOR_WHITE, G.COLOR_TRANSPARENT);
    	dc.drawText(0, 6, G.FONT_GLANCE, appTitle, G.TEXT_JUSTIFY_LEFT);
        message = "10W + 3";

        dc.drawText(0, 26, G.FONT_SYSTEM_TINY, message, G.TEXT_JUSTIFY_LEFT);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }


}