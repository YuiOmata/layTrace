
interface Intersectable {
  Intersection intersect(Ray ray);
}


class Sphere implements Intersectable {
  Vec center;         // 中心座標
  float radius;       // 半径
  Material material;

  Sphere(Vec center, float radius, Material material) {
    this.center = center;
    this.radius = radius;
    this.material = material;
  }

  public Intersection intersect(Ray ray) {
    Intersection isect = new Intersection();
    
    Vec v = ray.origin.sub(center);
    float b = ray.dir.dot(v);
    float c = v.dot(v) - sq(radius);
    float d = b * b - c;
    if (d >= 0) {
      float s = sqrt(d);
      float t = -b - s;
      if (t <= 0)  {
        t = -b + s;
      } else { //t > 0
        isect.t = t;
        isect.p = ray.origin.add(ray.dir.scale(t));
        isect.n = isect.p.sub(center).normalize();
        isect.material = material;
      }
    }
  return isect;
  }
}

// 無限平面
class Plane implements Intersectable {
  Vec n;              // 面法線 (a, b, c)
  float d;            // 原点からの距離 (平面の方程式 ax + by + cz + d = 0)
  Material material;  // マテリアル

  // 面法線n、点pを通る平面
  Plane(Vec p, Vec n, Material material) {
    this.n = n.normalize();
    this.d = -p.dot(this.n);
    this.material = material;
  }

  public Intersection intersect(Ray ray) {
    Intersection isect = new Intersection();
    
    float v = n.dot(ray.dir);
    float t = -(n.dot(ray.origin) + d) / v;
    if (0 < t && t < isect.t) {
      isect.t = t;
      isect.p = ray.origin.add(ray.dir.scale(t));
      isect.n = n;
      isect.material = material;
    }
    return isect;
  }
}