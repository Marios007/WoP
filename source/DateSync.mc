import Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Properties;
using Toybox.Application.Storage;

//! Keeps the due date (day/month/year) and the last menstrual period
//! (lmpDay/lmpMonth/lmpYear) properties consistent: due = lmp + 280 days.
//! Dates are handled as UTC midnight moments (Gregorian.moment / utcInfo)
//! so the conversion never shifts a day because of the local time zone.

(:glance)
const PREGNANCY_DURATION_SECS = 24192000; //280d in sec

//! compiled-in default due date - MUST match day/month/year in resources/settings/properties.xml
(:glance)
const DEFAULT_DUE = [1, 1, 2027];

//! clamp a day to the last valid day of the given month/year (handles leap years)
(:glance)
function daysInMonth(month, year) {
    var lengths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var max = lengths[month - 1];
    if (month == 2 && year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
        max = 29;
    }
    return max;
}

//! set the due date and derive the last period from it
(:glance)
function setDatesFromDue(day, month, year) {
    var maxDay = daysInMonth(month, year);
    if (day > maxDay) { day = maxDay; }
    var due = Gregorian.moment({:year => year, :month => month, :day => day, :hour => 0});
    var lmp = Gregorian.utcInfo(due.subtract(new Time.Duration($.PREGNANCY_DURATION_SECS)), Time.FORMAT_SHORT);
    saveDates(day, month, year, lmp.day, lmp.month, lmp.year);
}

//! set the last period and derive the due date from it
(:glance)
function setDatesFromLmp(day, month, year) {
    var maxDay = daysInMonth(month, year);
    if (day > maxDay) { day = maxDay; }
    var lmp = Gregorian.moment({:year => year, :month => month, :day => day, :hour => 0});
    var due = Gregorian.utcInfo(lmp.add(new Time.Duration($.PREGNANCY_DURATION_SECS)), Time.FORMAT_SHORT);
    saveDates(due.day, due.month, due.year, day, month, year);
}

//! write both date triples and remember them as the last synced state
(:glance)
function saveDates(dueDay, dueMonth, dueYear, lmpDay, lmpMonth, lmpYear) {
    Properties.setValue("day", dueDay);
    Properties.setValue("month", dueMonth);
    Properties.setValue("year", dueYear);
    Properties.setValue("lmpDay", lmpDay);
    Properties.setValue("lmpMonth", lmpMonth);
    Properties.setValue("lmpYear", lmpYear);
    Storage.setValue("syncDue", [dueDay, dueMonth, dueYear]);
    Storage.setValue("syncLmp", [lmpDay, lmpMonth, lmpYear]);
}

//! after the phone app changed properties, detect which date was edited
//! and recompute the other one (due date wins if both were changed)
//! @return true if a change was detected and applied, false if nothing changed
//!         (or nothing has been synced yet)
(:glance)
function reconcileDates() as Boolean {
    var syncDue = Storage.getValue("syncDue");
    var syncLmp = Storage.getValue("syncLmp");
    if (syncDue == null || syncLmp == null) {
        return false; // nothing to compare against yet
    }
    var due = [Properties.getValue("day"), Properties.getValue("month"), Properties.getValue("year")];
    var lmp = [Properties.getValue("lmpDay"), Properties.getValue("lmpMonth"), Properties.getValue("lmpYear")];
    if (sameDate(due, syncDue) && sameDate(lmp, syncLmp)) {
        return false; //nothing changed
    }
    if (sameDate(due, syncDue) && !sameDate(lmp, syncLmp)) {
        setDatesFromLmp(lmp[0], lmp[1], lmp[2]);
    } else {
        setDatesFromDue(due[0], due[1], due[2]);
    }
    return true;
}

(:glance)
function sameDate(a, b) {
    if (a == null || b == null) {
        return false;
    }
    return a[0] == b[0] && a[1] == b[1] && a[2] == b[2];
}
