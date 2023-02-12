class CarSystem {
  //CarSystem - 
  
  int populationSize = 0;
  float fastest_lap = 0;
  int crashed = 0;
  int active = 0;
  int finished_lap = 0;
  
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser
  
  ArrayList<CarController> breeding_pool = new ArrayList<CarController>();
  
  
  
  
  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();

  CarSystem(int Size) {
    populationSize = Size;
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
      active = populationSize;
    }
  }


  void new_gen(){
    //Clears old cars
    //float[] old_brain = CarControllerList.get(0).hjerne.weights.clone();
    breeding_pool.clear();
    for (int i=0; i<populationSize; i++) { 
         
      for(int h=0; h<CarControllerList.get(i).fitness;h++){
        breeding_pool.add(CarControllerList.get(i));
      }
      
    } 



  //Reproduction
  
    for (int x=0; x<populationSize; x++){
    int a = int(random(breeding_pool.size()));
    int b = int(random(breeding_pool.size()));
    CarController ParentA = breeding_pool.get(a);
    CarController ParentB = breeding_pool.get(b);
    
    CarController Child = ParentA.crossover(ParentB);
    Child.mutate();
    
    CarControllerList.set(x,Child);
    CarControllerList.get(x).generationTime = frameCount;
    }
    fastest_lap = 0;
    active = populationSize;
    crashed = 0;
    finished_lap = 0;


  }
  
  float get_average_fitness(){
    float fitness_score = 0.0;
    
    for (int i = 0; i <populationSize;i++){
    CarControllerList.get(i).evaluate();
    fitness_score += CarControllerList.get(i).fitness;
    }
    fitness_score = fitness_score/populationSize;
    
    return fitness_score;
  }

  void updateAndDisplay() {
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();

    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();

      
      if (controller.active == true){
        
        if (controller.sensorSystem.whiteSensorFrameCount != 0){
          crashed += 1;
          active -= 1;
          controller.active = false;
          }
        
        if (controller.check_if_lap_crossed()){
        
        if (fastest_lap == 0){
        fastest_lap = controller.laptime/60.0;
        }
          finished_lap += 1;
          active -= 1;
          controller.active = false;
        }
      }
    
    }
  }
}
