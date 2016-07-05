// レイ
float EPSILON = 0.001;

class Ray {
  Vec origin;  // 始点
  Vec dir;     // 方向（要、単位ベクトル）length  == 1 

  Ray(Vec origin, Vec dir) {
    this.origin = origin;
    this.dir = dir;
  }
  
  void forwordEpsilon(){
    origin = origin.add(dir.scale(EPSILON));
  }
}