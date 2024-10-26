Bacteria[] bacteria;
int numBacteria = 1000; 
Ghost ghost; 

void setup() {
    size(800, 800);
    bacteria = new Bacteria[numBacteria]; 
    for (int i = 0; i < numBacteria; i++) {
        bacteria[i] = new Bacteria(random(width), random(height)); 
    }
    ghost = new Ghost(); 
}

void draw() {
    background(255);
    
  
    ghost.update(); 
    ghost.show();

    for (int i = 0; i < bacteria.length; i++) {
        if (bacteria[i] != null) {
            bacteria[i].move(); 
            bacteria[i].show(); 
        }
    }


    for (int i = 0; i < bacteria.length; i++) {
        if (bacteria[i] != null && bacteria[i].canReproduce()) {
            int index = findEmptyBacteriaSlot();
            if (index != -1) {
                bacteria[index] = bacteria[i].reproduce(); 
            }
        }
    }
}


int findEmptyBacteriaSlot() {
    for (int i = 0; i < bacteria.length; i++) {
        if (bacteria[i] == null) {
            return i;
        }
    }
    return -1; 
}

class Bacteria {
    int x, y; 
    color c;

    Bacteria(float startX, float startY) {
        x = int(startX);
        y = int(startY);
        c = color(255, 247, 3); 
    }

   
    void move() {
        float bias = 0.1;
        float targetX = mouseX;
        float targetY = mouseY;

        float moveX = (float)(Math.random() * 2 - 1); 
        float moveY = (float)(Math.random() * 2 - 1);


        if (dist(x, y, targetX, targetY) < 100) {
            moveX += (targetX - x) * bias;
            moveY += (targetY - y) * bias;
        }

        x += int(moveX);
        y += int(moveY);


        x = constrain(x, 0, width - 1);
        y = constrain(y, 0, height - 1);
    }


    void show() {
        fill(c);
    
        float pacmanSize = 10; 
        float startAngle = radians(45); 
        float stopAngle = radians(315); 
        arc(x, y, pacmanSize, pacmanSize, startAngle, stopAngle, PIE);
        
        fill(0);
        float eyeX = x + pacmanSize * 0.7;
        float eyeY = y - pacmanSize * 0.2; 
        ellipse(eyeX-9, eyeY, 1, 1); 
    }


    boolean canReproduce() {
        return Math.random() < 0.01; 
    }

   
    Bacteria reproduce() {
        return new Bacteria(x, y); 
    }
}

class Ghost {
    float x, y;

    Ghost() {
        x = width / 2; 
        y = height / 2;
    }

  
    void update() {
        x = mouseX; 
        y = mouseY; 
    }

   
    void show() {
        fill(255, 0, 0);
        noStroke();
        ellipse(x, y, 30, 30); 
        fill(255); 
        ellipse(x - 10, y - 5, 10, 10); 
        ellipse(x + 10, y - 5, 10, 10); 
        fill(0); 
        ellipse(x - 10, y - 5, 5, 5); 
        ellipse(x + 10, y - 5, 5, 5); 
    }
}
