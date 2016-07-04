// マテリアル
class Material {
  Spectrum col;  // 物体の色
  Spectrum emissive = new Spectrum(0.0, 0.0, 0.0); //hakkou
  float reflective; //hannsyaritu 0~1

  Material(Spectrum col) {
    this.col = col;
  }
}