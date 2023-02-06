import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WoPApp extends Application.AppBase {

    hidden var mView;
    hidden var mModel;
    hidden var mDelegate;
    hidden var mGlanceView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial glance view of your widget here
	(:glance)
    function getGlanceView() {
    	mGlanceView = new WoPGlanceView();
    	return [ mGlanceView];
    }


    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new WoPView() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as WoPApp {
    return Application.getApp() as WoPApp;
}