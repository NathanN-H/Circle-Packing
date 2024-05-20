import java.util.Arrays;

class OrderedCrossover {
     Individual crossover(Individual parent1, Individual parent2) {
        int[] offspringOrdering = new int[parent1.ordering.length];

        int startPos = (int) (Math.random() * parent1.ordering.length);
        int endPos = (int) (Math.random() * parent1.ordering.length);

        if (startPos > endPos) {
            int temp = startPos;
            startPos = endPos;
            endPos = temp;
        }

        for (int i = startPos; i <= endPos; i++) {
            offspringOrdering[i] = parent1.ordering[i];
        }

        int parentIndex = 0;
        for (int i = 0; i < offspringOrdering.length; i++) {
            if (i < startPos || i > endPos) {
                boolean found = false;
                for (int j = startPos; j <= endPos; j++) {
                    if (parent2.ordering[parentIndex] == offspringOrdering[j]) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    offspringOrdering[i] = parent2.ordering[parentIndex++];
                }
            }
        }

        return new Individual(offspringOrdering);
    }
}
