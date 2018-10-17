/*
hakim hassani M1 MIV 2018/2019
LRE image compression ALgorithm
made for educational purpose and sorry for my dirty code x)
there are some unecessary parcours (i'll change them later) that i do in this algorithm to convert from a List to a String and vice versa
created on October 3rd,2018
*/
String [] input;//={'r,'r','r','b','c','r','r','r','c','c','r','n','m','m','n','m'};
ArrayList<String> l=new ArrayList<String>();
ArrayList<Object> m=new ArrayList<Object>();
PImage img;
void LRECoder(String[] s){
  int i=0,r=1;
  while(i<s.length-1){
    if(s[i]==s[i+1]){
      r++;
    }else{
      m.add(r);
      m.add(s[i]);
      r=1;
    }
    i++;
  }
  if(i<s.length) {
      m.add(r);
      m.add(s[i]);
  }
  int n=0;
  String ss="";
  for(int j=0;j<m.size();j+=2){
    if((int)m.get(j)>=3){
      n=(int)m.get(j);
      l.add((n+128)+"");l.add(m.get(j+1)+"");
    }else{
      n=0;ss="";
      while(j<m.size() && (int)m.get(j)<3){
        n+=(int)m.get(j);
        for(int t=0;t<(int)m.get(j);t++)
          ss+=m.get(j+1)+"";
        j+=2;
      }
      j-=2;
      l.add(n+"");l.add(ss+"");
    }
  }
}
String LREDecoder(){
  int n;
  String res="";
  for(int i=0;i<l.size();i+=2){
    n=Integer.parseInt((String)l.get(i));
    if(n>128){
      for(int j=0;j<n-128;j++){res+=l.get(i+1);}
      //res+=l.get(i+1);
    }else{
      for(int j=0;j<n;j++){res+=l.get(i+1).charAt(j);}
    }
  }
  return res;
}
void setup() {
  size(500,500);
  // Make a new instance of a PImage by loading an image file
  img = loadImage("w.png");
  // -1 white
  // -16777216 black
  // -8388608 midle
}
void draw() 
{
  background(0);
  // Draw the image to the screen at coordinate (0,0)
  image(img,0,0);
  
  loadPixels();
  String[] list=new String[pixels.length];
  for (int i = 0; i < pixels.length; i++) {
    //if(get(i%height,i/height)==-1) list[i]="F";else list[i]="B";
    if(get(i%height,i/height)>-8388608) list[i]="F";else list[i]="B";
  }
  updatePixels();
  /***  compression   ***/
  LRECoder(list);
  String[] res=new String[l.size()];
  for(int i=0;i<l.size();i++){
    res[i]=l.get(i);
  }
  String re="";
  for(int i=0;i<l.size();i++){
    re+=l.get(i);
  }
  String[] m=new String[1];
  m[0]=re;
  // Writes the strings to a file, each on a separate line
  saveStrings("compressed.txt", m);
  /***   decompression    ***/
  res = loadStrings("compressed.txt");
  l.clear();
  String ss="",ch="";
  for(int i=0;i<res[0].length();i++){
    if(i<res[0].length() && res[0].charAt(i)!='B' && res[0].charAt(i)!='F'){
      ss+=res[0].charAt(i);i++;
      while(i<res[0].length() && res[0].charAt(i)!='B' && res[0].charAt(i)!='F'){
        ss+=res[0].charAt(i);
        i++;
      }
      l.add(ss);ss="";
    }
    if(i<res[0].length() && (res[0].charAt(i)=='B' || res[0].charAt(i)=='F')){
      ch+=res[0].charAt(i);i++;
      while(i<res[0].length() && (res[0].charAt(i)=='B' || res[0].charAt(i)=='F')){
        ch+=res[0].charAt(i);
        i++;
      }
      l.add(ch);ch="";i--;
    }
  }
  String deco=LREDecoder();
  loadPixels();
  for (int i = 0; i < deco.length(); i++) {
    color c;if(deco.charAt(i)=='B') c=color(0);else c=color(255);
    pixels[i] = c;
  }
  updatePixels();
  
  stop();
}
