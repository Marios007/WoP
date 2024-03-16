import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class WoPView2 extends WatchUi.View {

    private var center_x;
    private var center_y;
    private var _currentWoP;
    private var _textTop;
    private var _sizeBaby;
    private var _weightBaby;
    var dates;
    var trimester;
    var calculator = new WoPcalcDates();
    var stats = new WoPstats();
    var drawer = new WoPDrawer();

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.SecondPageLayout(dc));
        center_x = dc.getWidth()/2;
        center_y = dc.getHeight()/2;
        _textTop = findDrawableById("textTop");
        _sizeBaby = findDrawableById("sizeBaby");
        _weightBaby = findDrawableById("weightBaby");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _currentWoP = calculator.getDates();
        _textTop.setText(WatchUi.loadResource(Rez.Strings.text_top_page2));
        var week = _currentWoP.get(:week).toNumber();
        var data = stats.getStatsforWeek(week) as Array;
        _sizeBaby.setText(data[1]);
        _weightBaby.setText(data[2]);
        trimester = _currentWoP.get(:trimester);
    }

    // Update the view
    function onUpdate(dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        drawer.drawStatusCircle(dc, center_x, center_y, trimester, _currentWoP.get(:angle));
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
    
}