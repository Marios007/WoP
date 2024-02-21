import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Application.Properties;

class WoPDelegate extends WatchUi.BehaviorDelegate {
    
    var model;

    // Set up the callback to the view
    function initialize() {
        WatchUi.BehaviorDelegate.initialize();
    }

    function onNextPage() {
        WatchUi.pushView(new WoPView2(), new WoPDelegate2(), WatchUi.SLIDE_UP);
        return true;
    }


    function onMenu() {
    // Generate a new Menu with a drawable Title
        WatchUi.pushView(new MenuSettingsView(), new $.Menu2Delegate(model), WatchUi.SLIDE_LEFT);
        return true;
    }


    function onSelect() {
        WatchUi.pushView(new WoPView2(), new WoPDelegate2(), WatchUi.SLIDE_UP);
        return true;
    }
}

class DrawableMenuTitle extends WatchUi.Drawable {

    //! Constructor
    public function initialize() {
        Drawable.initialize({});
    }
        //! Draw the application icon and main menu title
    //! @param dc Device Context
    public function draw(dc as Dc) as Void {
        var spacing = 2;
        var appIcon = WatchUi.loadResource($.Rez.Drawables.LauncherIcon) as BitmapResource;
        var bitmapWidth = appIcon.getWidth();
        var labelWidth = dc.getTextWidthInPixels("Menu", Graphics.FONT_TINY);

        var bitmapX = (dc.getWidth() - (bitmapWidth + spacing + labelWidth)) / 2;
        var bitmapY = (dc.getHeight() - appIcon.getHeight()) / 2;
        var labelX = bitmapX + bitmapWidth + spacing;
        var labelY = dc.getHeight() / 2;

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawBitmap(bitmapX, bitmapY, appIcon);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(labelX, labelY, Graphics.FONT_TINY, "Menu", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}