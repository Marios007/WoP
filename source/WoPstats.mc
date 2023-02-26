using Toybox.System;


class WoPstats {

    private var _week;
    private var _size;
    private var _weight;
    // [week, size in mm, weight in g] 
    private var statsTable = [
            [0,"0 mm","0 g"],
            [1,"0 mm","0 g"],
            [2,"0 mm","0 g"],
            [3,"0 mm","0 g"],
            [4,"0 mm","0 g"],
            [5,"2 mm","0 g"],
            [6,"4 mm","0.1 g"],
            [7,"5 mm","0.2 g"],
            [8,"15 mm","0.5 g"],
            [9,"20 mm","2 g"],
            [10,"28 mm","4 g"],
            [11,"4 cm","8 g"],
            [12,"5 cm","16 g"],
            [13,"6 cm","23 g"],
            [14,"8 cm","40 g"],
            [15,"9 cm","90 g"],
            [16,"10 cm","114 g"],
            [17,"11 cm","144 g"],
            [18,"12.5 cm","179 g"],
            [19,"13.5 cm","222 g"],
            [20,"14 cm","272 g"],
            [21,"25 cm","330 g"],
            [22,"27 cm","398 g"],
            [23,"28 cm","476 g"],
            [24,"30 cm","565 g"],
            [25,"32 cm","665 g"],
            [26,"34 cm","778 g"],
            [27,"35 cm","902 g"],
            [28,"37 cm","1040 g"],
            [29,"38 cm","1189 g"],
            [30,"40 cm","1350 g"],
            [31,"41 cm","1523 g"],
            [32,"42 cm","1707 g"],
            [33,"43 cm","1901 g"],
            [34,"44 cm","2103 g"],
            [35,"46 cm","2312 g"],
            [36,"47 cm","2527 g"],
            [37,"48 cm","2746 g"],
            [38,"49 cm","2966 g"],
            [39,"50 cm","3186 g"],
            [40,"50 cm","3404 g"],
            [41,"52 cm","3600 g"],
    ]; 


    function initialize() {
        
    }

    function getStatsforWeek(week) {
        if (week < 42){
            return statsTable[week];
        }
        else {
            return statsTable[0];
        }
    }


}