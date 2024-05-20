class Circle {
    int x, y, i;
    int radius;
    boolean computed;

    Circle(int r, int num) {
        x = 0;
        y = 0;
        radius = r;
        i = num;
        computed = false;
    }

    void computePosition(Circle[] c) {
        boolean collision;
        Point[] openPoints = new Point[0];
        Point pnt;

        if (computed) {
            return;
        }

        for (Circle circle : c) {
            if (circle.computed) {
                for (int ang = 0; ang < 360; ang += 1) {
                    collision = false;
                    pnt = new Point();
                    pnt.x = circle.x + (int) (Math.cos(ang * Math.PI / 180) * (radius + circle.radius + 1));
                    pnt.y = circle.y + (int) (Math.sin(ang * Math.PI / 180) * (radius + circle.radius + 1));

                    for (Circle value : c) {
                        if (value.computed && !collision) {
                            if (dist(pnt.x, pnt.y, value.x, value.y) < radius + value.radius) {
                                collision = true;
                            }
                        }
                    }

                    if (!collision) {
                        openPoints = expand(openPoints, openPoints.length + 1);
                        openPoints[openPoints.length - 1] = pnt;
                    }
                }
            }
        }

        float min_dist = -1;
        int best_point = 0;
        for (int i = 0; i < openPoints.length; i++) {
            if (min_dist == -1 || dist(cx, cy, openPoints[i].x, openPoints[i].y) < min_dist) {
                best_point = i;
                min_dist = dist(cx, cy, openPoints[i].x, openPoints[i].y);
            }
        }
        if (openPoints.length == 0) {
            println("no points?");
        } else {
            x = openPoints[best_point].x;
            y = openPoints[best_point].y;
        }
        computed = true;
    }

    void draw() {
        fill(255);
        ellipseMode(CENTER);
        ellipse(x, y, radius * 2, radius * 2);
        fill(255, 0, 0);
        textFont(f, 8);
        text("" + i, x, y);
    }
}
