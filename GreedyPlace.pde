class GreedyPlace {
    int[] radii;
    Bunch greedyCircles;

    GreedyPlace(int[] inRad) {
        radii = Arrays.copyOf(inRad, inRad.length);
        //println("Created new RandomPlace:");
        //System.out.println(Arrays.toString(radii));
    }

    float greedyPlacement() {
        int[] radCopy = Arrays.copyOf(radii, radii.length);
        Random rand = new Random();
        for (int i = 0; i < radCopy.length; i++) {
            int randomIndex = rand.nextInt(radCopy.length);
            int temp = radCopy[randomIndex];
            radCopy[randomIndex] = radCopy[i];
            radCopy[i] = temp;
        }
        //println("Shuffled radii:");
        //System.out.println(Arrays.toString(radCopy));

        Bunch tmpBunch = new Bunch(radCopy);
        int[] ordering = new int[radCopy.length];
        for (int i = 0; i < ordering.length; i++) {
            ordering[i] = i;
        }
        tmpBunch.orderedPlace(ordering);

        greedyCircles = tmpBunch;
        return tmpBunch.computeBoundary();
    }
}
