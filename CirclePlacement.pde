import java.util.Arrays; 
import java.util.Collections;
import java.util.List;
import java.util.Random;

Bunch OrderedCircles;
GreedyPlace GreedyCircles;
Bunch GeneticCircles;

boolean computed;
int drawWhich;

int w = 800;
int h = 600;
int cx = w / 2;
int cy = h / 2;
PFont f;
Random rand = new Random();

int[] radom = {10, 40, 25, 15, 18};
Bunch instance;
int instanceIndex;
String[] instanceNames = {"R1", "R2", "R3", "R4", "R5", "T1", "T2", "T3", "T4", "T5"};
int[][] radii = {
    {10, 12, 15, 20, 21, 30, 30, 30, 50, 40},
    {10, 40, 25, 15, 18},
    {10, 34, 10, 55, 30, 14, 70, 14},
    {5, 50, 50, 50, 50, 50, 50},
    {10, 34, 10, 55, 30, 14, 70, 14, 50, 16, 23, 76, 34, 10, 12, 15, 16, 11, 48, 20},
    {20, 22, 17, 17, 7, 21, 11, 5, 23, 8},
    {8, 14, 8, 15, 11, 17, 21, 16, 6, 18, 24, 13, 20, 10},
    {24, 16, 19, 7, 14, 24, 15, 6, 16, 16, 23, 10, 9, 10, 18, 22, 7, 9, 7, 13, 14, 8, 18, 6, 8},
    {6, 12, 20, 6, 14, 19, 9, 20, 10, 13, 12, 14, 23, 17, 16, 19, 15, 10, 12, 18, 21, 6, 20, 17, 13, 20, 17, 6, 21, 15, 12, 9, 14, 20, 23, 16, 23, 9, 23, 18},
    {17, 23, 17, 13, 18, 21, 23, 22, 7, 9, 8, 13, 20, 11, 10, 19, 10, 14, 12, 22, 19, 10, 17, 11, 21, 8, 15, 16, 19, 21, 17, 19, 8, 6, 13, 13, 14, 19, 18, 23, 20, 24, 24, 13, 13, 19, 7, 6, 10, 8, 8, 10, 24, 19, 24}
};
int[][] orders = {
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {0, 1, 2, 3, 4},
    {0, 1, 2, 3, 4, 5, 6, 7},
    {0, 1, 2, 3, 4, 5, 6},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
};

int algorithmIndex = 0;
String[] algorithmNames = {"ORDER-BASED", "GREEDY", "GENETIC"};

void setup() {
    size(800, 600);
    f = createFont("Arial", 16, true);
    instanceIndex = rand.nextInt(instanceNames.length); 
    instance = new Bunch(radii[instanceIndex]);
    instance.orderedPlace(orders[instanceIndex]);
    
    int[] selectedRadii = Arrays.copyOfRange(radii[instanceIndex], 0, 5);
    int[] selectedOrders = Arrays.copyOfRange(orders[instanceIndex], 0, 5);
    
    OrderedCircles = new Bunch(radii[instanceIndex]);

    GreedyCircles = new GreedyPlace(radom);
    
    int[] geneticOrdering = new Individual(new int[0]).generateRandomOrdering(selectedRadii.length);
    Individual geneticIndividual = new Individual(geneticOrdering);
    geneticIndividual.evaluateFitness(selectedRadii, selectedOrders);

    noLoop(); 
}

void draw() {
    background(255);
    fill(0);
    textFont(f, 24); 
    
    float boundary = 0;
    
    if (algorithmIndex == 0) {
        boundary = instance.computeBoundary();
        instance.draw();
        
        fill(0); 
        text("ORDER-BASED PLACEMENT", 50, 30); 
        text("Boundary circle radius: " + boundary, 50, 70); 
        println("Order-Based Placement Boundary: " + boundary);
        
    } else if (algorithmIndex == 1) {
        boundary = GreedyCircles.greedyPlacement();
        GreedyCircles.greedyCircles.draw();
        
        fill(0); 
        text("GREEDY PLACEMENT", 50, 30); 
        text("Boundary circle radius: " + boundary, 50, 70);
        println("Greedy Placement Boundary: " + boundary);
        
    } else if (algorithmIndex == 2) {
      
        Population population = new Population(50, radii[instanceIndex]);
        population.evaluateFitness(radii[instanceIndex], orders[instanceIndex]);
        
        for (int generation = 1; generation <= 100; generation++) {
            Individual parent1 = population.selectParent();
            Individual parent2 = population.selectParent();
            
            Individual offspring = parent1.orderedCrossover(parent2);
            
            offspring.mutate();
            
            offspring.evaluateFitness(radii[instanceIndex], orders[instanceIndex]);
            
            population.replaceLeastFit(offspring);
            
            generation++;
            delay(100);
            
            println("Generation: " + generation + ", Best Fitness: " + population.getFittest().fitness);
        }
        
        Individual bestIndividual = population.getFittest();
        
        boundary = computeBoundary(bestIndividual, radii[instanceIndex]);
        
        displayBestPlacement(bestIndividual);
        
        fill(0);
        text("GENETIC PLACEMENT", 50, 30);
        text("Boundary circle radius: " + boundary, 50, 70); 
        println("Genetic Placement Boundary: " + boundary);
    }
    noLoop();
}

float computeBoundary(Individual individual, int[] radii) {
    Bunch bestBunch = new Bunch(radii);
    bestBunch.orderedPlace(individual.ordering);
    return bestBunch.computeBoundary();
}

void displayBestPlacement(Individual bestPlacement) {
    Bunch bestBunch = new Bunch(radii[instanceIndex]);
    bestBunch.orderedPlace(bestPlacement.ordering);
    bestBunch.draw();
}

void mousePressed() {
    algorithmIndex = (algorithmIndex + 1) % 3; 
    redraw();
}

Point[] expand(Point[] arr, int newSize) {
    return Arrays.copyOf(arr, newSize);
}

float dist(int x1, int y1, int x2, int y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}
