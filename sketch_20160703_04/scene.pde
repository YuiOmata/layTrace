int MAX_DEPTH = 10;
Spectrum SKY = new Spectrum(0.9, 0.9, 0.9);

class Scene {
  ArrayList<Intersectable> objList = new ArrayList<Intersectable>();
  
  void add(Intersectable obj) {
    objList.add(obj);
  }
  
  Spectrum trace(Ray ray, int depth) {
    if (MAX_DEPTH == depth) { return BLACK; }
    
    Intersection isect = intersect(ray);
    if (isect.t != NO_HIT) {
      float dice = random(1.0);
      if (dice < isect.material.reflective) {
        return traceReflect(ray, isect, depth);
      } else {
        return traceDiffuse(ray, isect, depth);
      }
    } else {
      return SKY;
    }
  }
  
  Spectrum traceReflect(Ray ray, Intersection isect, int depth) {
    Vec dir = ray.dir.reflect(isect.n);
    Ray ray2 = new Ray(isect.p, dir);
    ray2.forwardEpsilon();
    return trace(ray2, depth + 1).mul(isect.material.col);
  }
  
  Spectrum traceDiffuse(Ray ray, Intersection isect, int depth) {
    Vec dir = isect.n.randomDirOverHemisphere();
    Ray ray2 = new Ray(isect.p, dir);
    ray2.forwardEpsilon();
    Spectrum li = trace(ray2, depth + 1);
    
    Spectrum fr = isect.material.col.scale(1.0 / PI);
    float sc = 2.0 * PI * isect.n.dot(dir);
    
    return li.mul(fr).scale(sc);
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