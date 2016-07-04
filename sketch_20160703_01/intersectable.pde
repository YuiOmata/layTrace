// 物体のインタフェース
interface Intersectable {
  boolean isIntersect(Ray ray);
}

// ---

// 球
class Sphere implements Intersectable {
  Vec center;         // 中心座標
  float radius;       // 半径

  Sphere(Vec center, float radius) {
    this.center = center;
    this.radius = radius;
  }

  boolean isIntersect(Ray ray) {
    Vec v = ray.origin.sub(center);
    float b = ray.dir.dot(v);
    float c = v.dot(v) - sq(radius);
    float d = b * b - c;
    if (d >= 0) {
      float s = sqrt(d);
      float t = -b - s;
      if (t <= 0)  t = -b + s;
      
      if (0 < t) {
        return true;
      }
    }
    return false;
  }
}