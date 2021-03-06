<div class="wrapper">
    <!-- Sidebar  -->
    <nav id="sidebar">
        <ul class="list-unstyled" style="font-size: 14px;">
            <li class="li-border" style="border-top: 0.5px solid #FFFFFF;"><a href="index.php" align="left">
                    HOME </a></li>
            <li class="li-border"><a href="prdt_serv.php" align="left">
                    製品＆サービス </a></li>
            <li class="li-border">
                <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">事業所紹介</a>
                <ul class="collapse list-unstyled" id="homeSubmenu">
                    <li>
                        <a href="jigyosyo.php">本社／システム・ソフト開発事業部 </a>
                    </li>
                    <li>
                        <a href="jigyosyo_akanehama.php">茜浜事業所 </a>
                    </li>
                    <li>
                        <a href="jigyosyo_tokyo.php">東京事業所 </a>
                    </li>
                    <li>
                        <a href="jigyosyo_yokkaichi.php">四日市事業所 </a>
                    </li>
                </ul>
            </li>
            <li class="li-border">
                <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">ISOの取り組み</a>
                <ul class="collapse list-unstyled" id="pageSubmenu">
                    <li>
                        <a href="iso.php">環境への取り組み </a>
                    </li>
                    <li>
                        <a href="iso_hoshin.php">環境方針・品質方針 </a>
                    </li>
                </ul>
            </li>
            <li class="li-border">
                <a href="#Submenu" data-toggle="collapse" aria-expanded="false">採用情報</a>
                <ul class="collapse list-unstyled" id="Submenu">
                    <li>
                        <a href="recruite.php">新卒採用情報 </a>
                    </li>
                    <li>
                        <a href="recruite.php#obo1" onclick="js_method()" class="recuit_obo1">応募方法・選考の流れ（新卒） </a>
                    </li>
                    <li>
                        <a href="recruite_career.php">キャリア採用情報 </a>
                    </li>
                    <li>
                        <a href="recruite_career.php#obo2" onclick="js_method()" class="recuit_obo2">応募方法・選考の流れ（キャリア） </a>
                    </li>
                    <li>
                        <a href="recruite_kojin.php">エントリーフォーム </a>
                    </li>
                    <li>
                        <a href="recruite_interview.php">社員インタビュー </a>
                    </li>
                </ul>
            </li>
            <li class="li-border"><a href="postmail.php" align="left">
                    お問い合わせ</a></li>
            <li>
            <li class="li-border">
                <a href="#companySubmenu" data-toggle="collapse" aria-expanded="false">会社案内</a>
                <ul class="collapse list-unstyled" id="companySubmenu">
                    <li>
                        <a href="company.php">ごあいさつ </a>
                    </li>
                    <li>
                        <a href="company_gaiyo.php">会社概要・沿革 </a>
                    </li>
                </ul>
            </li>
            <li><a href="sitemap.php" align="left">
                    サイトマップ</a></li>
            <li>
        </ul>
    </nav>

    <!-- Page Content  -->
    <nav class="navbar navbar-expand-lg menubar sticky default-skin" id="navbar-example2">
        <div class="container-fluid">
            <button type="button" id="sidebarCollapse" class="menu-trigger right menu-content" style="line-height: initial;"></button>
            <a href="index.php" class="img-position" align="left" ><img src="./image/keisetsu_Logo_KEISETSU.png" style="width: 100%;height: 100%" align="left" alt="京設工業株式会社" /></a>
            <div style="margin-right: auto;margin-left: auto;height: 48px">
                <img src="./image/KEISETSU_Logo.png" height="20px" style="display: block;margin-top: 6%">
                <div style="height: 14px;color:white;font-size:10px;line-height: 100%;margin-top: 3%;text-align: center">京設工業株式会社</div>
            </div>
        </div>
    </nav>

</div>
<script>
    function js_method() {
        $('#sidebar').removeClass('active');
        $('.container').removeClass('active');
        $('#sidebarCollapse').addClass('menu-content');
        $('#sidebarCollapse').removeClass('menu-content-change');
    }
</script>