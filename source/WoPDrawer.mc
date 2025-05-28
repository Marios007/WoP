import Toybox.Graphics;

class WoPDrawer {

    private var thickness = 2;

    function initialize() {
        }

    // drawing the grey arc and the status of pregnancy as arc
    function drawStatusCircle(dc,center_x,center_y, trimester, angle, tri2angle, tri3angle) as Void {

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        var radius;
        if (center_x < center_y) {
            radius = center_x-3;
        } 
        else {
            radius = center_y-3;
        }

        //draw 1 gray arcs
        dc.setPenWidth(((dc.getWidth()/32)).toNumber());
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 0, 360);
        // draw week on arc 
        //var angle = _currentWoP.get(:angle);
        dc.setPenWidth(((dc.getWidth()/25)).toNumber());
        switch (trimester) {
            case 1:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, angle);
                break;
            case 2:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, tri2angle);
                dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, tri2angle + thickness, angle);
                break;
            case 3:
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 90, tri2angle);
                dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, tri2angle + thickness, tri3angle + thickness);
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
                dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, tri3angle - thickness, angle);
                break;
            case 4:
                break;
        }


        // draw 3 black rectangle to seperate grey arc
        dc.setPenWidth(((dc.getWidth()/15)).toNumber());
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, 92, 88);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, tri2angle + thickness, tri2angle - thickness); // old 344/340
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, tri3angle + thickness, tri3angle - thickness); //old 236/232
        // draw white arc for current week on the circle
        dc.setPenWidth(((dc.getWidth()/15)).toNumber());
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle+2, angle-2);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle+3, angle+2);
        dc.drawArc(center_x, center_y, radius, Graphics.ARC_CLOCKWISE, angle-2, angle-3);
    }
}
