int SAMPLES = 10;
Scene scene;
Camera camera;

//gibook
//g1b00k


void setup() {
  size(256, 256);
  scene = initScene();
  camera = new Camera(
    new Vec(0.0, 1.0, 5.0),
    new Vec(0.0, 0.0, 0.0),
    new Vec(0.0, 2.0, 0.0)
  );
  
  Vec vec = new Vec(1.0, 2.0, 3.0);
  println(vec);
  
  for (int iy = 0; iy < height; iy ++) {
    for (int ix = 0; ix < width; ix ++) {
      stroke(calcPixelColor(ix, iy));
      point(ix, iy);
    }
  }
  
  noLoop();
}

Scene initScene(){
  Scene scene = new Scene();
  //Vec sphereCenter = new Vec(0.0, 0.0, 0.0);
  //float sphereR = 1.0;
  //scene.add(new Sphere(sphereCenter, sphereR));
  
  for (int i = 0; i < 5; i ++) {
    Vec sphereCenter = new Vec(i - 2, 0.0, i - 2);
    float sphereR = 0.7;
    Material sphereMaterial = new Material(new Spectrum(1.0, i * 0.25, 0.0));
    sphereMaterial.reflective = 0.5;
    Sphere sphere = new Sphere(sphereCenter, sphereR, sphereMaterial);
    scene.add(sphere);
  }
  
  {
    Vec sphereCenter = new Vec(0.0, 10.0, 0.0);
    float sphereR = 7.0;
    Material sphereMaterial = new Material(new Spectrum(0.0, 0.0, 0.0));
    sphereMaterial.emissive = new Spectrum(8.0, 8.0, 8.0);
    Sphere sphere = new Sphere(sphereCenter, sphereR, sphereMaterial) ;
    scene.add(sphere);
  }
  
  Material material = new Material( new Spectrum(0.2, 0.2, 0.2) );
  Plane plane = new Plane( 
    new Vec(0.0, -0.7, 0.0),
    new Vec(0.0, 1.0, 0.0),
    material
  );
  plane.material.reflective = 0.5;
  scene.add(plane);
  
  return scene;
}
  
  
color calcPixelColor(int x, int y) {
  Ray ray = camera.ray(x, y);
  
  Spectrum sum = new Spectrum(0.0, 0.0, 0.0);
  
  for(int i = 0; i < SAMPLES; i++){
    sum = sum.add(scene.trace(ray, 0));
  }
  return sum.scale(1.0 / SAMPLES).toColor();
    
  
  //Spectrum spc = scene.trace(ray, 0);
  //return spc.toColor();
}