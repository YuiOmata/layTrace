float EPSILON = 0.001;

// レイ
class Ray {
  Vec origin;  // 始点
  Vec dir;     // 方向（要、単位ベクトル）

  Ray(Vec origin, Vec dir) {
    this.origin = origin;
    this.dir = dir;
  }
  
  void forwardEpsilon() {
    origin = origin.add(dir.scale(EPSILON));
  }
}