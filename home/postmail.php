<?php include 'useragent.php'; ?>
<!DOCTYPE html>
<html lang="ja">

<head>
    <?php include 'ref.php';?>

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
        $(document).ready(function () {
            $("#form_validate").submit(function (e) {
                const new_fname = $("#氏名姓").val();
                if(new_fname === "" || new_fname === null){
                    alert("氏名/姓は入力必須です");
                    return false;
                };
                const new_lname = $("#氏名名").val();
                if(new_lname === "" || new_lname === null){
                    alert("氏名/名は入力必須です");
                    return false;
                };
                const new_pfname = $("#フリガナ姓").val();
                if(new_pfname === "" || new_pfname === null){
                    alert("フリガナ/姓は入力必須です");
                    return false;
                };
                const new_plname = $("#フリガナ名").val();
                if(new_plname === "" || new_plname === null){
                    alert("フリガナ/名は入力必須です");
                    return false;
                };
                const school_name = $("#会社名・学校名").val();
                if(school_name === "" || school_name === null){
                    alert("会社名・学校名は入力必須です");
                    return false;
                };
                const postal_code = $("#郵便番号上3桁").val();
                const postal_num = /^\d{3}-\d{4}$/;
                if(!postal_num.test(postal_code)){
                    alert("郵便番号上7桁は入力必須です,数値フォーマットでなければなりません");
                    return false;
                };
                const location = $("#所在地都道府県").val();
                if(location === "" || location === null){
                    alert("所在地/都道府県は入力必須です");
                    return false;
                };
                const location_town = $("#所在地市区町村").val();
                if(location_town === "" || location_town === null){
                    alert("所在地/市区町村は入力必須です");
                    return false;
                };
                const location_address = $("#所在地番地ほか").val();
                if(location_address === "" || location_address === null){
                    alert("所在地/番地ほかは入力必須です");
                    return false;
                };
                const phone_number = $("#電話番号").val();
                const tel = /^\d{2}-\d{4}-\d{4}$/;
                if(!phone_number){
                    alert("電話番号は入力必須です");
                    return false;
                };
                const regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                const new_email = $("#email").val();
                if(!new_email){
                    alert("emailは入力必須です");
                    return false;
                };
            })
        })
    </script>
</head>

<body style="padding-top:50px;">
    <?php include 'header.php';?>
    <div class="container" style="margin-top:0px">
        <div class="row">
            <div class="col-sm-12">
                <div id="left">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <td class="under10"><img src="./image/bn_contact.jpg" alt="コンピュータ・ソフトウエア開発部門" width="100%" class="fontsize"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="fontsize">京設工業株式会社へのご質問お問い合わせは、下記のフォームより必要事項をご入力後、送信ください。後日、こちらからご連絡いたします。<font color="#FF3300">記入項目はすべて必須です。</font><br>
                                    お問い合わせの際、収集させていただく個人情報の取り扱いについては<a href="privacy.php" target="_blank"><u style="color: #0f0f0f">こちら</u></a>をご確認下さい。
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <form action="email.php" method="post" id="form_validate">
                            <table width="100%" border="0" cellpadding="5" cellspacing="0" class="table table-bordered fontsize">
                                <tbody>
                                    <tr>
                                        <td bgcolor="#FFFFFF" width="30%"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial;font-size: 15px"><span>お問合せ内容</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <select class="form-control" name="_お問合せ内容" id="お問合せ内容">
                                                <option>---お選びください---</option>
                                                <option value="企業情報について">企業情報について</option>
                                                <option value="採用情報について">採用情報について</option>
                                                <option value="その他">その他</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF" width="35%"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>氏　　名</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            姓<input class="form-control" name="_氏名/姓" type="text" id="氏名姓" size="15" style="display: inline-block;width: 90%;margin-left: 5px;font-size: 15px">
                                            名<input class="form-control" name="_氏名/名" type="text" id="氏名名" size="15" style="display: inline-block;width: 90%;margin-left: 5px;font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>フリガナ</span><br>
                                            <font color="#FF3300">（全角カタカナ）</font>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            姓<input class="form-control" name="_フリガナ/姓" type="text" id="フリガナ姓" style="display: inline-block;width: 90%;margin-left: 5px;font-size: 15px">
                                            名<input class="form-control" name="_フリガナ/名" type="text" id="フリガナ名" style="display: inline-block;width: 90%;margin-left: 5px;font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>会社名・学校名</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" name="_会社名・学校名" type="text" id="会社名・学校名" style="font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="5" bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>所在地</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            〒
                                            <input class="form-control" style="display: inline;width: 90%;font-size: 15px;" name="_郵便番号上3桁" type="text" id="郵便番号上3桁" size="6" maxlength="8" placeholder="例：xxx-xxxx（半角数字）">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <select name="_所在地/都道府県" class="form-control" id="所在地都道府県">
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
                                            <input class="form-control" placeholder="・市区町村" name="_所在地/市区町村" type="text" id="所在地市区町村" size="15" style="font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="・番地ほか" name="_所在地/番地ほか" type="text" id="所在地番地ほか" size="15" style="font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="・建物名" name="所在地/アパートマンション名" type="text" id="所在地/アパートマンション名" size="15" style="font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>電話番号</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="例：03-3333-3333 （半角数字）" name="_電話番号" type="text" id="電話番号" style="font-size: 15px" </td> </tr> <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>メールアドレス</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <input class="form-control" placeholder="（半角数字）" name="_email" type="email" id="email" aria-describedby="emailHelp" placeholder="Enter email" style="font-size: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><img src="./image/p_3.gif" alt="" width="15" height="17" style="vertical-align: initial"><span>お問合せ詳細</span>
                                        </td>
                                        <td bgcolor="#F8F4F9">
                                            <textarea class="form-control" placeholder="出来るだけ詳しくご記入ください。" name="_お問合せ詳細" cols="40" rows="5" id="お問合せ詳細" style="font-size: 15px"></textarea>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <img src="./image/line_note.gif" alt="" width="100%" height="1">
                            <br>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 6px">
                                <tbody>
                                    <tr>
                                        <td align="center">
                                            <input type="submit" name="Submit" style="width: 30%;margin-right: 10px;height:25%;font-size: 14px" value="送信">

                                            <input type="reset" name="Submit2" style="width: 30%;margin-left: 10px;height:25%;font-size: 14px" value="リセット" onclick="javascript: top.location.href = 'postmail.php'">
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