class Bunch {
    Circle[] Circles;
    int numCircles;

    Bunch(int[] radii) {
        Circles = new Circle[radii.length];
        numCircles = radii.length;
        for (int i = 0; i < numCircles; i++) {
            Circles[i] = new Circle(radii[i], i);
        }
    }

    public void draw() {
        float bound = computeBoundary();
        stroke(0);
        fill(255);
        ellipse(cx, cy, bound * 2, bound * 2);
        for (Circle circle : Circles) {
            if (circle.computed) {
                circle.draw();
            }
        }
    }

    public void orderedPlace(int[] ordering) {
        if (ordering.length > numCircles) {
            println("Error: Ordering array is larger than the number of circles.");
            return;
        }

        Circles[ordering[0]].x = cx;
        Circles[ordering[0]].y = cy;
        Circles[ordering[0]].computed = true;
        for (int i = 1; i < ordering.length; i++) {
            Circles[ordering[i]].computePosition(Circles);
        }
    }

    float computeBoundary() {
        float outer_limit = 0;
        for (Circle circle : Circles) {
            if (circle.computed) {
                int farx = circle.x - w / 2;
                int fary = circle.y - h / 2;
                float dist = circle.radius + (sqrt((farx * farx) + (fary * fary)));
                if (dist >= outer_limit) {
                    outer_limit = dist;
                }
            }
        }
        return outer_limit;
    }
}
