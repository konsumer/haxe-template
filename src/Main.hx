@:expose
class Main extends hxd.App {
    static var WIN_WIDTH = 800;
    static var WIN_HEIGHT = 600;
    
    var tf: h2d.Text;
    var targetX = 400.0;
    var targetY = 300.0;
    static var app: Main;

    override function init() {
        app = this;
        s2d.scaleMode = h2d.ScaleMode.LetterBox(WIN_WIDTH, WIN_HEIGHT);

        var bg = new h2d.Graphics(s2d);
        bg.beginFill(0x660000);
        bg.drawRect(0, 0, WIN_WIDTH, WIN_HEIGHT);
        bg.endFill();

        var font : h2d.Font = hxd.res.DefaultFont.get().clone();

        tf = new h2d.Text(font, bg);
        tf.scaleX = tf.scaleY = 3;
        tf.text = "Hello World!";
    }

    override function update(dt: Float) {
        var dx = targetX - tf.x;
        var dy = targetY - tf.y;
        tf.x += dx * dt * 3;
        tf.y += dy * dt * 3;

        if (Math.abs(dx) < 1 && Math.abs(dy) < 1) {
            targetX = Math.random() * WIN_WIDTH;
            targetY = Math.random() * WIN_HEIGHT;
        }
    }

    static function main() {
        new Main();
    }
}