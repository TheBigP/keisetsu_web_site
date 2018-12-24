<?php
error_reporting(E_ALL ^ E_NOTICE);
ini_set('display_errors',0);
require 'email.class.php';

$mailto='m13804017041@163.com';  //收件人
$subject=""; //邮件主题
$body="
<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <title>Title</title>
</head>
<body>
    <table align=\"left\" class=\"table table-bordered\" style=\"text-align: right\">
        <tr>
            <td bgcolor=\"#EBECF5\">お問合せ内容</td>
            <td align='left'>{$_POST["_お問合せ内容"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">氏名/姓</td>
            <td align='left'>{$_POST["_氏名/姓"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">氏名/名</td>
            <td align='left'>{$_POST["_氏名/名"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">フリガナ/姓</td>
            <td align='left'>{$_POST["_フリガナ/姓"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">フリガナ/名</td>
            <td align='left'>{$_POST["_フリガナ/名"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">会社名・学校名</td>
            <td align='left'>{$_POST["_会社名・学校名"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">郵便番号上3桁</td>
            <td align='left'>{$_POST["_郵便番号上3桁"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">所在地/都道府県</td>
            <td align='left'>{$_POST["_所在地/都道府県"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">所在地/市区町村</td>
            <td align='left'>{$_POST["_所在地/市区町村"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">所在地/番地ほか</td>
            <td align='left'>{$_POST["_所在地/番地ほか"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">所在地/アパートマンション名</td>
            <td align='left'>{$_POST["所在地/アパートマンション名"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">電話番号</td>
            <td align='left'>{$_POST["_電話番号"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">email	</td>
            <td align='left'>{$_POST["_email"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">お問合せ詳細</td>
            <td align='left'>{$_POST["_お問合せ詳細"]}</td>
        </tr>
        <tr>
            <td bgcolor=\"#EBECF5\">Submit</td>
            <td align='left'>{$_POST["Submit"]}</td>
        </tr>
    </table>
</body>
</html>
";  //邮件内容
sendmailto($mailto,$subject,$body);


function sendmailto($mailto, $mailsub, $mailbd)
{
//    require_once ('email.class.php');
    //##########################################
    $smtpserver     = "smtp.qiye.163.com"; //SMTP服务器
    $smtpserverport = 25; //SMTP服务器端口
    $smtpusermail   = "no-reply04@accounts.tttalk.org"; //SMTP服务器的用户邮箱
    $smtpemailto    = $mailto;
    $smtpuser       = "no-reply04@accounts.tttalk.org"; //SMTP服务器的用户帐号
    $smtppass       = "tttalk0507)%)&"; //SMTP服务器的用户密码
    $mailsubject    = $mailsub; //邮件主题
    $mailsubject    = "=?UTF-8?B?" . base64_encode($mailsubject) . "?="; //防止乱码
    $mailbody       = $mailbd; //邮件内容
    //$mailbody = "=?UTF-8?B?".base64_encode($mailbody)."?="; //防止乱码
    $mailtype       = "HTML"; //邮件格式（HTML/TXT）,TXT为文本邮件. 139邮箱的短信提醒要设置为HTML才正常
    ##########################################
    $smtp           = new smtp($smtpserver, $smtpserverport, true, $smtpuser, $smtppass); //这里面的一个true是表示使用身份验证,否则不使用身份验证.
    $smtp->debug    = TRUE; //是否显示发送的调试信息
    $smtp->sendmail($smtpemailto, $smtpusermail, $mailsubject, $mailbody, $mailtype);

}
echo "
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"ja\" lang=\"ja\"><head>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\">
    <meta http-equiv=\"content-type\" content=\"text/html; charset=shift_jis\">
    <title>フォームメール</title></head>
<body bgcolor=\"#f0f0f0\" text=\"#000000\" link=\"#000ff\" vlink=\"#800080\">
    <div class=\"container\">
        <div class=\"row\">
            <div class=\"col-sm-12\">
                <div id=\"left\">
                    <div align=\"center\">
                        <hr width=\"100%\">
                        <br><br>
                        <b>ありがとうございます.<br>
                            送信は正常に完了しました.</b>
                        <br><br>
                        <hr width=\"400\">
                        <form>
                            <input type=\"button\" value=\"トップに戻る\" onclick=\"window.open(&quot;http://192.168.1.118:8000/home/index.php&quot;,&quot;_top&quot;)\">
                        </form>
                        <br><br>
                    </div>
                    <br>
                    <div align=\"center\" style=\"font-size:10px; font-family:Verdana,Helvetica,Arial;\">
                        - <a href=\"http://www.kent-web.com/\" target=\"_top\">PostMail</a> -
                    </div>
                </div>
            </div>
        </div>
    </div>
</body></html>";

?>
