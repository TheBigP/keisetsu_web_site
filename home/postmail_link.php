<?php header('Content-type: text/html; charset=utf-8'); ?>
<!DOCTYPE html>
<html lang="ja">

<head>
    <?php include 'ref.php'; ?>

    <script type="text/JavaScript">

        function MM_findObj(n, d) { //v4.01
            var p, i, x;
            if (!d) d = document;
            if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
                d = parent.frames[n.substring(p + 1)].document;
                n = n.substring(0, p);
            }
            if (!(x = d[n]) && d.all) x = d.all[n];
            for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
            for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
            if (!x && d.getElementById) x = d.getElementById(n);
            return x;
        }

        function MM_validateForm() { //v4.0
            var i, p, q, nm, test, num, min, max, errors = '', args = MM_validateForm.arguments;
            for (i = 0; i < (args.length - 2); i += 3) {
                test = args[i + 2];
                val = MM_findObj(args[i]);
                if (val) {
                    nm = val.name;
                    if ((val = val.value) != "") {
                        if (test.indexOf('isEmail') != -1) {
                            p = val.indexOf('@');
                            if (p < 1 || p == (val.length - 1)) errors += '- ' + nm + ' must contain an e-mail address.\n';
                        } else if (test != 'R') {
                            num = parseFloat(val);
                            if (isNaN(val)) errors += '- ' + nm + ' must contain a number.\n';
                            if (test.indexOf('inRange') != -1) {
                                p = test.indexOf(':');
                                min = test.substring(8, p);
                                max = test.substring(p + 1);
                                if (num < min || max < num) errors += '- ' + nm + ' must contain a number between ' + min + ' and ' + max + '.\n';
                            }
                        }
                    } else if (test.charAt(0) == 'R') errors += '- ' + nm + ' is required.\n';
                }
            }
            if (errors) alert('The following error(s) occurred:\n' + errors);
            document.MM_returnValue = (errors == '');
        }

    </script>
</head>

