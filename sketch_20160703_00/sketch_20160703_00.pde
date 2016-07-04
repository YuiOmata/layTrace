int SAMPLES = 100;
float R = 0;
float G = PI*2/3;
float B = -G;
//gibook
//g1b00k

Scene scene;
Camera camera;

int BALL_NUM = 7;

void setup() {
  size(256, 256);
  scene = initScene();
  camera = new Camera(
    new Vec(0.0, 1.0, 5.0),
    new Vec(0.0, 0.0, 0.0),
    new Vec(0.0, 2.0, 0.0)
  );
  
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
  
  for (int i = 0; i <BALL_NUM ; i ++) {
    float x = 2*PI/BALL_NUM*i;
    float r = 1.5;
    Vec sphereCenter = new Vec(cos(x)*r, 0.0, sin(x)*r);
    float sphereR = 0.4;
    Material sphereMaterial = new Material(new Spectrum( sin(x+R), sin(x+G), sin( x+B)));
    sphereMaterial.reflective = 0.5;
    Sphere sphere = new Sphere(sphereCenter, sphereR, sphereMaterial);
    scene.add(sphere);
  }
  
  {
    Vec sphereCenter = new Vec(5.0, 10.0, 0.0);
    float sphereR = 5.0;
    Material sphereMaterial = new Material(new Spectrum(0.0, 0.0, 0.0));
    sphereMaterial.emissive = new Spectrum(8.0, 8.0, 8.0);
    Sphere sphere = new Sphere(sphereCenter, sphereR, sphereMaterial) ;
    scene.add(sphere);
  }
  
  Material material = new Material( new Spectrum(0.2, 0.2, 0.2) );
  Plane plane = new Plane( 
    new Vec(0.0, -0.4, 0.0),
    new Vec(0.0, 1.0, 0.0),
    material
  );
  plane.material.reflective = 0.8;
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