ArrayList<Tile> arlTiles = new ArrayList<Tile>();
SpriteDiscrete sprHero;
boolean bKeys[] = new boolean[4];
void setup() {
  size(800, 500);
  sprHero = new SpriteDiscrete("img.png", 0, 0, 0.5, 0, 10, 50, 50);

  for (int i = 0; i < 10; i ++) {
    arlTiles.add(new Tile("img.png", 100 * i, 400, 100, 50));
  }
  
  arlTiles.add(new Tile("img.png", 400,280,100,50));
}

void draw() {
  background(20);
  if (bKeys[0]) {
    sprHero.jump();
  }
  if (bKeys[1]) {
    sprHero.changeDir(-3);
  } else if (bKeys[2]) {
    sprHero.changeDir(3);
  } else {
    sprHero.changeDir(0);
  }
  sprHero.move(arlTiles);
  sprHero.display();

  for (int i = arlTiles.size() - 1; i > -1; i --) {
    arlTiles.get(i).display();
  }
}

void keyPressed() {
  if (key == 'W' || key == 'w') {
    bKeys[0] = true;
  }

  if (key == 'A' || key == 'a') {
    bKeys[1] = true;
  } 
  
  if (key == 'D' || key == 'd') {
    bKeys[2] = true;
  }
}

void keyReleased() {
  if (key == 'W' || key == 'w') {
    bKeys[0] = false;
  }
  if (key == 'A' || key == 'a') {
    bKeys[1] = false;
  } 
  if (key == 'D' || key == 'd') {
    bKeys[2] = false;
  }
}