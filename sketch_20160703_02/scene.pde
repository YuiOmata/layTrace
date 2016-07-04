class Scene {
  ArrayList<Intersectable> objList = new ArrayList<Intersectable>();
  
  void add(Intersectable obj) {
    objList.add(obj);
  }
  
  Spectrum trace(Ray ray) {
    Intersection isect = intersect(ray);
    if (isect.t != NO_HIT) {
      return isect.material.col;
    } else {
      return BLACK;
    }
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