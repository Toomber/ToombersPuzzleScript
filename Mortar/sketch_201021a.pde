
int n = 5;
float colours = 8;
//color[] colours;
int frameNumber = 6;
//int[][] maskArray = {{0,1,1,1,0},{0,1,1,1,0},{1,1,1,1,1},{0,1,1,1,0},{0,1,0,1,0}};
//int[][] maskArray = {{0,1,1,1,0},{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1},{0,1,1,1,0}};
//int[][] maskArray = {{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1}};
int[][] maskArray = {{0,0,0,0,0},{0,1,1,1,0},{0,1,1,1,0},{0,1,1,1,0},{0,0,0,0,0}};

int removePerFrame = 2;

String objectName = "2Trail";

//glowing walls
//color colour1 = #bf0603;
//color colour2 = #69140e;

color colour1 = #bf0603;
color colour2 = #d58936;


void setup(){
  frameRate(10);
  size(300,300);
  noStroke();
  
  println("[ stationary player ][ " + objectName + str(frameNumber-1) +" ] -> [ stationary player ][ " + objectName + str(0) + " ]");
  for (int i = frameNumber-2; i>=0; i--){
  println("[ stationary player ][ " + objectName + str(i) +" ] -> [ stationary player ][ " + objectName + str(i+1) + " ]");  
  }
  
  println("");
  println("");
  print(objectName + " = ");
  for (int i = 0; i<frameNumber-1; i++){
    print(objectName + str(i) + " or ");  
  }
  print(objectName + str(frameNumber - 1)); 
  println("");
  
  

}

void draw() {
  if (frameCount -1 < frameNumber){
    int[][] colourArray = new int[n][n];
    

    println(" ");
    println(objectName + str(frameCount-1));
    for (int i = 0; i<= colours; i++){
      //print("#"+hex(color(i*255/colours,0,0),6)+" "); 
      print("#"+hex(lerpColor(colour1,colour2,i/colours),6)+" "); 
    }
    for (int y = 0; y < n; y++) {
      println(" ");
      for (int x = 0; x < n; x++) {
        int col = (int) val(x*width/n,y*width/n, frameCount)*maskArray[y][x];
        if (maskArray[y][x] == 0){
          print('.'); 
        }
        else{
         print(col);   
        }

        //fill(col*255/colours,0,0);
        fill(lerpColor(colour1,colour2,col/colours));
        rect(x*width/n,y*width/n, (x+1)*width/n, (y+1)*width/n);
        
        colourArray[x][y] = col;
      }
    }
    
    println(" ");
    
  }
  else
  {
    for (int y = 0; y < n; y++) {
        for (int x = 0; x < n; x++) {
          int col = (int) val(x*width/n,y*width/n, frameCount)*maskArray[y][x];
          //fill(col*255/colours,0,0);
          fill(lerpColor(colour1,colour2,col/colours));
          rect(x*width/n,y*width/n, (x+1)*width/n, (y+1)*width/n);
        }
      }  
  }
  //println(frameCount);
  
  //delete pixels for fade effect
   maskArray = deleteRandomPixels( maskArray, removePerFrame );
  
  
}

int[][] deleteRandomPixels( int[][] mask, int numberToDelete){
  
  int deleted = 0;
  int tries = 0;
  
  while (deleted < numberToDelete && tries < n*n){
  
    int deleteX = int(random(n));
    int deleteY = int(random(n));
    
    if (mask[deleteX][deleteY] == 1){
     mask[deleteX][deleteY] = 0; 
     deleted += 1;  
    }
    
    tries += 1;
  }
  
  
  return mask;
}

float val(float x, float y, float time){
 
  //float f = (sin(TWO_PI*x/width + TWO_PI*(y+40)/height - TWO_PI*time/frameNumber))
  //+ 0.8*(sin(PI+TWO_PI*x/width - TWO_PI*time/frameNumber))
  //+ 0.6*(cos(TWO_PI*(y+40)/width - TWO_PI*time/frameNumber));
  //f/=3;
  
    float f = (sin(TWO_PI*x/width + TWO_PI*(y+40)/height + TWO_PI*time/frameNumber))
  + 0.8*(sin(PI+TWO_PI*x/width + TWO_PI*time/frameNumber))
  + 0.6*(cos(TWO_PI*(y+40)/width + TWO_PI*time/frameNumber));
  f/=3;
  
  //float f = sin(TWO_PI*dist(x/width,y/width,.4,.4) - TWO_PI*time/frameNumber);
  return round(colours*(f+1)/2);
}
