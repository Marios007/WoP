using Toybox.System;
using Toybox.Time.Gregorian;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Application.Storage;
import Toybox.WatchUi;

(:glance)
class WoPcalcDates {

    private var _dateOfBirth; // as Gregorian moment
    private var _today; 
    private var _week;
    private var _dayInWeek;
    private var _trimester;
    private var _weeksDict;
    private const DURATION_PREGNANCY = new Time.Duration(24192000); //280d in sec


    function setDateOfBirth() {
        var options = {
            :year   => Storage.getValue("year"),
            :month  => Storage.getValue("month"),
            :day    => Storage.getValue("day"),
            :hour => 0   // UTC offset, in this case for CST
        };
        _dateOfBirth = Gregorian.moment(options);
        //System.println(_dateOfBirth.value());
        // print date of birth for test
        /*var dateOfBirth = Gregorian.utcInfo(_dateOfBirth, Time.FORMAT_SHORT);
        System.println(Lang.format("$1$-$2$-$3$", [
            dateOfBirth.year.format("%04u"),
            dateOfBirth.month.format("%02u"),
            dateOfBirth.day.format("%02u")])); */
    }

    function getDateOfBirth() {
        return _dateOfBirth;
    }

    // calculate the countdown until birth
    function calculateCountdown(dateOfBirth as Time.Moment, today as Time.Moment) {
        var countdown = dateOfBirth.subtract(today);
        var output = countdown.divide(86400);
        output = output.value();
        countdown = output.toString();
        return countdown;
        }

    // return today as Moment
    function getToday() {
        _today = new Time.Moment(Time.today().value());
        var oneHour = new Time.Duration(Gregorian.SECONDS_PER_HOUR);
        _today = _today.add(oneHour); 
        return _today;
    }

        // calculate week of pregancy and week and day seperatly 
    function getDates(dateOfBirth as Time.Moment, today as Time.Moment ){
        var currentWoP = today.subtract(dateOfBirth.subtract(DURATION_PREGNANCY)); //WoP in Days

        //System.println("WoP in seconds: " + currentWoP.value()); // WoP output in seconds
        var woP_in_Days = (currentWoP.value())/(86400);  // WoP output in days
        //System.println("WoP in days: " + woP_in_Days);
        _week = (woP_in_Days/7)+1;  //set current WoP!
        _dayInWeek = woP_in_Days%7; //exact day in week
        //System.println("WoP in week: " + exactWeek);
        //System.println("Current WoP: " + week);
        //System.println("Current Day: " + (_dayInWeek));
        _trimester = getTrimester(_week);
        _weeksDict = {
            :week => _week, :exactWeek => woP_in_Days/7, :dayInWeek => _dayInWeek, :trimester => _trimester,
            :angle => getAngle(_week)
        };
        return _weeksDict;
    }

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