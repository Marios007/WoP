import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WoPApp extends Application.AppBase {

    hidden var mView;
    hidden var mCalc;
    hidden var mDelegate;
    hidden var mGlanceView;
    hidden var drawer;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }


    // Return the initial view of your application here
    function getInitialView()  {
        drawer = new WoPDrawer();
        mCalc = new WoPcalcDates();
        mView = new WoPView(mCalc, drawer);
        mDelegate = new WoPDelegate(mCalc, drawer);
        return [ mView, mDelegate ];
    }

    // Return the initial glance view of your widget here
    (:glance)
    function getGlanceView() {
        mCalc = new WoPcalcDates();
        mGlanceView = new WoPGlanceView(mCalc);
        return [ mGlanceView];
    }
}

function getApp() as WoPApp {
    return Application.getApp() as WoPApp;
}