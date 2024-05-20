import java.util.Arrays;

class Population {
    Individual[] individuals;

    Population(int size, int[] radii) {
        individuals = new Individual[size];
        for (int i = 0; i < size; i++) {
            int[] ordering = generateRandomOrdering(radii.length);
            individuals[i] = new Individual(ordering);
        }
    }
    Individual selectParent() {
          float totalFitness = 0;
          for (Individual individual : individuals) {
              totalFitness += individual.fitness;
          }
          
          float randomFitness = (float) (Math.random() * totalFitness);
          float cumulativeFitness = 0;
          for (Individual individual : individuals) {
              cumulativeFitness += individual.fitness;
              if (cumulativeFitness >= randomFitness) {
                  return individual;
              }
          }
          return individuals[0];
      }
    private int[] generateRandomOrdering(int length) {
        int[] ordering = new int[length];
        for (int i = 0; i < length; i++) {
            ordering[i] = i;
        }
        for (int i = length - 1; i > 0; i--) {
            int index = (int) (Math.random() * (i + 1));
            int temp = ordering[index];
            ordering[index] = ordering[i];
            ordering[i] = temp;
        }
        return ordering;
    }

    void evaluateFitness(int[] radii, int[] positions) {
        for (Individual individual : individuals) {
            individual.evaluateFitness(radii, positions);
        }
    }

    Individual getFittest() {
        Individual fittest = individuals[0];
        for (Individual individual : individuals) {
            if (individual.fitness > fittest.fitness) {
                fittest = individual;
            }
        }
        return fittest;
    }
    void replaceLeastFit(Individual offspring) {
        Individual leastFit = individuals[0];
        int leastFitIndex = 0;
        for (int i = 1; i < individuals.length; i++) {
            if (individuals[i].fitness < leastFit.fitness) {
                leastFit = individuals[i];
                leastFitIndex = i;
            }
        }
        individuals[leastFitIndex] = offspring;
    }
}
