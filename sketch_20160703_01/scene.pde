class Scene {
  ArrayList<Intersectable> objList = new ArrayList<Intersectable>();
  
  void add(Intersectable obj) {
    objList.add(obj);
  }
  
  boolean isIntersect(Ray ray) {
    for (int i = 0; i < objList.size(); i ++) {
      Intersectable obj = (Intersectable) objList.get(i);
      if (obj.isIntersect(ray)) {
        return true;
      }
    }
    return false;
  }
}