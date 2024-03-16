import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class WoPView3 extends WatchUi.View {

    private var center_x;
    private var center_y;
    private var _currentWoP;
    private var _textTop;
    private var _textSize;
    var dates;
    var trimester;
    var calculator = new WoPcalcDates();
    var stats = new WoPstats();
    var drawer = new WoPDrawer();
    var week;
    var _image;
    var data as Array = [];

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.ThirdPageLayout(dc));
        center_x = dc.getWidth()/2;
        center_y = dc.getHeight()/2;
        _textTop = findDrawableById("textTop");
        _textSize = findDrawableById("textSizeName");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _currentWoP = calculator.getDates();
        _textTop.setText(WatchUi.loadResource(Rez.Strings.firstLine));
        trimester = _currentWoP.get(:trimester);
        week = _currentWoP.get(:week);
        data  = stats.getStatsforWeek(week) as Array;
        _textSize.setText(WatchUi.loadResource(data[3]));
    }

    // Update the view
    function onUpdate(dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        drawer.drawStatusCircle(dc, center_x, center_y, trimester, _currentWoP.get(:angle));
        _image = new WatchUi.Bitmap({:rezId=>data[4], :locX=>center_x, :locY=>center_y});
        var _image_dimension = _image.getDimensions();
        _image.setLocation(center_x - (_image_dimension[0]/2), center_y - (_image_dimension[1]/2));
        _image.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
    
}