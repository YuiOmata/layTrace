  // 光を表現するクラス
class Spectrum {
  float r, g, b;

  // コンストラクタ
  Spectrum(float r, float g, float b) {
    this.r = r; this.g = g; this.b = b;
  }
  
  // 加算
  Spectrum add(Spectrum v) {
    return new Spectrum(r + v.r, g + v.g, b + v.b);
  }
  
  // 乗算
  Spectrum mul(Spectrum v) {
    return new Spectrum(r * v.r, g * v.g, b * v.b);
  }
  
  // 定数倍
  Spectrum scale(float s) {
    return new Spectrum(r * s, g * s, b * s);
  }
  
  // 表示色に変換
  color toColor() {
    int ir = (int)min(r * 255, 255);
    int ig = (int)min(g * 255, 255);
    int ib = (int)min(b * 255, 255);
    return color(ir, ig, ib);
  }
}

// 黒
Spectrum BLACK = new Spectrum(0, 0, 0);