<?php include 'useragent.php'; ?>

<!DOCTYPE html>
<html lang="ja">

<head>
    <?php include 'ref.php'; ?>
</head>

<body onhashchange="funcRef();">
    <?php include 'header.php'; ?>
    <div class="sidebar-header" style="padding:18px 0 0 0;max-width: 540px;margin-left: auto;margin-right: auto;">
        <img width="100%" src="./image/main_image.png" alt="京設工業株式会社" />
    </div>
    <div class="container" style="margin-top: 2px">
        <div id="page-content-wrapper" style="padding: top 60px;">
            <div class="page-content inset" data-spy="scroll" data-target="#spy">
                <div class="row" style="padding: 0 2%">
                    <div class="col-6 col-md-4" style="padding-right:0.5%;padding-bottom:0%;padding-left:0%">
                        <div class="pdserv fontsize">
                            <table border="0" cellpadding="30" cellspacing="0" style="padding-top: 30px">
                                <tbody>
                                    <tr>
                                        <div class="menu-font1">
                                            <div class="menu-font-1">
                                                <div class="font-div">製品＆サービス</div>
                                                <div class="font-div">product & service</div>
                                            </div>
                                        </div>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5% 5% 5% 5%;font-size: 14px">
                                            コンピューター・ソフトウェア開発、ソフトウェア検証、機械設計、電気設計、デザイン、技術者派遣事業という５つの部門でみなさまにご提案・ご提供いたしております。
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <ul class="nav nav-pills flex-column" style="padding: 0 0 5% 5%">
                                <li class="nav-item">
                                    <a href="prdt_serv.php"><img src="./image/bt_syosai.gif" alt="製品・サービスについて詳しくはこちら" width="86" height="24" border="0"></a>
                                </li>
                            </ul>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-1">
                                <span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4" style="padding-right:0%;padding-left:0.5%;">
                        <div class="recruit fontsize" style="position: relative;">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <div class="menu-font2">
                                            <div class="menu-font-2">
                                                <div class="font-div">採用情報</div>
                                                <div class="font-div">recruit</div>
                                            </div>
                                        </div>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5% 5% 5% 5%;font-size: 14px">京設工業では、ソフトウェア開発、
                                            機械設計、電気・電子回路設計、
                                            プラスティック容器設計、DTP技術者
                                            などの募集をしております。
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <ul class="nav nav-pills flex-column" style="padding: 0 0 5% 5%">
                                <li class="nav-item">
                                    <a href="recruite.php"><img src="./image/bt_syosai.gif" alt="採用について詳しくはこちら" width="86" height="24" border="0"></a>
                                </li>
                            </ul>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-2" style="position: absolute;bottom: 0;right: 0;">
                                <span></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="padding: 0 2%">
                    <div class="col-6 col-md-4" style="padding:0.5% 0.5% 0% 0%;">
                        <div class="entry fontsize" style="position: relative;">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <div class="menu-font3">
                                            <div class="menu-font-3">
                                                <div class="font-div">エントリー</div>
                                                <div class="font-div">entry</div>
                                            </div>
                                        </div>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5% 5% 5% 5%;font-size: 14px">「常に新しいものを求め、変化を
                                            恐れず、変化を楽しむ」 という
                                            企業カルチャーを持つ京設工業
                                            で一緒に働きませんか？
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <ul class="nav nav-pills flex-column" style="padding: 0 0 5% 5%">
                                <li class="nav-item">
                                    <a href="recruite_kojin.php"><img src="./image/bt_syosai.gif" alt="エントリーについて詳しくはこちら" width="86" height="24" border="0"></a>
                                </li>
                            </ul>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-3" style="position: absolute;bottom: 0;right: 0;">
                                <span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-4" style="padding:0.5% 0% 0% 0.5%;">
                        <div class="company fontsize">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <div class="menu-font4">
                                            <div class="menu-font-4">
                                                <div class="font-div">会社案内</div>
                                                <div class="font-div">company</div>
                                            </div>
                                        </div>
                                    </tr>
                                    <tr>
                                        <td style="padding: 5% 5% 5% 5%;font-size: 14px">〒275-0024<br>千葉県習志野市茜浜1-2-6<br>
                                            ＴＥＬ．047-453-7711<br>ＦＡＸ．047-453-0670<br>
                                            【営業品目】
                                            コンピューター・ソフトウェア開発、
                                            ソフトウェア検証、機械設計、電気設計、
                                            デザイン、技術者派遣事業
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-4">
                                <span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="padding-top: 15px">
            <div class="col-12 col-md-8">
                <div id="left">
                    <table border="2" cellpadding="12" cellspacing="2" bgcolor="#210063">
                        <tr>
                            <td bgcolor="#F4F3F9" class="f_violet fontsize">
                                この度の熊本地震により被災されました方々に、心よりお見舞い申し上げます。
                                また、被災地の一日も早い復興を心よりお祈りいたします。
                            </td>
                        </tr>
                    </table>
                    <br>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="under10 fontsize" style="line-height: 1.5;">
                                京設工業株式会社はソフトウェア開発部門、機械設計部門、電気設計部門、デザイン部門（製品設計・DTP業務）、及び技術者派遣部門から構成されています。ソフトウェア開発部門においてはWindowsアプリケーション、Linux、各種組込みソフトウェアの開発に豊富な実績を持ち、機械設計部門においてはCreo（Pro/E）、iCAD
                                SX、iCAD
                                MX等の3DCADを活用した設計･開発に自信があります。京設工業株式会社はこれらの技術を十二分に活用し、アウトソーシング事業、技術者派遣事業の両分野において、お客様より高い信頼を得ています。
                            </td>
                        </tr>
                    </table>
                    <img src="./image/bn_whatnew.jpg" alt="What's New " width="100%">
                    <div class="column2">
                        <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%25E4%25BA%25AC%25E8%25A8%25AD%25E5%25B7%25A5%25E6%25A5%25AD%25E6%25A0%25AA%25E5%25BC%258F%25E4%25BC%259A%25E7%25A4%25BE-893386934127550%2F&tabs=timeline&&small_header=true&adapt_container_width=true&hide_cover=false&show_facepile=false&appId" style="border:none;overflow:hidden;width: 340px;display: block;margin-left: auto;margin-right: auto;height: 100%;" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <?php include 'footer.php'; ?>
    </div>
</body>

</html>