import Toybox.Lang;
using Toybox.Application.Properties;


class WoPstats {

    // [week, size in mm, weight in g]
    private var statsTable as Array<Array<Number or String or Lang.ResourceId>> = [
            [0,"0 mm","0 g", Rez.Strings.size0, Rez.Drawables.size0],
            [1,"0 mm","0 g", Rez.Strings.size1, Rez.Drawables.size1],
            [2,"0 mm","0 g", Rez.Strings.size2, Rez.Drawables.size2],
            [3,"0 mm","0 g", Rez.Strings.size3, Rez.Drawables.size3],
            [4,"0 mm","0 g", Rez.Strings.size4, Rez.Drawables.size4],
            [5,"2 mm","0 g", Rez.Strings.size5, Rez.Drawables.size5],
            [6,"4 mm","0.1 g", Rez.Strings.size6, Rez.Drawables.size6],
            [7,"5 mm","0.2 g", Rez.Strings.size7, Rez.Drawables.size7],
            [8,"15 mm","0.5 g", Rez.Strings.size8, Rez.Drawables.size8],
            [9,"20 mm","2 g", Rez.Strings.size9, Rez.Drawables.size9],
            [10,"28 mm","4 g", Rez.Strings.size10, Rez.Drawables.size10],
            [11,"4 cm","8 g", Rez.Strings.size11, Rez.Drawables.size11],
            [12,"5 cm","16 g", Rez.Strings.size12, Rez.Drawables.size12],
            [13,"6 cm","23 g", Rez.Strings.size13, Rez.Drawables.size13],
            [14,"8 cm","40 g", Rez.Strings.size14, Rez.Drawables.size14],
            [15,"9 cm","90 g", Rez.Strings.size15, Rez.Drawables.size15],
            [16,"10 cm","114 g", Rez.Strings.size16, Rez.Drawables.size16],
            [17,"11 cm","144 g", Rez.Strings.size17, Rez.Drawables.size17],
            [18,"12.5 cm","179 g", Rez.Strings.size18, Rez.Drawables.size18],
            [19,"13.5 cm","222 g", Rez.Strings.size19, Rez.Drawables.size19],
            [20,"14 cm","272 g", Rez.Strings.size20, Rez.Drawables.size20],
            [21,"25 cm","330 g", Rez.Strings.size21, Rez.Drawables.size21],
            [22,"27 cm","398 g",Rez.Strings.size22, Rez.Drawables.size22],
            [23,"28 cm","476 g",Rez.Strings.size23, Rez.Drawables.size23],
            [24,"30 cm","565 g", Rez.Strings.size24, Rez.Drawables.size24],
            [25,"32 cm","665 g", Rez.Strings.size25, Rez.Drawables.size25],
            [26,"34 cm","778 g", Rez.Strings.size26, Rez.Drawables.size26],
            [27,"35 cm","902 g", Rez.Strings.size27, Rez.Drawables.size27],
            [28,"37 cm","1040 g", Rez.Strings.size28, Rez.Drawables.size28],
            [29,"38 cm","1189 g", Rez.Strings.size29, Rez.Drawables.size29],
            [30,"40 cm","1350 g", Rez.Strings.size30, Rez.Drawables.size30],
            [31,"41 cm","1523 g", Rez.Strings.size31, Rez.Drawables.size31],
            [32,"42 cm","1707 g", Rez.Strings.size32, Rez.Drawables.size32],
            [33,"43 cm","1901 g", Rez.Strings.size33, Rez.Drawables.size33],
            [34,"44 cm","2103 g", Rez.Strings.size34, Rez.Drawables.size34],
            [35,"46 cm","2312 g", Rez.Strings.size35, Rez.Drawables.size35],
            [36,"47 cm","2527 g", Rez.Strings.size36, Rez.Drawables.size36],
            [37,"48 cm","2746 g", Rez.Strings.size37, Rez.Drawables.size37],
            [38,"49 cm","2966 g", Rez.Strings.size38, Rez.Drawables.size38],
            [39,"50 cm","3186 g", Rez.Strings.size39, Rez.Drawables.size39],
            [40,"50 cm","3404 g", Rez.Strings.size40, Rez.Drawables.size40],
            [41,"52 cm","3600 g", Rez.Strings.size41, Rez.Drawables.size41],
            [42,"52 cm","3600 g", Rez.Strings.size42, Rez.Drawables.size42],
            [43,"-- cm","- g", Rez.Strings.size43, Rez.Drawables.size43],
    ] as Array<Array<Number or String or Lang.ResourceId>>;


    function initialize() {
        
    }

    function getStatsforWeek(week as Number) as Array {
        // Adjust week based on setting (cache the property lookup)
        var weekSetting = Properties.getValue("weekSetting");
        if (weekSetting == 0) {
            week += 1; // adjust if week setting is 9W+2 = 9WoP
        }
        
        // Handle overflow with single check
        var tableIndex = (week < 42) ? week : 43;
        
        return statsTable[tableIndex] as Array;
    }
}