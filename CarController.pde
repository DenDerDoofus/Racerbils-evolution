class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  float mutation_rate = 0.04;
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();
  float fitness = 0.0;
  
  int laptime = 1000;
  int generationTime = 0;
  
  boolean active = true;
      
  void update() {
    if (sensorSystem.whiteSensorFrameCount == 0 && !check_if_lap_crossed()){
    //1.)opdtarer bil 
      bil.update();
      //2.)opdaterer sensorer    
      sensorSystem.updateSensorsignals(bil.pos, bil.vel);
      //3.)hjernen beregner hvor meget der skal drejes
      float turnAngle = 0;
      float x1 = int(sensorSystem.leftSensorSignal);
      float x2 = int(sensorSystem.frontSensorSignal);
      float x3 = int(sensorSystem.rightSensorSignal);    
      turnAngle = hjerne.getOutput(x1, x2, x3);    
      //4.)bilen drejes
      bil.turnCar(turnAngle);
    }
    
  }
  
  void display(){
    bil.displayCar();
    sensorSystem.displaySensors();
  }
  
  boolean check_if_lap_crossed(){
    if (sensorSystem.lastGreenDetection == true && sensorSystem.clockWiseRotationFrameCounter > 0){
      laptime = frameCount - generationTime;
      return true;
    } else {
      return false;
    }
  }
  
  
  CarController crossover(CarController Partner){
    CarController child = new CarController();
    
    //Weights
    int weight_midpoint = int(random(hjerne.weights.length));
    
    for(int i = 0; i < hjerne.weights.length;i++){
      if (i < weight_midpoint){
        child.hjerne.weights[i] = hjerne.weights[i];
      } else {
      
        child.hjerne.weights[i] = Partner.hjerne.weights[i];
      }
    }
    
    
    //Biases
    int biases_midpoint = int(random(hjerne.biases.length));
    
    for(int x = 0; x < hjerne.biases.length;x++){
      if (x < biases_midpoint){
        child.hjerne.biases[x] = hjerne.biases[x];
      } else {
      
        child.hjerne.biases[x] = Partner.hjerne.biases[x];
      }
    }
    
    return child;
  }
  
  void mutate(){
    for (int i=0;i<hjerne.weights.length -1;i++){      
      if (random(1) < mutation_rate){
        hjerne.weights[i] = random(-varians,varians);
      }
    }
    
    for (int i=0;i<hjerne.biases.length -1;i++){
      if (random(1) < mutation_rate){
        hjerne.biases[i] = random(-varians,varians);
      }
    }
    
  }
  
  void evaluate(){
    if (sensorSystem.clockWiseRotationFrameCounter <= 0.0){
      fitness = -1.0;
    } else {
    
    fitness = max(sensorSystem.clockWiseRotationFrameCounter + (1000 - laptime),1);
    }
  }
  

}
