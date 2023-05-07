using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as G;

(:glance)
class WoPGlanceView extends WatchUi.GlanceView {

    var _message = "";
    var _appTitle;
    var _textWoP;
    var _woPDates;
    var _today;
    var calculatorGlance;
    var _xPosWeek;
    var GW;
    var GH;


    function initialize(mCalc) {
        WatchUi.GlanceView.initialize();
        calculatorGlance = mCalc;
    }

    // Load your resources here
    function onLayout(dc) {
        _appTitle = WatchUi.loadResource(Rez.Strings.glance_title);
        _textWoP = WatchUi.loadResource(Rez.Strings.wop);
        GW = dc.getWidth();
        GH = dc.getHeight();
    }

    // Called when this View is brought to the foreground. Restore
    // Restore the state of this View and prepare it to be shown. 
    // This includes loading resources into memory.
    function onShow() {
        _woPDates = calculatorGlance.getDates();
        _xPosWeek = 100/(_woPDates.get(:week)/0.4);
        _message = _woPDates.get(:week) + _textWoP + "("  +(_woPDates.get(:exactWeek)+"W + "+_woPDates.get(:dayInWeek) +")");
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(G.COLOR_WHITE, G.COLOR_TRANSPARENT);

        dc.drawText(0, 0, G.FONT_GLANCE, _appTitle, G.TEXT_JUSTIFY_LEFT);
        dc.drawText(0, GH/1.5, G.FONT_GLANCE, _message, G.TEXT_JUSTIFY_LEFT);
        dc.setPenWidth(7);
        dc.setColor(G.COLOR_DK_GRAY, -1);
        dc.drawLine(0, GH/2, GW/3.33-7, GH/2);
        dc.drawLine(GW/3.33+3, GH/2, GW/1.66-7, GH/2);
        dc.drawLine(GW/1.66+3, GH/2, GW, GH/2);

        System.println(_woPDates.get(:trimester));
        switch (_woPDates.get(:trimester)) {
            case 1:
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, GH/2, GW/_xPosWeek, GH/2);
                dc.setPenWidth(9);
                dc.setColor(G.COLOR_BLACK, G.COLOR_BLACK);
                dc.drawLine(GW/_xPosWeek, GH/2+5, (GW/_xPosWeek), GH/2-5);
                dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK);
                dc.setPenWidth(6);
                dc.drawLine(GW/_xPosWeek, GH/2+5, (GW/_xPosWeek), GH/2-5);
                break;
            case 2:
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_YELLOW, -1);
                dc.drawLine(GW/3.33+3, GH/2, GW/_xPosWeek+3, GH/2);
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, GH/2, GW/3.33-8, GH/2);
                dc.setPenWidth(9);
                dc.setColor(G.COLOR_BLACK, G.COLOR_BLACK);
                dc.drawLine(GW/_xPosWeek+3, GH/2+5, (GW/_xPosWeek+3), GH/2-5);
                dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK); 
                dc.setPenWidth(6);
                dc.drawLine(GW/_xPosWeek+3, GH/2+5, (GW/_xPosWeek+3), GH/2-5);
                break;
            case 3:
                System.println("case 3");
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_GREEN, -1);
                dc.drawLine(GW/1.66+3 , GH/2, GW/_xPosWeek+3, GH/2);
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, GH/2, GW/3.33-7, GH/2);
                dc.setColor(G.COLOR_YELLOW, -1);
                dc.drawLine(GW/3.33+3, GH/2, GW/1.66-7, GH/2);
                dc.setPenWidth(9);
                dc.setColor(G.COLOR_BLACK, G.COLOR_BLACK);
                dc.drawLine(GW/_xPosWeek+6, GH/2+5, (GW/_xPosWeek+6), GH/2-5);
                dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK);
                dc.setPenWidth(6);
                dc.drawLine(GW/_xPosWeek+6, GH/2+5, GW/_xPosWeek+6, GH/2-5);
                break;
            default:
                break;
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}