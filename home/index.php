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
        <div class="row" style="padding-top: 5px">
            <div class="col-12 col-md-8">
                <div id="left">
                    <table border="2" cellpadding="12" cellspacing="2" bgcolor="#210063" style="border: 2px solid #336698;margin-bottom: 10px">
                        <tr>
                            <td bgcolor="#F4F3F9" class="f_violet fontsize">
                                この度の熊本地震により被災されました方々に、心よりお見舞い申し上げます。
                                また、被災地の一日も早い復興を心よりお祈りいたします。
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="page-content-wrapper">
            <div class="page-content inset" data-spy="scroll" data-target="#spy">
                <div class="row" style="padding: 0 4%">
                    <div class="col-6 col-md-4" style="padding-right:0.5%;padding-bottom:0%;padding-left:0%">
                      <a href="prdt_serv.php">
                        <div class="pdserv fontsize">
                            <table border="0" cellpadding="30" cellspacing="0" style="padding-top: 30px">
                                <tbody>
                                <tr>
                                    <div class="menu-font1">
                                        <div class="menu-font-1">
                                            <div class="font-div" style="font-size: 14px"><b>製品＆サービス</b></div>
                                            <div class="font-div">product & service</div>
                                        </div>
                                    </div>
                                </tr>
                                <tr>
                                    <td style="padding: 5% 10% 5% 10%">
                                        <div><img src="./image/product_service.png" style="width: 100%;height: 100%;"/></div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-1">
                                <span></span>
                            </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-6 col-md-4" style="padding-right:0%;padding-left:0.5%;">
                       <a href="recruite.php">
                        <div class="recruit fontsize" style="position: relative;">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tbody>
                                <tr>
                                    <div class="menu-font2">
                                        <div class="menu-font-2">
                                            <div class="font-div" style="font-size: 14px"><b>採用情報</b></div>
                                            <div class="font-div">recruit</div>
                                        </div>
                                    </div>
                                </tr>
                                <tr>
                                    <td style="padding: 5% 10% 5% 10%;font-size: 14px">
                                        <div><img src="./image/recruit.png" style="width: 100%;height: 100%;"/></div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-2" style="position: absolute;bottom: 0;right: 0;">
                                <span></span>
                            </div>
                        </div>
                       </a>
                    </div>
                </div>
                <div class="row" style="padding: 0 4%">
                    <div class="col-6 col-md-4" style="padding:0.5% 0.5% 0% 0%;">
                       <a href="recruite_kojin.php">
                        <div class="entry fontsize" style="position: relative;">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tbody>
                                <tr>
                                    <div class="menu-font3">
                                        <div class="menu-font-3">
                                            <div class="font-div" style="font-size: 14px"><b>エントリー</b></div>
                                            <div class="font-div">entry</div>
                                        </div>
                                    </div>
                                </tr>
                                <tr>
                                    <td style="padding: 5% 10% 5% 10%;font-size: 14px">
                                        <div><img src="./image/entry.png" style="width: 100%;height: 100%;"/></div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-3" style="position: absolute;bottom: 0;right: 0;">
                                <span></span>
                            </div>
                        </div>
                       </a>
                    </div>
                    <div class="col-6 col-md-4" style="padding:0.5% 0% 0% 0.5%;">
                      <a href="company.php">
                        <div class="company fontsize">
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tbody>
                                <tr>
                                    <div class="menu-font4">
                                        <div class="menu-font-4">
                                            <div class="font-div" style="font-size: 14px"><b>企業情報</b></div>
                                            <div class="font-div">company</div>
                                        </div>
                                    </div>
                                </tr>
                                <tr>
                                    <td style="padding: 5% 10% 5% 10%;font-size: 14px">
                                        <div><img src="./image/company.png" style="width: 100%;height: 100%;"/></div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!-- 向左的三角形 -->
                            <div class="triangle_border_left color-4">
                                <span></span>
                            </div>
                        </div>
                      </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="padding-top: 5px;">
            <div class="col-12 col-md-8">
                <div id="left">
                    <!--<table border="0" cellpadding="0" cellspacing="0">
                        <tr class="bgcolor-img">
                            <td class="under10 fontsize bgcolor-position" style="line-height: 1.5;">
                                京設工業株式会社 全 5 部門
                                システム・ソフトウェア開発、機械設計、電気設計、
                                デザイン（製品設計・DTP 業務）、及び技術者派遣
                            </td>
                        </tr>

                    </table>-->
                    <div class="bgcolor-img">
                        <div style="border-bottom-style: solid;padding: 2% 5% 2% 5%;">
                        京設工業株式会社 全 5 部門<br>
                        システム・ソフトウェア開発、機械設計、電気設計、
                        デザイン（製品設計・DTP 業務）、及び技術者派遣
                        </div>
                        <div style="border-bottom-style: solid;padding: 2% 5% 2% 5%;">
                        ソフトウェア開発部門<br>
                        Windows アプリケーション、Linux、各種組込み
                        ソフトウェアの開発に豊富な実績
                        </div>
                        <div style="border-bottom-style: solid;padding: 2% 5% 2% 5%;">
                        機械設計部門<br>
                        Creo（Pro/E）、iCAD SX、iCAD MX 等の
                        3DCAD を活用した設計･開発に自信
                        </div>
                        <div style="border-bottom-style: solid;padding: 2% 5% 2% 5%;">
                        技術を十二分に活用し<br>
                        アウトソーシング事業、技術者派遣事業の両分野に
                        おいて、お客様より高い信頼を得ています
                        </div>
                    </div>
                    <img src="./image/bn_whatnew.jpg" alt="What's New " width="100%">
                    <div class="column2">
                        <iframe id="frmFacebook" style="border:none;overflow:hidden;width: 100%;display: block;margin-left: auto;margin-right: auto;height: 100%;min-height: 300px;" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <?php include 'footer.php'; ?>
    </div>
</body>

</html>