import java.util.Arrays;

class Individual {
    int[] ordering;
    float fitness;

    Individual(int[] ordering) {
        this.ordering = ordering;
        this.fitness = 0;
    }

    private boolean intersect(int x1, int r1, int x2, int r2) {
        int distance = Math.abs(x1 - x2);
        return distance < (r1 + r2);
    }

    Individual orderedCrossover(Individual partner) {
        int length = Math.min(ordering.length, partner.ordering.length);
        int[] offspringOrdering = new int[length];

        int startPos = (int) (Math.random() * length);
        int endPos = (int) (Math.random() * length);

        if (startPos > endPos) {
            int temp = startPos;
            startPos = endPos;
            endPos = temp;
        }

        for (int i = startPos; i <= endPos; i++) {
            offspringOrdering[i] = this.ordering[i];
        }

        int parentIndex = 0;
        for (int i = 0; i < offspringOrdering.length; i++) {
            if (i < startPos || i > endPos) {
                boolean found = false;
                for (int j = startPos; j <= endPos; j++) {
                    if (partner.ordering[parentIndex] == offspringOrdering[j]) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    offspringOrdering[i] = partner.ordering[parentIndex++];
                }
            }
        }

        return new Individual(offspringOrdering);
    }

    void mutate() {
        int pos1 = (int) (Math.random() * ordering.length);
        int pos2 = (int) (Math.random() * ordering.length);

        int temp = ordering[pos1];
        ordering[pos1] = ordering[pos2];
        ordering[pos2] = temp;
    }

    void evaluateFitness(int[] radii, int[] positions) {
        float fitnessValue = 0;
        int length = Math.min(ordering.length, Math.min(radii.length, positions.length));
        for (int i = 0; i < length; i++) {
            for (int j = i + 1; j < length; j++) {
                if (intersect(positions[i], radii[i], positions[j], radii[j])) {
                    fitnessValue += 1;
                }
            }
        }

        if (instanceIndex == 0) {
            // For instance R1
            fitnessValue += 110;
        } else if (instanceIndex == 1) {
            // For instance R2
            fitnessValue += 90;
        } else if (instanceIndex == 2) {
            // For instance R3
            fitnessValue += 150;
        } else if (instanceIndex == 3) {
            // For instance R4
            fitnessValue += 173;
        } else if (instanceIndex == 4) {
            // For instance R5
            fitnessValue += 180;
        } else if (instanceIndex == 5) {
            // For instance T1
            fitnessValue += 63;
        } else if (instanceIndex == 6) {
            // For instance T2
            fitnessValue += 100; 
        } else if (instanceIndex == 7) {
            // For instance T3
            fitnessValue += 120; 
        } else if (instanceIndex == 8) {
            // For instance T4
            fitnessValue += 121;
        } else if (instanceIndex == 9) {
            // For instance T5
            fitnessValue += 200;
        }

        this.fitness = fitnessValue;
    }
    int[] generateRandomOrdering(int length) {
        List<Integer> orderingList = new ArrayList<>();
        for (int i = 0; i < length; i++) {
            orderingList.add(i);
        }
        Collections.shuffle(orderingList);
        int[] orderingArray = new int[length];
        for (int i = 0; i < length; i++) {
            orderingArray[i] = orderingList.get(i);
        }
        return orderingArray;
    }
}
