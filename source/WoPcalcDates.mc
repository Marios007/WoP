using Toybox.System;
using Toybox.Time.Gregorian;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Application.Properties;
using Toybox.Application.Storage;
using Toybox.WatchUi;

//! All date math works on calendar dates: "today" and the due date are both
//! represented as UTC midnight of the respective calendar day, so differences
//! are exact multiples of a day regardless of time zone or DST.
(:glance)
class WoPcalcDates {

    private var _dateOfBirth;
    private var _today;
    private var _weeksDict;
    private const PREGNANCY_DAYS = 280;
    private const DEMO_DAYS_UNTIL_DUE = 207; // demo date: pregnant already 10 weeks 3 days


    function initialize() {
        initWeekSetting();
        _today = getToday();
        if (Properties.getValue("dateSet") == 0) {
            if (Storage.getValue("syncDue") == null) {
                // very first launch: the user may already have set the date in the phone app
                var due = [Properties.getValue("day"), Properties.getValue("month"), Properties.getValue("year")];
                if ($.sameDate(due, $.DEFAULT_DUE)) {
                    setInitialDate();
                } else {
                    $.setDatesFromDue(due[0], due[1], due[2]);
                    Properties.setValue("dateSet", 1);
                }
            } else if ($.reconcileDates()) {
                // the date was changed in the phone app -> keep it, stop showing the demo date
                Properties.setValue("dateSet", 1);
            } else {
                setInitialDate(); // still the demo date -> keep it rolling until a date is set
            }
        } else {
            $.reconcileDates(); // sync due date and last period after phone settings changed
        }
    }

    //! choose the week counting style once, depending on the watch language:
    //! German counts the started week (6W+3 = 7. SSW), everybody else completed weeks (6W+3 = week 6)
    function initWeekSetting() {
        if (Properties.getValue("weekSettingInit") == 0) {
            if (Properties.getValue("dateSet") == 0) {
                var lang = System.getDeviceSettings().systemLanguage;
                Properties.setValue("weekSetting", (lang == System.LANGUAGE_DEU) ? 1 : 0);
            }
            Properties.setValue("weekSettingInit", 1);
        }
    }

    //set initial (demo) date in 207 days from today after new install
    function setInitialDate(){
        var demoDue = getToday().add(new Time.Duration(DEMO_DAYS_UNTIL_DUE * Gregorian.SECONDS_PER_DAY));
        var demo = Gregorian.utcInfo(demoDue, Time.FORMAT_SHORT);
        $.setDatesFromDue(demo.day, demo.month, demo.year);
    }


    //! due date as UTC midnight of the stored calendar day
    function getDateOfBirth() {
        var options = {
                :year   => Properties.getValue("year"),
                :month  => Properties.getValue("month"),
                :day    => Properties.getValue("day"),
                :hour => 0
            };
            _dateOfBirth = Gregorian.moment(options);
        return _dateOfBirth;
    }

    //! days until birth (calendar days, can be negative after the due date)
    function calculateCountdown(dateOfBirth as Time.Moment, today as Time.Moment) {
        return daysBetween(today, dateOfBirth).toString();
    }

    //! today as UTC midnight of the local calendar day
    function getToday() {
        _today = localDateAsUtcMidnight(Time.now());
        return _today;
    }

    //! convert any moment to UTC midnight of its local calendar day
    function localDateAsUtcMidnight(moment as Time.Moment) as Time.Moment {
        var g = Gregorian.info(moment, Time.FORMAT_SHORT);
        return Gregorian.moment({:year => g.year, :month => g.month, :day => g.day, :hour => 0});
    }

    //! whole days from a to b, both UTC midnight moments
    function daysBetween(a as Time.Moment, b as Time.Moment) as Lang.Number {
        return (b.value() - a.value()) / Gregorian.SECONDS_PER_DAY;
    }

    //! calculate the week of pregnancy, return a dict with all information
    //! :wopWeek    started week (1-based, "SSW" numbering) - drives trimester, arc and stats table
    //! :exactWeek  completed weeks
    //! :dayInWeek  day within the current week
    //! :week       the number to display, depending on the weekSetting
    function getDates(){
        var dateOfBirth = getDateOfBirth();
        var today = getToday();
        var daysPregnant = PREGNANCY_DAYS - daysBetween(today, dateOfBirth);
        if (daysPregnant < 0) {
            daysPregnant = 42 * 7; //due date too far in the future -> force the invalid date screen (week > 41)
        }
        var completedWeeks = daysPregnant / 7;
        var dayInWeek = daysPregnant % 7;
        var wopWeek = completedWeeks + 1;
        var week = (Properties.getValue("weekSetting") == 1) ? wopWeek : completedWeeks;
        var trimester = getTrimester(wopWeek);
        var angle = getAngle(wopWeek);
        var tri2angle = getAngle(Properties.getValue("trimester2start"));
        var tri3angle = getAngle(Properties.getValue("trimester3start"));
        _weeksDict = {
            :week => week, :wopWeek => wopWeek, :exactWeek => completedWeeks, :dayInWeek => dayInWeek, :trimester => trimester,
            :angle => angle, :tri2angle => tri2angle, :tri3angle => tri3angle
        };
        return _weeksDict;
    }

    // return the trimester according to the started week (SSW numbering)
    function getTrimester(week) {
        var tri1end = Properties.getValue("trimester2start") - 1; //end of trimester 1
        var tri2end = Properties.getValue("trimester3start") - 1; //end of trimester 2

        if (week <= tri1end)  {return 1; }
        if (week <= tri2end)  {return 2; }
        if (week <= 41)  {return 3; }
        else {return 0;}
    }

    //convert week to an angle to draw the arc
    function getAngle(week) {
        var weekAsAngle = (90-week*9)%360;
        return weekAsAngle;
    }
}
