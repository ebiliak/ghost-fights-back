Ghost ghost; // Declare the ghost

void setup() {
    size(800, 800);
    ghost = new Ghost(); // Initialize the ghost
}

void draw() {
    background(255);
    
    // Update and display the ghost
    ghost.update(); // Update ghost position based on mouse
    ghost.show(); // Draw the ghost
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
