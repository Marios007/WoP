using Toybox.WatchUi;
using Toybox.System;
import Toybox.Lang;
using Toybox.Graphics as G;
using Toybox.Application.Properties;

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
    var currentFont;
    
    // ADD: Cache these expensive property lookups
    private var _tri2Start as Number?;
    private var _tri3Start as Number?;
    private var _totalWeeks = 40.0;
    private var _tri1End as Float?;
    private var _tri2End as Float?;
    private var _gap = 5;

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
        _xPosWeek = 100 * 0.4 / _woPDates.get(:week);
        _message = _woPDates.get(:week) + _textWoP + "("  +(_woPDates.get(:exactWeek)+"W + "+_woPDates.get(:dayInWeek) +")");
        
        // Cache property values once
        if (_tri2Start == null) {
            _tri2Start = Properties.getValue("trimester2start");
            _tri3Start = Properties.getValue("trimester3start");
            _tri1End = (_tri2Start - 1) / _totalWeeks * GW;
            _tri2End = (_tri3Start - 1) / _totalWeeks * GW;
        }
    }

        // Update the view
    function onUpdate(dc) {
        dc.setColor(G.COLOR_WHITE, G.COLOR_TRANSPARENT);
        var penWidth = 7;
        currentFont = G.FONT_GLANCE;

        var heightAdj = (dc.getFontHeight(currentFont)*0.5)+penWidth;

        dc.drawText(0, ((GH/4)-heightAdj), currentFont, _appTitle, G.TEXT_JUSTIFY_LEFT);
        dc.drawText(0, ((GH/1.333)-heightAdj), currentFont, _message, G.TEXT_JUSTIFY_LEFT);
        dc.setPenWidth(penWidth);
        
        // USE cached values instead of recalculating
        // REMOVED: var tri2Start = Properties.getValue("trimester2start");
        // REMOVED: var tri3Start = Properties.getValue("trimester3start");
        // REMOVED: var totalWeeks = 40.0;
        // REMOVED: var tri1End = (tri2Start - 1) / totalWeeks * GW;
        // REMOVED: var tri2End = (tri3Start - 1) / totalWeeks * GW;
        // REMOVED: var gap = 5;
        
        // Draw background lines using cached values
        dc.setColor(G.COLOR_DK_GRAY, -1);
        dc.drawLine(0, (GH/2)-penWidth, _tri1End-_gap, (GH/2)-penWidth);
        dc.drawLine(_tri1End+_gap, (GH/2)-penWidth, _tri2End-_gap, (GH/2)-penWidth);
        dc.drawLine(_tri2End+_gap, (GH/2)-penWidth, GW, (GH/2)-penWidth);

        // Progress display with cached values
        switch (_woPDates.get(:trimester)) {
            case 1:
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                var currentProgress = _woPDates.get(:week) / _totalWeeks * GW;
                if (currentProgress > _tri1End-_gap) {
                    currentProgress = _tri1End-_gap;
                }
                dc.drawLine(0, (GH/2)-penWidth, currentProgress, (GH/2)-penWidth);
                
                // Marker für aktuelle Position
                dc.setPenWidth(9);
                dc.setColor(G.COLOR_BLACK, G.COLOR_BLACK);
                dc.drawLine(currentProgress, GH/2-2, currentProgress, GH/2-12);
                dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK);
                dc.setPenWidth(6);
                dc.drawLine(currentProgress, GH/2-2, currentProgress, GH/2-12);
                break;
                
            case 2:
                // Zeichne vollständiges 1. Trimester in Rot (mit Lücke)
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, (GH/2)-penWidth, _tri1End-_gap, (GH/2)-penWidth);
                
                // Zeichne Fortschritt im 2. Trimester in Gelb (mit Lücken)
                dc.setColor(G.COLOR_YELLOW, -1);
                var currentProgress2 = _woPDates.get(:week) / _totalWeeks * GW;
                // Begrenze Fortschritt auf das 2. Trimester
                if (currentProgress2 > _tri2End-_gap) {
                    currentProgress2 = _tri2End-_gap;
                }
                if (currentProgress2 < _tri1End+_gap) {
                    currentProgress2 = _tri1End+_gap;
                }
                dc.drawLine(_tri1End+_gap, (GH/2)-penWidth, currentProgress2, (GH/2)-penWidth);
                
                // Marker für aktuelle Position
                dc.setPenWidth(9);
                dc.setColor(G.COLOR_BLACK, G.COLOR_BLACK);
                dc.drawLine(currentProgress2, GH/2-2, currentProgress2, GH/2-12);
                dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK);
                dc.setPenWidth(6);
                dc.drawLine(currentProgress2, GH/2-2, currentProgress2, GH/2-12);
                break;
                
            case 3:
                // Zeichne vollständiges 1. Trimester in Rot (mit Lücke)
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, (GH/2)-penWidth, _tri1End-_gap, (GH/2)-penWidth);
                
                // Zeichne vollständiges 2. Trimester in Gelb (mit Lücken)
                dc.setColor(G.COLOR_YELLOW, -1);
                dc.drawLine(_tri1End+_gap, (GH/2)-penWidth, _tri2End-_gap, (GH/2)-penWidth);
                
                // Zeichne Fortschritt im 3. Trimester in Grün (mit Lücke)
                dc.setColor(G.COLOR_GREEN, -1);
                var currentProgress3 = _woPDates.get(:week) / _totalWeeks * GW;
                // Starte erst ab dem 3. Trimester
                if (currentProgress3 < _tri2End+_gap) {
                    currentProgress3 = _tri2End+_gap;
                }
                dc.drawLine(_tri2End+_gap, (GH/2)-penWidth, currentProgress3, (GH/2)-penWidth);
                
                // Marker für aktuelle Position
                dc.setPenWidth(9);
                dc.setColor(G.COLOR_BLACK, G.COLOR_BLACK);
                dc.drawLine(currentProgress3, GH/2-2, currentProgress3, GH/2-12);
                dc.setColor(G.COLOR_WHITE, G.COLOR_BLACK);
                dc.setPenWidth(6);
                dc.drawLine(currentProgress3, GH/2-2, currentProgress3, GH/2-12);
                break;
                
            default:
                // Nach der Geburt - alle Trimester vollständig (mit Lücken)
                dc.setPenWidth(8);
                dc.setColor(G.COLOR_RED, -1);
                dc.drawLine(0, (GH/2)-penWidth, _tri1End-_gap, (GH/2)-penWidth);
                dc.setColor(G.COLOR_YELLOW, -1);
                dc.drawLine(_tri1End+_gap, (GH/2)-penWidth, _tri2End-_gap, (GH/2)-penWidth);
                dc.setColor(G.COLOR_GREEN, -1);
                dc.drawLine(_tri2End+_gap, (GH/2)-penWidth, GW, (GH/2)-penWidth);
                break;
        }
    } 

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
