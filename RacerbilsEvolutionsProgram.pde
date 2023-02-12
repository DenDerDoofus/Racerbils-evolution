//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int populationSize  = 100;     
int generation = 1;
float last_gen_average_fitness = 0.0;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 800);
  trackImage = loadImage("track.png");
  frameRate(60);
}

void keyPressed(){
  if(key == 'r'){
    last_gen_average_fitness = carSystem.get_average_fitness();
    carSystem.new_gen();
    generation += 1;
  }
}

void draw() {
  clear();
  fill(255);
  rect(0,50,1000,1000);
  image(trackImage,0,80);  

  carSystem.updateAndDisplay();
  textSize(22);
  fill(255);
  text("tryk R for at starte en ny generation", 40 , 30);
  
  fill(0);

  text("Population Size: " + populationSize,40,525);
  text("Mutation Rate: " + carSystem.CarControllerList.get(0).mutation_rate * 100 + "%",40,550);
  text("Generation: " + generation,40,600);
  text ("Last gen average fitness: " + last_gen_average_fitness,40,625);
  text("Fastest Lap: " + carSystem.fastest_lap + " sec",40,650);
  text("Active: " + carSystem.active,40,700);
  text("Crashed: " + carSystem.crashed,40,725);
  text("Crossed finish line: " + carSystem.finished_lap,40,750);
  
  
  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
  /* if (frameCount%200==0) {
      println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
      for (int i = carSystem.CarControllerList.size()-1 ; i >= 0;  i--) {
        SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
        if(s.whiteSensorFrameCount > 0){
          carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
         }
      }
    }*/
    //
}
