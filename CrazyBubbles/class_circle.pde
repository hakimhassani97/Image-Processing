public class Circle{
  int x,y;
  float w;
  int r,g,b;
  Circle(int x,int y,float w,int r,int g,int b){
    this.x=x;this.y=y;this.w=w;
    this.r=r;this.g=g;this.b=b;
  }
  void draw(){
    fill(r,g,b);
    stroke(color(random(255),random(255),random(255)));
    strokeWeight(random(10));
    ellipse(this.x,this.y,this.w-7,this.w-7);
    //line(this.x,this.y,this.w,this.w);
    //triangle(this.x,this.y,this.w,this.w,this.w,this.w+10);
    // calculer un vecteur v (xp,yp) du point O vers le point (x,y)
    float ll=sqrt(pow(x,2)+pow(-y,2));
    float xp=x/ll,yp=y/ll;
    //faire un mouvement sur le vecteur v
    if(frameCount%2==0){x+=5*xp;y+=5*yp;w+=2;}
  }
}
