Bacteria[] bacteria;
int numBacteria = 1000; // Number of bacteria
Ghost ghost; // Declare the ghost

void setup() {
    size(800, 800);
    bacteria = new Bacteria[numBacteria]; // Initialize the array of bacteria
    for (int i = 0; i < numBacteria; i++) {
        bacteria[i] = new Bacteria(random(width), random(height)); // Create bacteria at random positions
    }
    ghost = new Ghost(); // Initialize the ghost
}

void draw() {
    background(255);
    
    // Update and display the ghost
    ghost.update(); // Update ghost position based on mouse
    ghost.show(); // Draw the ghost

    for (int i = 0; i < bacteria.length; i++) {
        if (bacteria[i] != null) {
            bacteria[i].move(); // Move the bacteria
            bacteria[i].show(); // Draw the bacteria
        }
    }

    // Reproduce new bacteria
    for (int i = 0; i < bacteria.length; i++) {
        if (bacteria[i] != null && bacteria[i].canReproduce()) {
            int index = findEmptyBacteriaSlot();
            if (index != -1) {
                bacteria[index] = bacteria[i].reproduce(); // Create a new bacteria
            }
        }
    }
}

// Method to find an empty slot in the bacteria array
int findEmptyBacteriaSlot() {
    for (int i = 0; i < bacteria.length; i++) {
        if (bacteria[i] == null) {
            return i;
        }
    }
    return -1; // No empty slot found
}

class Bacteria {
    int x, y; // Position of the bacteria
    color c; // Color of the bacteria

    Bacteria(float startX, float startY) {
        x = int(startX);
        y = int(startY);
        c = color(255, 247, 3); // Bacteria color
    }

    // Method to move the bacteria with a biased random walk towards the mouse
    void move() {
        float bias = 0.1; // Bias towards the mouse
        float targetX = mouseX;
        float targetY = mouseY;

        float moveX = (float)(Math.random() * 2 - 1); // Random movement in x direction
        float moveY = (float)(Math.random() * 2 - 1); // Random movement in y direction

        // Adjust the movement based on the bias towards the mouse
        if (dist(x, y, targetX, targetY) < 100) {
            moveX += (targetX - x) * bias;
            moveY += (targetY - y) * bias;
        }

        x += int(moveX);
        y += int(moveY);

        // Keep the bacteria within the window bounds
        x = constrain(x, 0, width - 1);
        y = constrain(y, 0, height - 1);
    }

    // Method to draw the bacteria as Pac-Man
    void show() {
        fill(c);
        // Draw Pac-Man shape using an arc
        float pacmanSize = 10; // Size of Pac-Man
        float startAngle = radians(45); // Start angle of the arc
        float stopAngle = radians(315); // Stop angle of the arc
        arc(x, y, pacmanSize, pacmanSize, startAngle, stopAngle, PIE);
        
        fill(0); // Set color to black for the eye
        float eyeX = x + pacmanSize * 0.7; // Adjust position of the eye
        float eyeY = y - pacmanSize * 0.2; // Adjust position of the eye
        ellipse(eyeX, eyeY, 2, 2); // Draw the eye
    }

    // Check if the bacteria can reproduce
    boolean canReproduce() {
        return Math.random() < 0.01; // Random chance to reproduce (1% each frame)
    }

    // Method to reproduce and return a new bacteria
    Bacteria reproduce() {
        return new Bacteria(x, y); // Create a new bacteria at the same position
    }
}

class Ghost {
    float x, y; // Position of the ghost

    Ghost() {
        x = width / 2; // Start in the center (optional)
        y = height / 2; // Start in the center (optional)
    }

    // Method to update ghost position based on mouse
    void update() {
        x = mouseX; // Follow the mouse's X position
        y = mouseY; // Follow the mouse's Y position
    }

    // Method to draw the ghost
    void show() {
        fill(255, 0, 0); // Red color for the ghost
        noStroke();
        ellipse(x, y, 30, 30); // Body
        fill(255); // White color for the eyes
        ellipse(x - 10, y - 5, 10, 10); // Left eye
        ellipse(x + 10, y - 5, 10, 10); // Right eye
        fill(0); // Black color for the pupils
        ellipse(x - 10, y - 5, 5, 5); // Left pupil
        ellipse(x + 10, y - 5, 5, 5); // Right pupil
    }
}
