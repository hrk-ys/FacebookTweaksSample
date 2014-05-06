FacebookTweaksSample
====================

# Tweaksとは

iOSアプリ開発において、UXなどインタラクティブな操作において、
微妙なパラメータ調整を行いたい場合、簡単に設定画面を作って、再度ビルドすることなく、
値を変更して動作確認するためのライブラリです。（たぶん）

FacebookのPaperでも使われているそうです。


# Github

https://github.com/facebook/Tweaks


# インストール

    pod 'Tweaks'


# 使い方

## 値の取得

引数は、カテゴリ、コレクション、名前、値（複数）

    CGFloat animationDuration = FBTweakValue(@"Category", @"Group", @"Duration", 0.5);

※リリースビルドではデフォルト値を展開するだけなので、パフォーマンス的に問題にはならない


### 最小、最大数

数字に対しては、値を複数していして、デフォルト値、最小値、最大値を指定することができる

    self.red = FBTweakValue(@"Header", @"Colors", @"Red", 0.5, 0.0, 1.0);


## バインド

微調整のパラメータが変更されたら自動で更新されます。
第一引数に対象のオブジェクト、第2引数にプロパティーを指定します。


    FBTweakBind(self.headerView, alpha, @"Main Screen", @"Header", @"Alpha", 0.85);

## アクション

微調整リストを選択したときの処理をBlockを使って定義する事ができる。
ただし、block内はグローバルスコープになる

    FBTweakAction(@"Player", @"Audio", @"Volume", ^{
      NSLog(@"Action selected.");
    });


## 設定画面

設定画面を表示する方法2種類

### シェイクジェスチャーで表示

AppDelegate.mに以下を追加

    - (UIWindow *)window
    {
        if (!_window) {
            _window = [[FBTweakShakeWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        }

        return _window;
    }

シミュレータでシェイクジェスチャをする場合は⌘Z

### FBTweakViewControllerをモーダルで呼ぶ

モーダルで呼び出す。FBTweakViewController自体がNavigation Controllerなので、pushするとクラッシュする

    FBTweakViewController* vc = [[FBTweakViewController alloc] initWithStore:[FBTweakStore sharedInstance]];
    [self presentViewController:vc animated:YES completion:nil];

## その他

マクロを使わずに直接オブジェクトを生成する事も可能

    FBTweak *tweak = [[FBTweak alloc] initWithIdentifier:@"com.tweaks.example.advanced"];
    tweak.name = @"Advanced Settings";
    tweak.defaultValue = @NO;

    FBTweakStore *store = [FBTweakStore sharedInstance];
    FBTweakCategory *category = [store tweakCategoryWithName:@"Settings"];
    FBTweakCollection *collection = [category tweakCollectionWithName:@"Enable"];
    [collection addTweak:tweak];

    [tweak addObserver:self];

変更通知

    - (void)tweakDidChange:(FBTweak *)tweak
    {
      self.advancedSettingsEnabled = ![tweak.currentValue boolValue];
    }

# 使ってみた感想

ちょっとパラメータで調整したいなーと思う事はこったUIを作る場合や、複数人（デザイナーさんがいる）場合に
遭遇する事があります。
そのときにわざわざ設定画面を作る事無くマクロ一つで作成できるのはものすごーく魅力的に思います。

いざリリースするときにコードにゴミが残るのが少し気になりそうですが、実際に使ってみてある程度パラメータが固まったら
削除するすれば良いし、このライブラリが無ければ、都度ビルドするとなるとそっちの方が行けてないなーと思いました。
