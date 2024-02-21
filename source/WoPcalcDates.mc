using Toybox.System;
using Toybox.Time.Gregorian;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Application.Properties;
using Toybox.WatchUi;

(:glance)
class WoPcalcDates {

    private var _dateOfBirth; 
    private var _today; 
    private var _weeksDict;
    private const DURATION_PREGNANCY = new Time.Duration(24192000); //280d in sec


    function initialize() {
        _today =  getToday();
        // if pregnancy date is not set, set to today + 10 weeks 3 days
        if (Properties.getValue("dateSet") == 0 ) {
            setInitialDate();
        }
    }

    //set initial date in 10 weeks 3 days from today after new install
    function setInitialDate(){
        var tenWeeks = new Time.Duration(17884800); // 17884800 == pregnant already 10 week 3 days
        var today =  getToday();
        var initialDate = today.add(tenWeeks);
        //_dateOfBirth = initialDate;
        var initialDateGregorian = Gregorian.info(initialDate, Time.FORMAT_SHORT);
        Properties.setValue("day", initialDateGregorian.day);
        Properties.setValue("month", initialDateGregorian.month);
        Properties.setValue("year", initialDateGregorian.year);
        // Properties.setValue("dateSet", 1);
    }


    function getDateOfBirth() {
        var options = {
                :year   => Properties.getValue("year"),
                :month  => Properties.getValue("month"),
                :day    => Properties.getValue("day"),
                :hour => 0   // UTC offset, in this case for CST
            };
            _dateOfBirth = Gregorian.moment(options);
        return _dateOfBirth;
    }

    // calculate the countdown until birth
    function calculateCountdown(dateOfBirth as Time.Moment, today as Time.Moment) {
        var countdown = dateOfBirth.subtract(today);
        countdown = countdown.divide(Gregorian.SECONDS_PER_DAY);
        countdown = Math.round(countdown.value());
        countdown = countdown.toString();
        return countdown;
    }

    // return today as Moment
    function getToday() {
        _today = new Time.Moment(Time.now().value());
        return _today;
    }

        // calculate week of pregnancy and week and day seperatly, return a dict with all information
    function getDates(){
        var dateOfBirth = getDateOfBirth();
        var currentWoP = _today.subtract(dateOfBirth.subtract(DURATION_PREGNANCY)); //WoP in Days
        var woP_in_Days = (currentWoP.value())/(Gregorian.SECONDS_PER_DAY);  // WoP output in days
        var week = Math.floor(woP_in_Days / 7) + 1;  //set current WoP! (week + 1 )
        var dayInWeek = woP_in_Days - 7 * Math.floor(woP_in_Days / 7); //exact day in week
        var trimester = getTrimester(week);
        var angle = getAngle(week);
        _weeksDict = {
            :week => week, :exactWeek => woP_in_Days/7, :dayInWeek => dayInWeek, :trimester => trimester,
            :angle => angle
        };
        return _weeksDict;
    }

    // return the trimester according to the week
    function getTrimester(week) {
        if (week <= 12)  {return 1; }
        if (week <= 24)  {return 2; }
        if (week <= 40)  {return 3; }
        else {return 0;}
    }

    //convert week to an angle to draw the arc
    function getAngle(week) {
        var weekAsAngle = (90-week*9)%360;
        return weekAsAngle;
    }
}