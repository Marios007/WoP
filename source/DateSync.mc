import Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Application.Properties;
using Toybox.Application.Storage;

//! Keeps the due date (day/month/year) and the last menstrual period
//! (lmpDay/lmpMonth/lmpYear) properties consistent: due = lmp + 280 days.

(:glance)
const PREGNANCY_DURATION_SECS = 24192000; //280d in sec

//! set the due date and derive the last period from it
(:glance)
function setDatesFromDue(day, month, year) {
    var due = Gregorian.moment({:year => year, :month => month, :day => day, :hour => 0});
    var lmp = Gregorian.info(due.subtract(new Time.Duration($.PREGNANCY_DURATION_SECS)), Time.FORMAT_SHORT);
    saveDates(day, month, year, lmp.day, lmp.month, lmp.year);
}

//! set the last period and derive the due date from it
(:glance)
function setDatesFromLmp(day, month, year) {
    var lmp = Gregorian.moment({:year => year, :month => month, :day => day, :hour => 0});
    var due = Gregorian.info(lmp.add(new Time.Duration($.PREGNANCY_DURATION_SECS)), Time.FORMAT_SHORT);
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
(:glance)
function reconcileDates() {
    var due = [Properties.getValue("day"), Properties.getValue("month"), Properties.getValue("year")];
    var lmp = [Properties.getValue("lmpDay"), Properties.getValue("lmpMonth"), Properties.getValue("lmpYear")];
    var syncDue = Storage.getValue("syncDue");
    var syncLmp = Storage.getValue("syncLmp");
    if (sameDate(due, syncDue) && sameDate(lmp, syncLmp)) {
        return; //nothing changed
    }
    if (sameDate(due, syncDue) && !sameDate(lmp, syncLmp)) {
        setDatesFromLmp(lmp[0], lmp[1], lmp[2]);
    } else {
        setDatesFromDue(due[0], due[1], due[2]);
    }
}

(:glance)
function sameDate(a, b) {
    if (a == null || b == null) {
        return false;
    }
    return a[0] == b[0] && a[1] == b[1] && a[2] == b[2];
}
