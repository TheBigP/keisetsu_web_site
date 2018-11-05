
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>京設工業株式会社</title>
    <link rel="stylesheet" href="../material-design/css/material-design-iconic-font.css" />
    <link rel="stylesheet" href="../css/jside-menu.css" />
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>

    <link rel="index" href="../index.html">
    <link href="../layout.css" rel="stylesheet" type="text/css">
    <link href="../keisetsu.css" rel="stylesheet" type="text/css">
    <link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body style="padding-top:  60px;">
<menu class="menubar">
    <menuitem>
        <button class="menu-trigger"> </button>
    </menuitem>

    <menuitem class="logo" title="Your Logo Goes Here">
        <a href="index.php" style="color:white">京設工業株式会社</a>
    </menuitem>
</menu>


<div class="menu-head">
        <span class="layer">
            <div>
                <img src="../image/rogo.gif" alt="京設工業株式会社" />
            </div>
            <!--//col-->
        </span>
</div>
<!--//menu-head-->

<nav class="menu-container">

    <ul class="menu-items">
        <li> <a href="index.php" align="left">
                HOME </a></li>

        <li> <a href="prdt_serv.php" align="left">
                製品＆サービス </a></li>
        <li class="has-sub">
                <span class="dropdown-heading" align="left">

                    事業所紹介 </span>
            <ul align="left">
                <li> <a href="jigyosyo.php" style="padding-left:75px">事業所紹介 </a> </li>
                <li> <a href="jigyosyo.php" style="padding-left:75px">本社／システム・ソフト開発事業部 </a> </li>
                <li> <a href="jigyosyo_akanehama.php" style="padding-left:75px">茜浜事業所 </a> </li>
                <li> <a href="jigyosyo_tokyo.php" style="padding-left:75px">東京事業所 </a> </li>
                <li> <a href="jigyosyo_yokkaichi.php" style="padding-left:75px">四日市事業所 </a> </li>
            </ul>
        </li>
        <li class="has-sub">
                <span class="dropdown-heading" align="left">

                    ISOの取り組み </span>
            <ul align="left">
                <li> <a href="iso.php" style="padding-left:75px">ISOの取り組み </a> </li>
                <li> <a href="iso.php" style="padding-left:75px">環境への取り組み </a> </li>
                <li> <a href="iso_hoshin.php" style="padding-left:75px">環境方針・品質方針 </a> </li>
            </ul>
        </li>

        <li class="has-sub">
                <span class="dropdown-heading" align="left">

                    採用情報 </span>
            <ul align="left">
                <li> <a href="recruite.php" style="padding-left:75px">採用情報 </a> </li>
                <li> <a href="recruite.php" style="padding-left:75px">新卒採用情報 </a> </li>
                <li> <a href="#obo1" style="padding-left:75px">応募方法・選考の流れ（新卒） </a> </li>
                <li> <a href="recruite_career.php" style="padding-left:75px">キャリア採用情報 </a> </li>
                <li> <a href="recruite_career.php#obo2" style="padding-left:75px">応募方法・選考の流れ（キャリア） </a> </li>
                <li> <a href="recruite_kojin.php" style="padding-left:75px">エントリーフォーム </a> </li>
                <li> <a href="recruite_interview.php" style="padding-left:75px">社員インタビュー </a> </li>
            </ul>
        </li>

        <li><a href="postmail.php" align="left">
                お問い合わせ </a></li>
    </ul>
</nav>
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="../js/jquery.jside.menu.js"></script>
<script>
    $(document).ready(function () {

        $(".menu-container").jSideMenu({
            jSidePosition: "position-left", //possible options position-left or position-right

            jSideSticky: true, // menubar will be fixed on top, false to set static

            jSideSkin: "default-skin", // to apply custom skin, just put its name in this string
        });
    });
</script>
