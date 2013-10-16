var factory = require('selenium-factory'),
	fs = require('fs');

var client  = factory.createRemoteWebDriver(),
	browser = client.browser,
	sync    = client.sync;

var WAIT_TIMEOUT = 10 * 1000;

describe('表示', function() {

	var desiredCapabilities = factory.defaultCapabilities();
	var isPC = !/android|iphone/i.test(desiredCapabilities.browserName);

	function saveScreenshot(filename) {
		fs.writeFileSync('./screenshots/' + filename, browser.takeScreenshot(), 'base64');
	}

	before(function(done) {
		sync(function() {
			// ブラウザを初期化
			browser.init(desiredCapabilities);

			if (isPC) {
				browser.setWindowSize(1024, 7680);
			}
			done();
		});
	});

	after(function(done) {
		sync(function() {
			// ブラウザを修了
			browser.quit();
			done();
		});
	});

	it('ホーム', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/");

			// 新着情報が表示されるまで待つ
			if (isPC) {
				browser.waitForVisibleByCssSelector('#feeds1 ul li', WAIT_TIMEOUT);
			}

			saveScreenshot('home.png');
			done();
		});
	});

	it('会社案内', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/about");
			saveScreenshot('about.png');
			done();
		});
	});

	it('サービス', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/service");
			saveScreenshot('service.png');
			done();
		});
	});

	it('新着情報', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/news/index");
			saveScreenshot('news_index.png');
			done();
		});
	});

	it('お問い合わせ', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/contact/index");

			saveScreenshot('contact_index.png');
			done();
		});
	});

	it('アイコンの使い方', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/icons");
			saveScreenshot('icons.png');
			done();
		});
	});

	it('サイトマップ', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/sitemap");
			saveScreenshot('sitemap.png');
			done();
		});
	});

	it('Webからの問い合わせ(エラー)', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/contact");

//TODO: フォームへ文字入力してエラーが表示されるところまでテスト
//MEMO: typeは日本語が送れない
//MEMO: executeでスクリプト書いても、日本語が送れない
//MEMO: 仕方ないので、URIエンコードして無理やり送る
			//browser.type(form1, 'てらかど');

			// 英数字の入力
			var elemMail1 = browser.elementByCssSelector('#MessageEmail1');
			var elemMail2 = browser.elementByCssSelector('#MessageEmail2');
			browser.type(elemMail1, 'michael@cat.email.jp');
			browser.type(elemMail2, 'micheel@cat.email.jp');

			// 日本語の入力その１
//MEMO: Androidでは改行コード付きのexecuteが送れないのでわざわざ削除する必要あり
			browser.execute('(' + (function(kana1){
				document.getElementById('MessageNameKana1').setAttribute('value', decodeURIComponent(kana1));
			}).toString().replace(/\n/g, "") + ')("' + encodeURIComponent('てらかど') + '");');

			// 日本語の入力その２
			function setInputValue(cssSelector, value) {
				browser.execute('(' + (function(cssSelector, value){
					document.querySelector(cssSelector).setAttribute('value', decodeURIComponent(value));
				}).toString().replace(/\n/g, "") + ')("' + cssSelector + '", "' + encodeURIComponent(value) + '");');
			}

			setInputValue('#MessageNameKana2', 'じもん');

			// フォームの送信
			var form = browser.elementByCssSelector('form[action*="/contact/confirm"]');
			browser.submit(form);

			saveScreenshot('contact.png');
			done();
		});
	});

	it('ホームカンバン', function(done) {
		sync(function() {
			browser.get("http://demo.basercms.net/");

			// 新着情報が表示されるまで待つ
			if (isPC) {
				browser.waitForVisibleByCssSelector('#feeds1 ul li', WAIT_TIMEOUT);
			}

			// 看板が切り替わるまで待つ
			var pagers = browser.elementsByCssSelector('.pager-link');
			var counter = 1;
			var baseLeft = (isPC ? -750 : -/*1912*/876);
			pagers.forEach(function(pager) {

				var actualLeft = (baseLeft * counter) + 'px';

				// 看板が切り替わるまで待つ
				if (isPC) {
					browser.waitForCondition('(' + (function(actualLeft){
						return (document.querySelector('#slider').style.left === actualLeft ? true : false);
					}).toString().replace(/\n/g, "") + ')("' + actualLeft + '");', 20 * 1000);
				}

//FIXME: androidDriverではwaitForCondition(=safeEval)がスクリプトエラーになるので使えない
//https://github.com/admc/wd/issues/129

				// スクーンショットに保存
				saveScreenshot('home-kanban' + counter + '.png');

				counter++;
			});

			done();
		});
	});
});
