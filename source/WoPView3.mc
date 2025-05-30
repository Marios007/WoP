import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class WoPView3 extends WatchUi.View {

    private var center_x;
    private var center_y;
    private var _currentWoP;
    private var _textTop;
    private var _textSize;
    var trimester;
    private var calculator;
    private var stats = new WoPstats();
    private var drawer;
    var week;
    private var _image;
    private var data as Array or Null = [];

    function initialize(mCalc, mDrawer) {
        drawer = mDrawer;
        calculator = mCalc;
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
        _image = new WatchUi.Bitmap({:rezId=>data[4], :locX=>center_x, :locY=>center_y});
        var _image_dimension = _image.getDimensions();
        _image.setLocation(center_x - (_image_dimension[0]/2), center_y - (_image_dimension[1]/2));
        
    }

    // Update the view
    function onUpdate(dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        drawer.drawStatusCircle(dc, center_x, center_y, trimester, _currentWoP.get(:angle),_currentWoP.get(:tri2angle), _currentWoP.get(:tri3angle));
        _image.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
    
}