<body style="padding-top:60px;font-size:15px">
    <?php include 'header.php'; ?>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div id="left">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size: 14px">
                        <thead>
                            <tr>
                                <td class="under10"><img src="./image/bn_rec_entry.jpg" id="header_pic" alt="コンピュータ・ソフトウエア開発部門" width="100%">
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    同意いただきありがとうございます。こちらは採用希望のエントリーフォームです。下記のフォームに、必要事項をご入力後、送信ください。後日、こちらからご連絡いたします。ご応募いただいた個人情報は採用に関する事柄のみに使用し、その他には利用いたしません。<br>
                                    <font color="#FF3300">紫の項目（<img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial">マーク）は必須です。</font>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <form action="email.php" method="post">
                            <table width="100%" border="0" cellpadding="5" cellspacing="0" class="table table-bordered" style="font-size: 14px">
                                <tbody>
                                    <tr>
                                        <td bgcolor="#FFFFFF" width="30%"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>採用区分</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input name="_応募区分" type="radio" value="新卒">
                                            新卒　　
                                            <input name="_応募区分" type="radio" value="キャリア">
                                            キャリア
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" width="30%"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>希望職種</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <select class="form-control" name="_希望職種" id="希望職種">
                                                <option selected="">希望の職種をお選びください。</option>
                                                <option>-----新卒採用-----</option>
                                                <option value="新卒-ソフトウェア開発">新卒-ソフトウェア開発</option>
                                                <option value="新卒-機械設計">新卒-機械設計</option>
                                                <option value="新卒-電気･電子回路設計">新卒-電気･電子回路設計</option>
                                                <option value="新卒-プラスティック容器設計">新卒-プラスティック容器設計</option>
                                                <option value="新卒-DTP技術者">新卒-DTP技術者</option>
                                                <option>-----キャリア採用-----</option>
                                                <option value="キャリア-ソフトウェア開発エンジニア">キャリア-ソフトウェア開発エンジニア</option>
                                                <option value="キャリア-アプリケーションソフト開発エンジニア">キャリア-アプリケーションソフト開発エンジニア</option>
                                                <option value="キャリア-機械設計エンジニア">キャリア-機械設計エンジニア</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" width="35%"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>氏　　名</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            姓<input class="form-control" name="_氏名/姓" type="text" id="氏名/姓" size="15" style="display: inline-block;width: 90%;margin-left: 5px">
                                            名<input class="form-control" name="_氏名/名" type="text" id="氏名/名" size="15" style="display: inline-block;width: 90%;margin-left: 5px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>フリガナ</span><br><font color="#FF3300">（全角カタカナ）</font>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            姓<input class="form-control" name="_フリガナ/姓" type="text" id="フリガナ/姓" style="display: inline-block;width: 90%;margin-left: 5px">
                                            名<input class="form-control" name="_フリガナ/名" type="text" id="フリガナ/名" style="display: inline-block;width: 90%;margin-left: 5px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial">
                                            <span>生年月日</span></td>
                                        <td bgcolor="#F8F4F9" class="note"> 西暦
                                            <input class="form-control" name="_生年月日/年" style="display: inline;width: 25%" type="text" id="生年月日/年" size="8" placeholder="年">

                                            <input class="form-control" name="_生年月日/月" style="display: inline;width: 25%" type="text" id="生年月日/月" size="4" placeholder="月">

                                            <input class="form-control" name="_生年月日/日" style="display: inline;width: 25%" type="text" id="生年月日/日" size="4" placeholder="日">
                                            <font color="#FF3300">（半角数字）</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>性　　別</span></td>
                                        <td bgcolor="#F8F4F9">
                                            <input name="_性別" type="radio" value="男性">
                                            男性　　
                                            <input name="_性別" type="radio" value="女性">
                                            女性
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="5" bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>所在地</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            〒
                                            <input class="form-control" name="_郵便番号上3桁" type="text" id="郵便番号上3桁" onblur="MM_validateForm('郵便番号上3桁','','NisNum');return document.MM_returnValue" size="3" maxlength="3" placeholder="例：xxx-xxxx（半角数字）">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <select name="_住所/都道府県" class="form-control" id="住所/都道府県">
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
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder=" ・市区町村" name="_住所/市区町村" type="text" id="住所/市区町村" size="15">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder=" ・番地ほか" name="_住所/番地ほか" type="text" id="住所/番地ほか" size="15">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder=" ・アパートマンション名" name="住所/アパートマンション名" type="text" id="住所/アパートマンション名" size="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>電話番号【自宅】</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="例：03-3333-3333 （半角数字）" name="_電話番号【自宅】" type="text" id="電話番号【自宅】">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>電話番号【携帯】</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="例：090-3333-3333 （半角数字）" name="_電話番号【携帯】" type="text" id="電話番号【携帯】">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>メールアドレス</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="（半角数字）" name="_email" type="text" id="email">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="5" bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>最終学歴</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">在学中の方は、在学している学校名と卒業見込み年度をご入力下さい。</td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="・学校名" name="_最終学歴/学校名" type="text" id="最終学歴/学校名">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="・学部名" name="_最終学歴/学部名" type="text" id="最終学歴/学部名">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="・学科名" name="_最終学歴/学科名" type="text" id="最終学歴/学科名">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9" style="vertical-align: unset">・卒業年度　西暦
                                            <input class="form-control" width="10%" placeholder="（半角数字）" style="display: inline;width: 30%;" name="_卒業年度" type="text" id="卒業年度" size="8">
                                            年度
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table width="100%" style="margin-bottom: 5%;margin-top: 5%" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td align="center"> ここまでは、必須項目です。記入漏れはございませんか？<br>
                                            以下の項目は任意ですので、ご自由にご記入ください。
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table width="100%" border="0" cellpadding="5" cellspacing="0" class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td class="hyo" width="35%"><img src="./image/p_3green.gif" alt="" width="15" height="17" style="vertical-align: initial">資格・技能・職歴等</td>
                                        <td bgcolor="#E0EBED">
                                            <textarea class="form-control" name="資格・技能・職歴など" cols="40" rows="5" id="資格・技能・職歴など"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="note"><img src="./image/p_3green.gif" alt="" width="15" height="17" style="vertical-align: initial">その他</td>
                                        <td bgcolor="#E0EBED">
                                            <textarea class="form-control" name="その他" cols="40" rows="5" id="textarea2">自己PR・ご質問・希望条件等ありましたらご記入ください。</textarea>
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
                                            <input type="submit" name="Submit" style="width: 23%;margin-right: 10px" value="確認画面へ">

                                            <input type="reset" name="Submit2" style="width: 23%;margin-left: 10px" value="リセット" onclick="javascript: top.location.href = 'postmail_link.php'">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <table width="100%" border="0" cellpadding="10" cellspacing="0" class="f11">
                        <tbody>
                            <tr>
                                <td width="90"><img src="./image/rapidssl_ssl_certificate.gif" alt="" width="90" height="50">
                                </td>
                                <td width="380"> 当サイトでは、皆さまの個人情報を保護するために、個人情報入力ページにおいてSSL暗号化通信を採用しています。</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <?php include 'footer.php'; ?>
    </div>
</body>

</html>