

//class CheckedObj implements Intersectable {
//  Intersectable obj;
//  float invgridsize;   // グリッド幅の逆数
//  Material material2;  // もう一つのマテリアル

//  CheckedObj(Intersectable obj, float gridsize, Material material2) {
//    this.obj = obj;
//    this.invgridsize = 1.0 / gridsize;
//    this.material2 = material2;
//  }

//  boolean intersect(Intersection isect, Ray ray) {
//    if (obj.intersect(isect, ray)) {
//      int i = floor(isect.p.x*invgridsize) + floor(isect.p.y*invgridsize)
//            + floor(isect.p.z*invgridsize);
//      if (i % 2 != 0)  isect.material = material2;
//      return true;
//    } else {
//      return false;
//    }
//  }
//}