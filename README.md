 BaseCMSのデモサイトをスモークテストしてみる
=============================================


 # 構成 #
--------------

mocha + wd-sync + chromedriver + androiddriver


GalaxyNexus
	OS: Android 4.2.2(Jelly Bean)
	IP: 10.0.2.19

追加
	jenkins
	saucelabs

主にテスト対象となるのは、
	・簡単なスクリプトのテスト
		facebookの埋め込み
		画面の動的変更
	・レイアウトの崩れ
くらいです。

http://demo.basercms.net/#

 # 計画 #
----------

### Header ###
	検索フォーム		/contents/search

### Alpha ###
	ホーム				http://demo.basercms.net/
	会社案内			http://demo.basercms.net/about
		※非同期にGoogleMapsが表示されるので、それが表示し終わったから次に進むこと
	サービス			http://demo.basercms.net/service
	新着情報			http://demo.basercms.net/news/index
	お問い合わせ		http://demo.basercms.net/contact/index
		※お問い合わせフォームには「リセット」と「サブミット」それぞれのボタンもある
	アイコンの使い方	http://demo.basercms.net/icons
	サイトマップ		http://demo.basercms.net/sitemap

	リンク				http://basercms.net/

	Webからの問い合わせ	http://demo.basercms.net/contact

	facebookウィジェット
		※全てが表示されるまで非同期に待つ必要あり

### Beta ###
	カンバン５つ
		※ボタンを押した後、３．５秒くらいは切り替わり完了までにかかっている。面倒だなぁ…。
		$('#slider')[0].style.leftが'-750px'以外ならまだ切り替わりアニメーション中だと判断できる。
	NEWS RELEASE内のリンク
		http://demo.basercms.net/news/archives/{0-9}+
	baserCMS NEWSのリンク
		http://demo.basercms.net/news/archives/{0-9}+
	Webからの問い合わせ
	検索フォーム

### 概要 ###

+ メイン７画面
+ 表示チェック項目がそれぞれに存在する
+ 試験項目書を作成して、それぞれに「必ず毎回どうしても絶対にチェックしなければならないリスクを抱えている場所」を絞り込む
+ スマフォ版で閲覧した時は、検索フォームが表示されない（存在しない？）


 # 次の課題 #
--------------

+ より動的なサイトのスモークテスト
+ ログイン認証が必要なサイトのスモークテスト
+ サーバ通信の偽装が必要なスモークテスト
