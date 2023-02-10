using Toybox.System;
using Toybox.Time.Gregorian;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Application.Storage;
import Toybox.WatchUi;

(:glance)
class WoPcalcDates {

    var _birthdateDict = {};
    var _currentWoP;
    var _countdown;
    var _dateOfBirth;
    var _today;
    var _exactWeek;
    var _week;
    var _dayInWeek;
    var _trimester;
    var _durationPregnancy = new Time.Duration(24192000); //280d in sec


    function setDateOfBirth() {
        System.println("Set date of birth method");
        
        System.println("Month: " + Storage.getValue("month"));

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
        var output1 = output.toString();
        //Set Text on screen
        return output1;
        }

    // return today as Moment
    function getToday() {
        _today = new Time.Moment(Time.today().value());
        var oneHour = new Time.Duration(Gregorian.SECONDS_PER_HOUR);
        _today = _today.add(oneHour); 
        //System.println(_today.value());
        return _today;
    }

        // calculate week of pregancy and week and day seperatly 
    function getDates(dateOfBirth as Time.Moment, today as Time.Moment ){
        var currentWoP = today.subtract(dateOfBirth.subtract(_durationPregnancy)); //WoP in Days

        //System.println("WoP in seconds: " + currentWoP.value()); // WoP output in seconds
        var woP_in_Days = (currentWoP.value())/(86400);  // WoP output in days
        //System.println("WoP in days: " + woP_in_Days);
        _week = (woP_in_Days/7)+1;  //set current WoP!
        //var exactWeek = woP_in_Days.toDouble()/7.0; // WoP in weeks as float
        _dayInWeek = woP_in_Days%7; //exact day in week
        //System.println("WoP in week: " + exactWeek);
        // System.println("Current WoP: " + week);
        //System.println("Current Day: " + (_dayInWeek));
        _trimester = getTrimester(_week);
        var weeksDict = {
            :week => _week, :exactWeek => woP_in_Days/7, :dayInWeek => _dayInWeek, :trimester => _trimester,
            :angle => getAngle(_week)
        };
        return weeksDict;
    }

    function getTrimester(week)
    {
        if (week <= 12)  {return 1; }
        if (week <= 24)  {return 2; }
        if (week <= 40)  {return 3; }
        else {return 4;}
    }

    //convert week to an angle to draw the arc
    function getAngle(week) {
        var weekAsAngle = (90-week*9)%360;
        return weekAsAngle;   
    }

}