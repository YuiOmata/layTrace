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
  scene = new Scene();
  
  Vec sphereCenter = new Vec(0.0, 0.0, 0.0);
  float sphereR = 1.0;
  Sphere sphere = new Sphere(sphereCenter, sphereR);
  scene.add(sphere);
  
  return scene;
}

color calcPixelColor(int x, int y) {
  Ray ray = camera.ray(x, y);

  if (scene.isIntersect(ray)) {
    return color(255);
  } else {
    return color(0);
  }
}