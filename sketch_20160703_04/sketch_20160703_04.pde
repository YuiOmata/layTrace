int SAMPLES = 100;

Scene scene;
Camera camera;

void setup() {
  size(256, 256);
  
  scene = initScene();
  
  camera = new Camera();
  
  for (int iy = 0; iy < height; iy ++) {
    for (int ix = 0; ix < width; ix ++) {
      stroke(calcPixelColor(ix, iy));
      point(ix, iy);
    }
  }
}

Scene initScene() {
  Scene scene = new Scene();
  
  for (int i = 0; i < 5; i ++) {
    Vec sphereCenter = new Vec(i - 2, 0.0, i - 2);
    float sphereR = 0.7;
    Material sphereMaterial = new Material(new Spectrum(1.0, i * 0.25, 0.0));
    sphereMaterial.reflective = 0.5;
    Sphere sphere = new Sphere(sphereCenter, sphereR, sphereMaterial);
    scene.add(sphere);
  }
  
  Material planeMaterial = new Material(new Spectrum(0.8, 0.8, 0.8));
  planeMaterial.reflective = 0.0;
  Plane plane = new Plane(
    new Vec(0.0, -0.7, 0.0),
    new Vec(0.0, 1.0, 0.0), 
    planeMaterial
  );
  scene.add(plane);
  
  return scene;
}

color calcPixelColor(int x, int y) {
  Ray ray = camera.ray(x, y);
  
  Spectrum sum = new Spectrum(0.0, 0.0, 0.0);
  
  for (int i = 0; i < SAMPLES; i ++) {
    sum = sum.add(scene.trace(ray, 0).scale(1.0 / SAMPLES));
  }
  
  return sum.toColor();
}