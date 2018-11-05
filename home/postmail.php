<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ja">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta name="robots" content="NOINDEX,NOFOLLOW,NOARCHIVE">
    <meta name="googlebot" content="NOINDEX,NOFOLLOW,NOARCHIVE">
    <meta name="Description" content="京設工業株式会社はソフトウェア開発/検証・機械設計・電気設計・エンジニア派遣・DTPデザインの５つの部門からお客様の多様なニーズに応え続けています。">
    <meta name="keyword" content="京設工業,ソフトウェア,開発,検証,電気,電子,機械,設計,システム,エンジニア,技術者,採用,人材派遣,転職,求人,プラスチック容器,デザイン,DTP">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ソフトウェア開発/検証・機械設計・電気設計・エンジニア派遣・DTPデザインの京設工業株式会社－お問い合わせ－/システムエンジニア/技術者/人材派遣/転職/プラスチック容器</title>

    <link rel="index" href="http://www.keisetsu.co.jp/">
    <link href="./layout.css" rel="stylesheet" type="text/css">
    <link href="./keisetsu.css" rel="stylesheet" type="text/css">
    <link href="./menu.css" rel="stylesheet" type="text/css">
    <link href="./tatemenu.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="./material-design/css/material-design-iconic-font.css" />
    <link rel="stylesheet" href="./css/jside-menu.css" />
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>

    <script type="text/JavaScript">
        <!--
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
  } if (errors) alert('The following error(s) occurred:\n'+errors);
  document.MM_returnValue = (errors == '');
}
//-->
</script>
</head>

