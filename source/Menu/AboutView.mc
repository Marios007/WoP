using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics as Gfx;
using Toybox.Math;

class AboutView extends WatchUi.View {

  var aboutTitle, aboutVersion, aboutWeb, hfx, spacing;

  function initialize() {
    spacing = System.getDeviceSettings().screenHeight < 160 ? 1.1 : 1.3;

    aboutTitle = WatchUi.loadResource(Rez.Strings.AppNameAbout);
    aboutVersion = "Version 1.2";
    hfx = Gfx.getFontHeight(Gfx.FONT_XTINY) * spacing;
    View.initialize();
  }

  function onUpdate(dc) {
    dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
    dc.clear();

    var posY = dc.getHeight()/2.5;
    var titleHeight = dc.getFontHeight(Gfx.FONT_MEDIUM) * spacing * spacing;
    write(dc, aboutTitle, Gfx.COLOR_WHITE, Gfx.FONT_MEDIUM, posY - titleHeight);
    write(dc, aboutVersion, Gfx.COLOR_WHITE, Gfx.FONT_XTINY, posY);
    posY += hfx;
    write(dc, "by", Gfx.COLOR_DK_GRAY, Gfx.FONT_XTINY, posY);
    posY += hfx;
    write(dc, "wop.garmin@outlook.com", Gfx.COLOR_WHITE, Gfx.FONT_XTINY, posY);
  }

  function write( dc, text, color, font, locY ) {
    dc.setColor( color, Gfx.COLOR_TRANSPARENT );
    dc.drawText(dc.getWidth()/2, locY, font, text, Gfx.TEXT_JUSTIFY_CENTER);
  }

}
