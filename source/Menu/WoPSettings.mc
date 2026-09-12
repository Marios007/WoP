import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Properties;


//! Create the Basic Drawables custom menu
function pushBasicCustom() as Void {
    var customMenu = new WatchUi.CustomMenu(100, Graphics.COLOR_BLACK, {
        :focusItemHeight=>150,
        :title=>new $.DrawableMenuTitle(),
        :footer=>new $.DrawableMenuFooter()
    });
    customMenu.addItem(new $.CustomItem(:item1, WatchUi.loadResource(Rez.Strings.SettingsArea0)));
    customMenu.addItem(new $.CustomItem(:item2, WatchUi.loadResource(Rez.Strings.SettingsArea1)));
    WatchUi.pushView(customMenu, new $.BasicCustomDelegate(), WatchUi.SLIDE_UP);
}


//! This is the menu input delegate for the Basic Drawables menu
class BasicCustomDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        if (item.getId() == :item1) {
            // Handle first item selection
            Properties.setValue("weekSetting", 1);
            WatchUi.pushView(new $.SimpleTextView(WatchUi.loadResource(Rez.Strings.SettingsArea0Text)), new $.SimpleTextDelegate(), WatchUi.SLIDE_UP);
        } else if (item.getId() == :item2) {
            // Handle second item selection
            Properties.setValue("weekSetting", 0);
            WatchUi.pushView(new $.SimpleTextView(WatchUi.loadResource(Rez.Strings.SettingsArea1Text)), new $.SimpleTextDelegate(), WatchUi.SLIDE_UP);
        }
    }
}

//! Simple text view that shows message
class SimpleTextView extends WatchUi.View {
    private var _message as String;
    private var _textCenter;

    public function initialize(message as String) {
        View.initialize();
        _message = message;
    }

    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.TextOnlyLayout(dc));
        _textCenter = findDrawableById("textCenter");
    }

    function onShow() as Void {
        // Set the text to be displayed
        _textCenter.setText(_message);
    }

    public function onUpdate(dc as Dc) as Void {
        //dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        View.onUpdate(dc);
        //dc.clear();
        
    }
}

//! Simple delegate that closes view on any button press
class SimpleTextDelegate extends WatchUi.BehaviorDelegate {
    
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    public function onKey(keyEvent as KeyEvent) as Boolean {
        // Close view on any key press
        return closeView();
    }

    public function onTap(clickEvent as ClickEvent) as Boolean {
        // Close view on any tap
        return closeView();
    }

    public function onSelect() as Boolean {
        // Close view on select button
        return closeView();
    }

        // Helper method to close view safely
    private function closeView() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }
}

//! This is the custom item drawable.
//! It draws the label it is initialized with at the center of the region
class CustomItem extends WatchUi.CustomMenuItem {

    private var _label as String;

    //! Constructor
    //! @param id The identifier for this item
    //! @param text Text to display
    public function initialize(id as Symbol, text as String) {
        CustomMenuItem.initialize(id, {});
        _label = text;
    }

    //! Draw the item string at the center of the item, wrapping onto
    //! multiple lines if it does not fit the item's width.
    //! @param dc Device context
    public function draw(dc as Dc) as Void {
        var font = Graphics.FONT_XTINY;
        if (isFocused()) {
            font = Graphics.FONT_TINY;
        }

        if (isSelected()) {
            dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
            dc.clear();
        }

        var maxWidth = dc.getWidth() - 16;
        var lines = wrapText(dc, _label, font, maxWidth);
        var lineHeight = Graphics.getFontHeight(font);
        var startY = (dc.getHeight() - lineHeight * lines.size()) / 2 + lineHeight / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        for (var i = 0; i < lines.size(); i++) {
            dc.drawText(dc.getWidth() / 2, startY + i * lineHeight, font, lines[i], Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, 0, dc.getWidth(), 0);
        dc.drawLine(0, dc.getHeight() - 1, dc.getWidth(), dc.getHeight() - 1);
    }

    //! Split text into lines that each fit within maxWidth for the given font.
    //! @param dc Device context used to measure text
    //! @param text The text to wrap
    //! @param font The font the text will be drawn with
    //! @param maxWidth The maximum width in pixels a line may occupy
    //! @return Array of lines
    private function wrapText(dc as Dc, text as String, font as Graphics.FontType, maxWidth as Number) as Array<String> {
        var lines = [] as Array<String>;
        var currentLine = "";
        var remaining = text;

        while (remaining.length() > 0) {
            var spaceIndex = remaining.find(" ");
            var word;
            if (spaceIndex == null) {
                word = remaining;
                remaining = "";
            } else {
                word = remaining.substring(0, spaceIndex) as String;
                remaining = remaining.substring(spaceIndex + 1, remaining.length()) as String;
            }

            var testLine = currentLine.equals("") ? word : currentLine + " " + word;
            if (dc.getTextWidthInPixels(testLine, font) <= maxWidth || currentLine.equals("")) {
                currentLine = testLine;
            } else {
                lines.add(currentLine);
                currentLine = word;
            }
        }
        if (!currentLine.equals("")) {
            lines.add(currentLine);
        }

        return lines;
    }

    //! Get the item label
    //! @return The label
    public function getLabel() as String {
        return _label;
    }
}

//! This is the drawable for the custom menu footer
class DrawableMenuFooter extends WatchUi.Drawable {

    //! Constructor
    public function initialize() {
        Drawable.initialize({});
    }

    //! Draw bottom half of the last dividing line below the final item
    //! @param dc Device context
    public function draw(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawLine(0, 0, dc.getWidth(), 0);
    }
}
