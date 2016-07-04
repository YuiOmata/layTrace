// カメラ
class Camera {
  Vec eye, target, up;
  Vec origin, xaxis, yaxis;
  float fov = 40.0;
  
  Camera(Vec eye, Vec target, Vec up) {
    lookat(eye, target, up);
    update();
  }
  
  Camera() {
    this(
      new Vec(0.0, 0.0, 5.0),
      new Vec(0.0, 0.0, 0.0),
      new Vec(0.0, 1.0, 0.0)
    );
  }
  
  void lookat(Vec eye, Vec target, Vec up) {
    this.eye = eye;
    this.target = target;
    this.up = up;
    update();
  }
  
  void setFov(float fov) {
    this.fov = fov;
    update();
  }

  // 視点からある位置を向くように設定を行う
  void update() {
    float imageplane = (height / 2.0) / tan(fov / 180.0 * PI / 2.0);
    Vec v = target.sub(eye).normalize();
    xaxis = v.cross(up).normalize();
    yaxis = v.cross(xaxis);
    Vec center = v.scale(imageplane);
    origin = center.sub(xaxis.scale(0.5 * width))
                   .sub(yaxis.scale(0.5 * height));
  }

  // スクリーン座標に対するレイ
  Ray ray(float x, float y) {
    Vec dir = origin.add(xaxis.scale(x)).add(yaxis.scale(y)).normalize();
    return new Ray(eye, dir);
  }
}