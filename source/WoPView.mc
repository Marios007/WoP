import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;

class WoPView extends WatchUi.View {

    private var _textTop;
    private var _currentWoP;
    private var _countdownDays;
    private var _dateOfBirth;
    private var _durationPregnancy = new Time.Duration(24192000) ; //280d in sec


    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _textTop = findDrawableById("textTop");
        _currentWoP = findDrawableById("week");
        _countdownDays = findDrawableById("countdown");
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        
        
         // set date of birth as Moment
        var options = {
            :year   => 2023,
            :month  => 8,
            :day    => 26,
            :hour => 0   // UTC offset, in this case for CST
        };
        var _dateOfBirth = Gregorian.moment(options);
        //System.println(_dateOfBirth.value());
        // print date of birth for test
        /*var dateOfBirth = Gregorian.utcInfo(_dateOfBirth, Time.FORMAT_SHORT);
        System.println(Lang.format("$1$-$2$-$3$", [
            dateOfBirth.year.format("%04u"),
            dateOfBirth.month.format("%02u"),
            dateOfBirth.day.format("%02u")])); */

        var today = new Time.Moment(Time.today().value());
        // add one hour because 1h missing ??? 
        var oneHour = new Time.Duration(Gregorian.SECONDS_PER_HOUR);
        today = today.add(oneHour); 
        //System.println(today.value());

        calculateWeek(_dateOfBirth, today);
        calculateCountdown(_dateOfBirth, today);

    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {

    }

    // calculate week of pregancy and week and day seperatly 
    function calculateWeek(dateOfBirth as Time.Moment, today as Time.Moment ) as Void{
        
        var currentWoP = today.subtract(dateOfBirth.subtract(_durationPregnancy)); //WoP in Days

        System.println("WoP in seconds: " + currentWoP.value()); // WoP output in seconds
        var woP_in_Days = (currentWoP.value())/(86400);  // WoP output in days
        System.println("WoP in days: " + woP_in_Days);
        var week = (woP_in_Days/7)+1;  //WoP!
        var exactWeek = woP_in_Days.toDouble()/7.0; // WoP in weeks as float
        var dayInWeek = woP_in_Days%7;
        //System.println("WoP in week: " + exactWeek);
        // System.println("Current WoP: " + week);
        //System.println("Current Day: " + (dayInWeek));
        
        //Set Text on screen
        _currentWoP.setText(week + " SSW ("+ (woP_in_Days/7)+"W + "+dayInWeek +")");

    }


    // calculate and set countdown until birth

    function calculateCountdown(dateOfBirth as Time.Moment, today as Time.Moment) as Void{
        var countdown = dateOfBirth.subtract(today);
        var output = countdown.divide(86400);
        output = output.value();
        var output1 = output.toString();
        //Set Text on screen
        _countdownDays.setText("Noch " + output1 + " Tage" );

}
}