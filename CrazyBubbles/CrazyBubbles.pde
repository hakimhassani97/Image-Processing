/*
HASSANI Hakim M1 MIV 2018/2019
-draw circles in a circular path
-press 'p' to save image as "PNG"
*/

float i=0,r=0,g=0,b=0;
int x=0,y=0,pas=1;
float size=10;
int curr=0;
int nCircles=30;
int niveaux=6;
PVector p1=new PVector(0,0);
ArrayList<Circle> l=new ArrayList<Circle>();
void setup() {
  size(500,500);
  background(0);
  remplirList();
}
void keyPressed(){
  if (keyPressed && key=='p') {
    saveFrame("animation.png");
  }
}
void draw() {
  background(0);
  translate(width/2,height/2);
  //translate(mouseX,mouseY);
  i-=PI/200;
  rotate(i);
  for(int i=0;i<l.size();i++){
    Circle c=l.get(i);
    c.draw();
    if((i)%nCircles>0) {
      //scale(0.8);
    }
  }
  if(frameCount%30==0){
    //enlever les cercles cachés
    for(int i=0;i<nCircles;i++)l.remove(0);
    p1.y=size;
    //ajouter de nouveaux cercles
    for(int i=0;i<nCircles;i++){
      l.add(new Circle((int)p1.x,(int)p1.y,size-nCircles,(int)random(255),(int)random(255),(int)random(255)));
      p1.y++;
      p1.rotate(2*PI/nCircles);
    }
  }
  if(frameCount%20==0) p1.rotate(PI/3);
  if(frameCount%60==0) if(nCircles>1)nCircles--;else nCircles=30;
}
void remplirList(){
  for(int j=0;j<niveaux;j++){
    //espace entre les niveauax
    p1.y=size;
    for(int i=0;i<nCircles;i++){
      l.add(new Circle((int)p1.x,(int)p1.y,size,(int)random(255),(int)random(255),(int)random(255)));
      p1.rotate(2*PI/nCircles);
    }
  }
  stroke(255);
}
