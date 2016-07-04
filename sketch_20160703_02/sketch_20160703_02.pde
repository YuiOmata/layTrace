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
    Sphere sphere = new Sphere(sphereCenter, sphereR, sphereMaterial);
    scene.add(sphere);
  }
  
  return scene;
}

color calcPixelColor(int x, int y) {
  Ray ray = camera.ray(x, y);
  return scene.trace(ray).toColor();
}