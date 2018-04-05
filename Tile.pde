class Tile {
  PImage img;
  float fX, fY;
  int nW, nH;
  Tile(String sImg_, float fX_, float fY_, int nW_, int nH_) {
    img = loadImage(sImg_);
    fX = fX_;
    fY = fY_;
    nW = nW_;
    nH = nH_; 
        img.resize(nW,nH);

  }
  
  void display() {
    image(img,fX,fY);
  }
}