<body style="padding-top:  60px;">
    <?php include 'header.php';?>
    <div class="container">
        <div class="row" style="font-size: 1.2rem;">
            <div class="col-sm-12">
                <div id="left">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <td class="under10"><img src="./image/bn_contact.jpg" alt="コンピュータ・ソフトウエア開発部門" width="100%"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="top10">京設工業株式会社へのご質問お問い合わせは、下記のフォームより必要事項をご入力後、送信ください。後日、こちらからご連絡いたします。<font color="#FF3300">記入項目はすべて必須です。</font><br>
                                    お問い合わせの際、収集させていただく個人情報の取り扱いについては<a href="http://www.keisetsu.co.jp/html/privacy.php" target="_blank"><u>こちら</u></a>をご確認下さい。</td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <form action="postmail.cgi" method="post">
                            <table width="100%" border="0" cellpadding="5" cellspacing="0">
                                <colgroup>
                                    <col width="140">
                                    <col width="370">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="note"><img src="./image/p_3.gif" alt="" width="15" height="17">お問合せ内容</td>
                                        <td bgcolor="#F8F4F9" class="note">
                                            <select name="_お問合せ内容" id="お問合せ内容">
                                                <option>---お選びください---</option>
                                                <option value="企業情報について">企業情報について</option>
                                                <option value="採用情報について">採用情報について</option>
                                                <option value="その他">その他</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="hyo"><img src="./image/p_3.gif" alt="" width="15" height="17">氏　　名</td>
                                        <td bgcolor="#F8F4F9" class="hyo">姓
                                            <input name="_氏名/姓" type="text" id="氏名/姓" size="20">
                                            名
                                            <input name="_氏名/名" type="text" id="氏名/名" size="20">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="note"><img src="./image/p_3.gif" alt="" width="15" height="17">フリガナ</td>
                                        <td bgcolor="#F8F4F9" class="note">姓
                                            <input name="_フリガナ/姓" type="text" id="フリガナ/姓" size="20">
                                            名
                                            <input name="_フリガナ/名" type="text" id="フリガナ/名" size="20">
                                            <font color="#FF3300">（全角カタカナ）</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="hyo"><img src="./image/p_3.gif" alt="" width="15" height="17">会社名・学校名</td>
                                        <td bgcolor="#F8F4F9" class="hyo">
                                            <input name="_会社名・学校名" type="text" id="会社名・学校名" size="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="5" bgcolor="#FFFFFF" class="note"><img src="./image/p_3.gif" alt="" width="15" height="17">所在地</td>
                                        <td bgcolor="#F8F4F9" class="note">〒
                                            <input name="_郵便番号上3桁" type="text" id="郵便番号上3桁" onblur="MM_validateForm('郵便番号上3桁','','NisNum');return document.MM_returnValue" size="3" maxlength="3">
                                            -
                                            <input name="_郵便番号下4桁" type="text" id="郵便番号下4桁" onblur="MM_validateForm('郵便番号下4桁','','NisNum');return document.MM_returnValue" size="4" maxlength="4">
                                            <font color="#FF3300">（半角数字）</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9" class="hyo">
                                            <select name="_所在地/都道府県" class="tSelect01" id="所在地/都道府県">
                                                <option value="" selected="">都道府県</option>
                                                <option value="北海道">北海道</option>
                                                <option value="青森県">青森県</option>
                                                <option value="岩手県">岩手県</option>
                                                <option value="宮城県">宮城県</option>
                                                <option value="秋田県">秋田県</option>
                                                <option value="山形県">山形県</option>
                                                <option value="福島県">福島県</option>
                                                <option value="茨城県">茨城県</option>
                                                <option value="栃木県">栃木県</option>
                                                <option value="群馬県">群馬県</option>
                                                <option value="埼玉県">埼玉県</option>
                                                <option value="千葉県">千葉県</option>
                                                <option value="東京都">東京都</option>
                                                <option value="神奈川県">神奈川県</option>
                                                <option value="新潟県">新潟県</option>
                                                <option value="富山県">富山県</option>
                                                <option value="石川県">石川県</option>
                                                <option value="福井県">福井県</option>
                                                <option value="山梨県">山梨県</option>
                                                <option value="長野県">長野県</option>
                                                <option value="岐阜県">岐阜県</option>
                                                <option value="静岡県">静岡県</option>
                                                <option value="愛知県">愛知県</option>
                                                <option value="三重県">三重県</option>
                                                <option value="滋賀県">滋賀県</option>
                                                <option value="京都府">京都府</option>
                                                <option value="大阪府">大阪府</option>
                                                <option value="兵庫県">兵庫県</option>
                                                <option value="奈良県">奈良県</option>
                                                <option value="和歌山県">和歌山県</option>
                                                <option value="鳥取県">鳥取県</option>
                                                <option value="島根県">島根県</option>
                                                <option value="岡山県">岡山県</option>
                                                <option value="広島県">広島県</option>
                                                <option value="山口県">山口県</option>
                                                <option value="徳島県">徳島県</option>
                                                <option value="香川県">香川県</option>
                                                <option value="愛媛県">愛媛県</option>
                                                <option value="高知県">高知県</option>
                                                <option value="福岡県">福岡県</option>
                                                <option value="佐賀県">佐賀県</option>
                                                <option value="長崎県">長崎県</option>
                                                <option value="熊本県">熊本県</option>
                                                <option value="大分県">大分県</option>
                                                <option value="宮崎県">宮崎県</option>
                                                <option value="鹿児島県">鹿児島県</option>
                                                <option value="沖縄県">沖縄県</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9" class="note"> ・市区町村
                                            <input name="_所在地/市区町村" type="text" id="所在地/市区町村" size="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9" class="hyo"> ・番地ほか
                                            <input name="_所在地/番地ほか" type="text" id="所在地/番地ほか" size="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9" class="note"> ・建物名
                                            <input name="所在地/アパートマンション名" type="text" id="所在地/アパートマンション名" size="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="hyo"><img src="./image/p_3.gif" alt="" width="15" height="17">電話番号</td>
                                        <td bgcolor="#F8F4F9" class="hyo">
                                            <input name="_電話番号" type="text" id="電話番号">
                                            <font color="#FF3300">例：03-3333-3333 （半角数字）</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="note"><img src="./image/p_3.gif" alt="" width="15" height="17">メールアドレス</td>
                                        <td bgcolor="#F8F4F9" class="note">
                                            <input name="_email" type="text" id="email">
                                            <font color="#FF3300">（半角数字）</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" class="hyo"><img src="./image/p_3.gif" alt="" width="15" height="17">お問合せ詳細</td>
                                        <td bgcolor="#F8F4F9" class="hyo">
                                            <textarea name="_お問合せ詳細" cols="40" rows="5" id="textarea3">出来るだけ詳しくご記入ください。</textarea>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <img src="./image/line_note.gif" alt="" width="100%" height="1"><br>
                            <br>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td align="center">
                                            <input type="submit" name="Submit" value="送信">
                                            　
                                            <input type="reset" name="Submit2" value="リセット">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <table width="100%" border="0" cellpadding="10" cellspacing="0" class="f11">
                        <tbody>
                            <tr>
                                <td width="90"><img src="./image/rapidssl_ssl_certificate.gif" alt="" width="90" height="50"></td>
                                <td width="380">当サイトでは、皆さまの個人情報を保護するために、個人情報入力ページにおいてSSL暗号化通信を採用しています。</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <?php include 'footer.php';?>
    </div>
</body>

</html>
