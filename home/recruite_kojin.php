<?php header('Content-type: text/html; charset=utf-8'); ?>
<!DOCTYPE html>
<html lang="ja">


<head>
    <?php include 'ref.php';?>
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
                                <td class="under10"><img src="./image/bn_rec_kojin.jpg" alt="個人情報の取り扱いについて" width="240" height="45"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>応募の際は、下記規約を必ずご覧いただき、内容に同意する場合は［同意する］ボタンを押して次にお進みください。 同意しない場合は［同意しない］ボタンを押してください。<br>
                                    尚、同意がいただけない場合は、応募に進むことができませんので、ご了承下さい。</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="kiyaku1">
                        <table>
                            <tbody>
                                <tr>
                                    <td>
                                        <ol style="margin-left:1.5rem">
                                            <li>個人情報とは<br>
                                                個人情報とは、個人に関する情報であって当該情報に含まれる氏名、生年月日その他の記述、または個人別に付けられた番号、記号その他の符号、画像もしくは音声によって当該個人を識別できるもの（当該情報だけでは識別できないが、他の情報と容易に照合することができ、それによって当該個人を識別できるものを含む）をいいます。</li>
                                            <li> 個人情報の利用目的<br>
                                                弊社は、業務を遂行するうえで必要な個人情報を取得する際に、その利用目的を明らかにして取得し、使用致します。なお、事前にご本人の同意を得ることなく利用目的以外に利用することは致しません。</li>
                                            <li> 個人情報の管理<br>
                                                弊社は、個人情報への不当なアクセスまたは個人情報の紛失、破壊、漏洩などの危険に対して、技術面及び組織面において必要な安全対策を継続的に講じるよう努めています。</li>
                                            <li>個人情報の第三者への提供<br>
                                                弊社は、法令の定めによる場合を除き、事前にご本人の同意を得ることなく、個人情報を第三者に提供することはありません。</li>
                                            <li>個人情報の開示・提供・削除<br>
                                                弊社は、保有している個人情報の開示・訂正・削除をご本人から求められたときは、個人情報の漏洩を防ぐため、ご本人確認が出来た場合に限り開示・訂正・削除をさせて頂きます。</li>
                                            <li>個人情報に関するお問い合わせ<br>
                                                京設工業株式会社　個人情報お問合せ窓口<br>
                                                〒275-0024千葉県習志野市茜浜1-2-6<br>
                                                TEL047-453-7711　FAX047-453-0670</li>
                                        </ol>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div align="center" class="under10" style="margin-bottom:1rem">
                        <form name="form1" method="post" action="">
                            <input type="button" name="Submit32" value="同意する" onclick="location.href='postmail.php'">
                            　　
                            <input type="reset" name="Submit222" value="同意しない" onclick="javascript:history.go(-1)">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <?php include 'footer.php';?>
    </div>
</body>


</html>
