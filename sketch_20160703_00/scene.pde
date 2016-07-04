int MAX_DEPTH = 10;
Spectrum SKY_COLOR = new Spectrum(0.2, 0.2, 0.2);

class Scene {
  ArrayList<Intersectable> objList = new ArrayList<Intersectable>();
  
  
  void add(Intersectable obj){
    objList.add(obj);
  }
  
  
  Spectrum trace(Ray ray, int depth) {
    if(MAX_DEPTH <= depth) return BLACK; 
    
    Intersection isect = intersect(ray);
    if (isect.t != NO_HIT) {
      float dice = random(1.0);
      println(dice);
      Spectrum spc = new Spectrum(0.0, 0.0, 0.0);    
      
      if(dice < isect.material.reflective){
        return traceReflect(ray, isect, depth);
      }else {
        spc = spc.add(traceDiffuse(ray, isect, depth));
      }
      spc = spc.add(isect.material.emissive);
      return spc;
    } else {
      return SKY_COLOR;
    }
  }
  
  Spectrum traceDiffuse(Ray ray, Intersection isect, int depth){
    Vec dir = isect.n.randomDirOverHemisphere();
    Ray ray2 = new Ray(isect.p, dir);
    ray2.forwordEpsilon();
    
    Spectrum li = trace(ray2, depth+1);
    Spectrum fr = isect.material.col.scale(1.0/PI);
    float sc = 2.0 * PI * isect.n.dot(dir); //keisuu 
    return li.mul(fr).scale(sc); 
  }
  
  Spectrum traceReflect(Ray ray, Intersection isect, int depth){
    Vec dir = ray.dir.reflect(isect.n);
    Ray ray2 = new Ray(isect.p, dir);
    ray2.forwordEpsilon();
    return trace(ray2, depth+1).mul(isect.material.col);
  }
  
  public Intersection intersect(Ray ray) {
    Intersection isect = new Intersection();
    
    for (int i = 0; i < objList.size(); i ++) {
      Intersectable obj = (Intersectable) objList.get(i);
      Intersection objIsect = obj.intersect(ray);
      if (objIsect.t < isect.t){
        isect = objIsect;
      }
    }
    return isect;
  }
}