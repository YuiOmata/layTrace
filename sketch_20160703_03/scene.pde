int MAX_DEPTH = 10;

class Scene {
  ArrayList<Intersectable> objList = new ArrayList<Intersectable>();
  
  void add(Intersectable obj) {
    objList.add(obj);
  }
  
  Spectrum trace(Ray ray, int depth) {
    if (MAX_DEPTH == depth) { return BLACK; }
    
    Intersection isect = intersect(ray);
    if (isect.t != NO_HIT) {
      Spectrum spe = new Spectrum(0.0, 0.0, 0.0);
      float ref = isect.material.reflective;
      spe = spe.add(isect.material.col.scale(1.0 - ref));
      if (0.0 < ref) {
        spe = spe.add(traceReflect(ray, isect, depth).scale(ref));
      }
      return spe;
    } else {
      return BLACK;
    }
  }
  
  Spectrum traceReflect(Ray ray, Intersection isect, int depth) {
    Vec dir = ray.dir.reflect(isect.n);
    Ray ray2 = new Ray(isect.p, dir);
    ray2.forwardEpsilon();
    return trace(ray2, depth + 1).mul(isect.material.col);
  }
  
  Intersection intersect(Ray ray) {
    Intersection isect = new Intersection();
    for (int i = 0; i < objList.size(); i ++) {
      Intersectable obj = (Intersectable) objList.get(i);
      Intersection objIsect = obj.intersect(ray);
      if (objIsect.t < isect.t) {
        isect = objIsect;
      }
    }
    return isect;
  }
}