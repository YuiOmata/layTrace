// マテリアル
class Material {
  Spectrum col;  // 物体の色
  float reflective; // 反射率

  Material(Spectrum col) {
    this.col = col;
  }
}