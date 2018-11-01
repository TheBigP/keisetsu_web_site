package tk_util4;

# RCS Infomation.
# 以下，情報の変更・削除を禁じます ------------------------------------------------------------------------ #
$CGI{'RCS_ID'}      =  "$Id: tk_util4.pl 3.2 2002/07/11 10:48:13 Administrator Exp Administrator $damy";
$CGI{'RCS_SOURCE'}  =  "$Source: D:/Users/administrator/projects/works/salut/C-S03_tk_util4.pl/RCS/tk_util4.pl $damy";
# ------------------------------------------------------------------------------------------------ ここまで #
# 以下，情報の変更・削除を禁じます ------------------------------------------------------------------------ #
#
# TK's CGIサポートユーティリティライブラリ4：tk_util4.pl
# Copyright(C) Tomonori Kamitaki 2001
#
# [利用規程および規約]
#
#   このプログラムは，フリーウェアですが，以下の点を守って使用して下さい。
#
#  1. このプログラムを改造しても良いですが，著作権等の破棄はしておりませんのでこれに関する全ての表記および
#     コメントの削除を禁止します。
#
#  2. 配布する場合は，必ずオリジナルのファイルを添付して下さい。
#
#  3. このプログラムの使用および改造方法，設置方法に関するサポートは通信手段を問わず一切行っておりません。
#
#  4. すべてのプロバイダや環境で動作する事は保証していません。
#
#  5. 当プログラムを利用した事によるいかなる損害も作者は一切の責任を負いません。
#
#  6. 作者に著しく不利益があると判断した場合には一方的にプログラムの使用を中止していただくことがあります。
#
# ------------------------------------------------------------------------------------------------ ここまで #

# データ・タイプ
$k_config_a         = 10;
$k_tpl_html         = 20;
$k_tpl              = $k_tpl_html;
$k_csv_data         = 30;
$k_plain_txt        = 40;

# カンマ文字設定（下位互換性用：次期バージョンでは廃止予定）
$k_cm_char          = ",";
$k_cm_replace_head  = "&[";
$k_cm_replace_foot  = "]";

# 汎用クッキー処理のデフォルト設定（0 = off, 1 = on）
#   ここで変更しては行けません。
#   メインプログラムの本ライブラリ読込後に設定する（$tk_util4::g_cookie_enable = 1;等）
$k_cookie_enable = 0;

# セパレータ文字列
$k_sep = "<>";

# <BR>タグを許可（0 = 無効，1 = 有効）
$k_br_enable = 0;

# jcode.pl へのパス
$k_jcode_pl_path = './share/jcode.pl';

# mimew.pl へのパス
$k_mimew_path = './share/mimew.pl';

# nkfへのパス
$k_nkf_path = '/usr/local/bin/nkf';

# nkf日本語コードテーブル
$k_jpn_code_nkf_tbl{'jis'}  = '-j';
$k_jpn_code_nkf_tbl{'sjis'} = '-s';
$k_jpn_code_nkf_tbl{'euc'}  = '-e';

# echoへのパス
$k_echo_path = '/bin/echo';

# メール送信プログラムへのパスとコマンドオプション
$k_mail_prog_path = '/usr/lib/sendmail';
$k_mail_prog_opt = '-t -f';

# quotaへのパス
$k_quota_path = '/usr/bin/quota';

# エラー表示関数
$k_error_func_ref = \&main::error;

# CGI情報変数（ハッシュ）
$k_CGI_INFO_ref = \%main::CGI;

# ロックに高速リトライサイクルモードを使用する（ ON = 1, OFF = 0 ）
$k_lock_fast_cycle = 1;

# デッバグ設定（0 = 無効，1 = 有効）
$k_debug = 0;

if($k_debug) {
    open(DEBUG, ">./debug_tkutil4.txt") || die "DEBUG FILE ERROR!!";
}

require $k_mimew_path;

# &parseInput()
# <IN>  \%in            = parseデータを格納するハッシュ         ※省略不可
#       $encoding       = 文字コード：jis|sjis|euc              ※省略可
#       $html_tag_flag  = htmlタグ：有効     = 0                ※省略可（その際は"1"の動作）
#                                   <BR>のみ = 1
#                                   無効     = 上記以外の数値
sub parseInput
{
    my($in_ref, $encoding, $html_tag_flag) = @_; # sub関数用の引数取得
    my($query, @query);
    my($key, $val);

    unless(length($html_tag_flag)) {
        $html_tag_flag = 1;
        $k_br_enable = 1;
    }

    # クエリは"GET"経由か？
    if($ENV{'REQUEST_METHOD'} eq 'GET') {
        # Yes：クエリをセット
        $query = $ENV{'QUERY_STRING'};
    # クエリは"POST"経由か？
    } elsif($ENV{'REQUEST_METHOD'} eq 'POST') {
        # Yes：クエリを読込
        read(STDIN, $query, $ENV{'CONTENT_LENGTH'});
    } else {
        # エラー：
        return "error in parseInput()\n";
    }

    # "+" を " "（スペース）へ変換
    $query =~ tr/+/ /;
    # クエリ文字列を通常文字へ変換
    $query =~ s/%([A-Fa-f0-9][A-Fa-f0-9])/pack("C", hex($1))/gie;

    # 日本語変換有り？
    if($encoding) {
        # 有り：
        &convert_jpn_code(\$query, \$encoding);
    }

    # クエリを分解して一つずつ処理
    foreach(split(/&/, $query)) {

        # キーと値（Value）に分解
        ($key, $val) = split(/=/, $_);

        # HTML文字列に準ずる文字列への変換は必要か？
        if($html_tag_flag) {
            # 必要：HTML文字列に準ずる文字列への変換
            &convert_char_std2html(\$val);
        }

        # 値をセット
        $in_ref->{$key} = $val;
    }
    return 0;
}

# 日本語変換処理関数
sub convert_jpn_code
{
    my($val_ref, $encoding_ref) = @_; # sub関数用の引数取得

    # nkf はあるか？
    if(-e $k_nkf_path) {
        # ある：
        &convert_jpn_code_by_nkf($val_ref, $encoding_ref);
    # jcode.pl はあるか？
    } elsif(-e $k_jcode_pl_path) {
        # ある：
        if(\&jcode::convert) {
            require $k_jcode_pl_path;
        }
        &convert_jpn_code_by_jcode($val_ref, $encoding_ref);
    }
}

# 日本語変換処理関数（※通常直接この関数を実行しません。convert_jpn_code()関数を使用して変換を行います。：nkfを使用）
sub convert_jpn_code_by_nkf
{
    my($val_ref, $encoding_ref) = @_; # sub関数用の引数取得

    $$val_ref =~ s/'/'\\''/g;
    open(NKF,"$k_echo_path '$$val_ref' | $k_nkf_path $k_jpn_code_nkf_tbl{$$encoding_ref} |");
    $$val_ref = "";
    while (<NKF>) {
          $$val_ref .= $_;
    }
    close(NKF);
    chop($$val_ref);
}

# 日本語変換処理関数（※通常直接この関数を実行しません。convert_jpn_code()関数を使用して変換を行います。：jcode.plを使用）
sub convert_jpn_code_by_jcode
{
    my($val_ref, $encoding_ref) = @_; # sub関数用の引数取得

    &jcode::convert(\$val_ref, $$encoding_ref);
}

# 通常の文字列をHTMLに準ずる文字列に変換します。
sub convert_char_std2html
{
    my($val_ref) = @_; # sub関数用の引数取得

    if($k_br_enable) {
        # <BR>タグを一時的に改行に置換
        $$val_ref =~ s/<BR>/\n/gi;
    }
    $$val_ref =~ s/</&lt;/g;
    $$val_ref =~ s/>/&gt;/g;
    $$val_ref =~ s/\"/&#34;/g;
    $$val_ref =~ s/\'/&#39;/g;
    $$val_ref =~ s/,/&#44;/g;

    # 改行を置換
    $$val_ref =~ s/\r\n/<BR>/g;
    $$val_ref =~ s/\n/<BR>/g;
    $$val_ref =~ s/\r/<BR>/g;
}

# HTMLに準ずる文字列を通常の文字列に変換します。
sub convert_char_html2std
{
    my($val_ref) = @_; # sub関数用の引数取得

    $$val_ref =~ s/&lt;/</g;
    $$val_ref =~ s/&gt;/>/g;
    $$val_ref =~ s/&#34;/\"/g;
    $$val_ref =~ s/&#39;/\'/g;
    $$val_ref =~ s/&#44;/,/g;
    $$val_ref =~ s/<BR>/\n/gi;
}

# 設定ファイル読込関数
# $config_file_list_ref = 読み込む設定ファイルリストへのリファレンス
# $config_ref           = 設定格納ハッシュ配列へのリファレンス
# 返値                  = エラー文字列：エラー無時は未定義値
sub readConfigFile
{
    my($config_file_list_ref, $config_ref) = @_; # sub関数用の引数取得
    my($error);

    for(@$config_file_list_ref) {
        if(&tk_util4::readDataFile($_, $k_config_a, $config_ref)) {
            $error .= '設定ファイル「'.$_.'」の読込に失敗しました。<BR>';
        }
    }
    return $error;
}

# &readDataFile()
# <IN>  $file_name          = ファイル名(パス含可)
#       $data_type          = 読込データの種類( ファイル上部参照 )
#       \($ | @ | %)object  = データを格納するオブジェクト( データの種類に応じて可変 )
#       $extend_property    = データの種類により指定
sub readDataFile
{
    my($file_name, $data_type, $data_ref, $extend_property) = @_; # sub関数用の引数取得
    my($id, $saveSeprater) = 0;

    # 引数は足りているのか？
    if(($file_name) && ($data_type) && ($data_ref)) {
        open(IN, "$file_name") || return "readDataFile(); ファイル読込失敗 $file_name";
        $saveSeprater = $/;
        $/ = "\n";
        # データタイプは，$k_config_aであるか？
        if($data_type == $k_config_a) {
            $data_ref->{'id-Nums'} = exists $data_ref->{'id-Nums'} ? $data_ref->{'id-Nums'} : 0;
            while(<IN>) {
                $_ =~ s/\r\n/\n/g;
                # 空行？
                if(length($_) > 1) {
                    # コメント行？
                    if($_ =~ m/^[^#]/) {
                        # :定義行？
                        if($_ =~ m/^:(.+?)\n/) {
                            $id = $1;
                            unless(exists $data_ref->{$id."-id"}) {
                                $data_ref->{"id-".$data_ref->{'id-Nums'}} = $id;
                                $data_ref->{$id."-id"} = $id;
                                $data_ref->{'id-Nums'}++;
                            }
                        } else {
                            # 定義の内容？
                            if($_ =~ m/^(.+?)=((.+?)\n)$/) {
                                $data_ref->{$id."-".$1} = $3;
                            }
                        }
                    }
                }
            }
        # データタイプは，$k_tpl_htmlであるか？
        } elsif($data_type == $k_tpl_html) {
            my($len) = 1;
            # プロパティはあるか？
            if($extend_property) {
                # 文字列 1 以下（改行）を無視しない
                $len = 0;
            }
            $data_ref->{'id-Nums'} = exists $data_ref->{'id-Nums'} ? $data_ref->{'id-Nums'} : 0;
            while(<IN>) {
                $_ =~ s/\r\n/\n/g;
                # 空行？
                if(length($_) > $len) {
                    # コメント行？
                    if($_ =~ m/^[^#]/) {
                        # :定義行？
                        if($_ =~ m/^:(.+?)\n/) {
                            $id = $1;
                        } else {
                            $data_ref->{$id} .= $_;
                        }
                    }
                }
            }
        # データタイプは，$k_csv_dataであるか？
        } elsif($data_type == $k_csv_data) {
            # 区切り文字は，特別指定であるか？
            if(!($extend_property)) {
                # 省略時設定
                $extend_property = ",";
            }
            $data_ref->{'id-Nums'} = exists $data_ref->{'id-Nums'} ? $data_ref->{'id-Nums'} : 0;
            while(<IN>) {
                $_ =~ s/\r\n/\n/g;
                # 空行？
                if(length($_) > 1) {
                    # コメント行？
                    if($_ =~ m/^[^#]/) {
                        # :定義行？
                        if($_ =~ m/^:(.+?)\n/) {
                            @csv_item_name = split(/$extend_property/, $1);
                            $data_ref->{'csv-itName-nums'} = $#csv_item_name + 1;

                            $i = 0;
                            for(@csv_item_name) {
                                $data_ref->{"csv-itName-".$i} = $_;
                                $i++;
                            }
                        } else {
                            $_ =~ m/(.+?)\n$/;
                            @csv_array = split(/$extend_property/, $1);

                            $data_ref->{"id-".$data_ref->{'id-Nums'}} = $csv_array[0];

                            # 下位互換性用：次期バージョンでは廃止予定 ------- #
                            $st1 = quotemeta($k_cm_replace_head);
                            $st2 = quotemeta($k_cm_replace_foot);
                            # ----------------------------------- 下位互換性用 #

                            $i = 0;
                            foreach(@csv_item_name) {

                                # 下位互換性用：次期バージョンでは廃止予定 ------- #
                                $csv_array[$i] =~ s/$st1(.+?)$st2/&char_pack($1)/ge;
                                # ----------------------------------- 下位互換性用 #

                                $data_ref->{$csv_array[0]."-".$_} = $csv_array[$i];
                                $i++;
                            }
                            $data_ref->{$csv_array[0]."-position"} = ++$data_ref->{'id-Nums'};
                        }
                    }
                }
            }
        # データタイプは，$k_plain_txtであるか？
        } elsif($data_type == $k_plain_txt) {
            while(<IN>) {
                $_                  =~ s/\r\n/\n/g;
                $data_ref->[$id]    = $_;
                $id++;
            }
        } else {
            return "readDataFile(); 未実装であるか，定義されていないデータタイプが指定されました。$data_type";
        }
        $/ = $saveSeprater;
        close(IN);
    } else {
        return "readDataFile(); 引数が足りません。$file_name, $data_type";
    }
    return 0;
}

# &saveDataFile()
# <IN>  $file_name              = ファイル名(パス含可)
#       $data_type              = 書込データの種類( ファイル上部参照 )
#       \($ | @ | %)object_ref  = 保存するオブジェクト( データの種類に応じて可変 )
#       \$data_head_ref         = ファイルの先頭に書き込むデータ( データの種類に応じて可変 ) ※無指定可
#       \$data_foot_ref         = ファイルの終端に書き込むデータ( データの種類に応じて可変 ) ※無指定可
#       $extend_property        = データの種類により指定
sub saveDataFile
{
    my($file_name, $data_type, $data_ref, $data_head_ref, $data_foot_ref, $extend_property) = @_; # sub関数用の引数取得
    my($id, $tmp);

    # 引数は足りているのか？
    if(($file_name) && ($data_type) && ($data_ref)) {
        # ファイルを作成：既存のファイルは，上書される
        open(OUT, ">$file_name") || return "saveDataFile(); ファイル作成失敗 $file_name";
        # データタイプは，$k_csv_dataであるか？
        if($data_type == $k_csv_data) {
            # 区切り文字は，特別指定であるか？
            if(!($extend_property)) {
                # 省略時設定
                $extend_property = ",";
            }
            # ヘッダの出力
            if($data_head_ref) {
                foreach(@$data_head_ref) {
                    print OUT $_;
                }
            } else {
                return "saveDataFile(); csv データの保存には，必ずヘッダが必要です。"
            }
            # アイテム名を所得
            $data_head_ref->[0] =~ m/^:(.+?)\n/;
            my(@csv_item_name)  = split(/$extend_property/, $1);
            # 行単位にアイテムを順番に出力
            my($u_id);
            for($id = 0; $id < $data_ref->{'id-Nums'}; $id++) {
                $u_id = $data_ref->{"id-".$id};
                foreach(@csv_item_name) {

                    # 下位互換性用：次期バージョンでは廃止予定 ------- #
                    $data_ref->{$u_id."-".$_} =~ s/($k_cm_char)/&#44;/g;
                    # ----------------------------------- 下位互換性用 #

                    print OUT $data_ref->{$u_id."-".$_}, "$extend_property";
                }
                print OUT "\n";
            }
            # フッタの出力
            if($data_foot_ref) {
                foreach(@$data_foot_ref) {
                    print OUT $_;
                }
            }

            $ret = 0;
        } else {
            # エラー：データタイプの異常
            $ret = "saveDataFile();  未実装であるか，定義されていないデータタイプが指定されました。$data_type";
        }
        # ファイルを閉じる
        close(OUT);
    } else {
        # エラー：ファイル操作の為の引数不足
        $ret = "saveDataFile(); 引数が足りません。$file_name";
    }
    return 0;
}

sub char_unpack
{
    my($char) = @_; # sub関数用の引数取得
    $char = unpack("C*", $char);
    $char = $k_cm_replace_head.$char.$k_cm_replace_foot;
    return $char;
}

sub char_pack
{
    my($char) = @_; # sub関数用の引数取得
    $char = pack("C*", $char);
    return $char;
}

# ASV ヘッダ：読込（ファイル先頭アイテム名定義を読込）
sub asv_read_head
{
    my($FH_ref, $item_name_ref, $sep) = @_; # sub関数用の引数取得
    my($str) = "";

    # 読み込み
    if(!($str = <$FH_ref>)) {
        # 読み込みデータなし
        return 1;
    }

    $str =~ s/\r\n/\n/g;

    # 定義行であるか？
    if($str =~ m/^:(.+?)\n/) {
        @$item_name_ref = split(/$sep/, $1);
    }
    return;
}

# ASV ヘッダ：書込（ファイル先頭アイテム名定義を読込）
sub asv_write_head
{
    my($FH_ref, $item_name_ref, $sep) = @_; # sub関数用の引数取得

    print $FH_ref ":";

    for(@$item_name_ref) {
        if( 1 != print $FH_ref $_, $sep ) {
            # 出力エラー
            return 1;
        }
    }
    if( 1 != print $FH_ref "\n" ) {
        # 出力エラー
        return 1;
    }
    return;
}

# ASV データ：読込 (Any-char Separated Value)
sub asv_read_data
{
    my($FH_ref, $log_data_ref, $item_name_ref, $sep) = @_; # sub関数用の引数取得
    my($str, $i) = "";

    # 読み込み
    while($str = <$FH_ref>) {
        if($str =~ m/^[#\n]/) {
            next;
        } else {
            last;
        }
    }

    unless($str) {
        return 1;
    }

    # 改行コード等を削除
    $str =~ s/\r//g;
    $str =~ s/\n//g;

    # 文字列をセパレータで分解
    my(@log_tmp) = split(/$sep/, $str);

    # 下位互換性用：次期バージョンでは廃止予定 ------- #
    my($st1) = quotemeta($k_cm_replace_head);
    my($st2) = quotemeta($k_cm_replace_foot);
    # ----------------------------------- 下位互換性用 #

    # アイテム名をキーにして取得データをハッシュへセット
    for(@log_tmp) {

        # 下位互換性用：次期バージョンでは廃止予定 ------- #
        $_ =~ s/$st1(.+?)$st2/&char_pack($1)/ge;
        # ----------------------------------- 下位互換性用 #

        $log_data_ref->{$item_name_ref->[$i]} = $_;
        $i++;
    }
    return;
}

# ASV データ：書込 (Any-char Separated Value)
sub asv_write_data
{
    my($FH_ref, $log_data_ref, $item_name_ref, $sep) = @_; # sub関数用の引数取得

    # データを指定のファイルハンドルへ出力
    for(@$item_name_ref) {
        if( 1 != print $FH_ref $log_data_ref->{$_}, $sep ) {
            # 出力エラー
            return 1;
        }
    }
    if( 1 != print $FH_ref "\n" ) {
        # 出力エラー
        return 1;
    }
    return;
}

# v4.0 New Function. --------------------------------------------------------------------------------------------------#

# 入力フォームのチェック
sub check_input_form
{
    my($in_ref, $check_list_strings_ref, $error_ref, $chk_numeric_flag, $i_sep, $v_sep) = @_; # sub関数用の引数取得
    my($ret);

    # セパレータ文字のチェック
    unless($i_sep) { $i_sep = $k_cm_char; }
    unless($v_sep) { $v_sep = $k_sep; }
    if($i_sep eq $v_sep) { return "Item値とValue値のセパレータ文字が同じです。"; }

    # 初期化：念の為
    $$error_ref = "";

    # チェックアイテム取得してリストにあるアイテムをチェックする
    for(split(/$i_sep/, $$check_list_strings_ref)) {
        my($item, $name) = split(/$v_sep/, $_);
        # 入力はあるか？
        if(!(length($in_ref->{$item}))) {
            # なし：エラー文字列にエラー内容を追加
            $$error_ref .= $name."がありません。\n";
        } else {
            # あり：
            if($chk_numeric_flag) {
                if($in_ref->{$item} =~ m/[\D]/) {
                    $$error_ref .= $name."に数字以外の文字があります。\n";
                }
            }
            $ret++;
        }
    }
    # 入力無し数を返値
    return $ret;
}


# メールアドレスのチェック（書式的に）
sub check_email_address
{
    my($email_address_ref) = @_; # sub関数用の引数取得

    if(length($$email_address_ref)) {
        # あり：正当性はあるか？（書式的に）
        unless($$email_address_ref =~ m/(.+?)\@(.+?)\.(.+?)/) {
            # 不正：エラー表示文字を設定
            return "メールアドレスが不正です。正しいメールアドレスを入力して下さい。";
        }
    }
    return 0;
}


# メール送信処理
sub send_mail
{
    my($mail_data_ref, $mail_addresser) = @_; # sub関数用の引数取得

    my($err_info) = "send_mail(); ";

    # HTML文字を元に戻す
    &convert_char_html2std($mail_data_ref);

    # 文字コードの変換
    &convert_jpn_code($mail_data_ref, 'jis');


    if(1) { # 従来の動作にする場合は，0 にしてください。

        # Subject の日本語を MIME-B に変換
        $$mail_data_ref =~ s/^(Subject:\s+)(.*)$/&mail_head_encode($1, $2)/me;

    }

    unless(-e $k_mail_prog_path) {
        if($k_debug) {
            print DEBUG "$k_mail_prog_path $k_mail_prog_opt$mail_addresser\n";
            print DEBUG "$$mail_data_ref\n";
            return;
        } else {
            return $err_info."メール送信に失敗しました。\nメール送信プログラム（$k_mail_prog_path）がありません。";
        }
    }

    # mail program へのパイプを開く
    open(MAIL_PROG, "| $k_mail_prog_path $k_mail_prog_opt$mail_addresser") || return $err_info."メール送信に失敗しました。\nしばらくしてからもう一度アクセスしてみて下さい。\nそれでも解決しない場合はサイト管理者へお問い合わせ下さい。";
    # メールの内容を出力
    print MAIL_PROG $$mail_data_ref;
    # mail program へのパイプを閉じる
    close(MAIL_PROG);

    # エラー情報を返値
    return 0;
}

# MIME-Bエンコーディング変換
sub mail_head_encode
{
    my($head, $data) = @_; # sub関数用の引数取得

    my($result) = &main::mimeencode($data);

    return $head.$result;
}

# CGI情報設定
sub set_cgi_info
{
    my($in_ref, $config_ref) = @_; # sub関数用の引数取得

    my($remote_host);
    # 環境変数[REMOTE_HOST]はセットされているか？
    if(!$ENV{'REMOTE_HOST'}){
        # なし：Socket読込
        use Socket;
        # [REMOTE_ADDR]から[REMOTE_HOST]を取得
        $remote_host = gethostbyaddr(inet_aton($ENV{'REMOTE_ADDR'}),AF_INET);
    } else {
        $remote_host = $ENV{'REMOTE_HOST'};
    }

    # ホストのデータ・アイテム名のチェック
    if(!($config_ref->{$config_ref->{'id-0'}."-HOST_ITEM_NAME"})) {
        # デフォルト設定：HOST
        $config_ref->{$config_ref->{'id-0'}."-HOST_ITEM_NAME"} = "HOST";
    }
    # ホストアドレスを設定
    $in_ref->{$config_ref->{$config_ref->{'id-0'}."-HOST_ITEM_NAME"}} = $remote_host;

    # 日時のデータ・アイテム名のチェック
    if(!($config_ref->{$config_ref->{'id-0'}."-DATE_ITEM_NAME"})) {
        # デフォルト設定：DATE
        $config_ref->{$config_ref->{'id-0'}."-DATE_ITEM_NAME"} = "DATE";
    }
    # 日付を設定
    $in_ref->{$config_ref->{$config_ref->{'id-0'}."-DATE_ITEM_NAME"}} = &get_time();
}

# ログをテンプレートに基づいて変換（ASV形式ログ）※$src_file_path = "." でログ無
sub convert_log2file_with_tpl
{
    my($in_ref, $usr_cfg_ref, $tpl_file_path, $src_file_path, $dst_file_path, $log_sep) = @_; # sub関数用の引数取得
    my($error, %tpl, %usr_log, @item_name, %cookie);

    # エラー情報設定
    my($err_info) = "convert_log2file_with_tpl(); \n";
    # テンプレート読込
    if($error = &readDataFile($tpl_file_path, $k_tpl_html, \%tpl)) { &$k_error_func_ref($err_info.$error); }
    # テンプレート初期化
    &setup_tpl($in_ref, \%tpl, $usr_cfg_ref, \%cookie);
    # 書出先を作成
    open(DST, ">$dst_file_path") or &$k_error_func_ref($err_info."書出先を作成できませんでした。\n$!");
    # メイン・ヘッダを書出先へ出力
    print DST $tpl{'MAIN_HEAD'};

    # ログ有？
    unless($src_file_path eq ".") {
        # ログを開く
        open(SRC, $src_file_path) or &$k_error_func_ref($err_info."ログ読込：[ $src_file_path ]ログファイルのオープンに失敗しました。\n$!");
        # ログ・ヘッダ読み込み
        if(&asv_read_head(\*SRC, \@item_name, $log_sep)) { &$k_error_func_ref($err_info."ログファイルヘッダの読込に失敗しました。\n$!"); }
        # ログ読込
        while(!(&asv_read_data(\*SRC, \%usr_log, \@item_name, $log_sep))) {
            # 記事上側部分の置換処理＆書出先へ出力
            print DST save_data_replace($tpl{'COMMENT_MAIN_HEAD'}, \%tpl, \%usr_log, \%cookie);
            # 記事下側部分の置換処理＆書出先へ出力
            print DST save_data_replace($tpl{'COMMENT_MAIN_FOOT'}, \%tpl, \%usr_log, \%cookie);
            # 読込ログをクリア
            undef %usr_log;
        }
        # ログファイルを閉じる
        close(SRC);
    }

    # メイン・フッタを書出先へ出力
    print DST $tpl{'MAIN_FOOT'};
    # 書出先HTMLを閉じる
    close(DST);
}

# HTMLヘッダ出力関数
sub out_html_header
{
    my($extend_strings_ref) = @_;

    # ヘッダ出力
    &out_header(\("text/html"), $extend_strings_ref);
}


# ヘッダ出力関数
sub out_header
{
    my($mime_type_ref, $extend_strings_ref) = @_;

    unless(length($$mime_type_ref)) {
        $$mime_type_ref = \("text/html");
    }

    print STDOUT "Content-type: $$mime_type_ref", "\n";
    print STDOUT "Pragma: no-cache", "\n";
    print STDOUT "Cache-Control: no-cache", "\n";

    # 拡張文字列はあるか？
    if(length($$extend_strings_ref)) {
        # 拡張文字列を出力
        print STDOUT $$extend_strings_ref, "\n";
    }

    # 改行を出力
    print STDOUT "\n";
}


# HTMLテンプレート表示（単純／簡素）
sub show_view
{
    my($in_ref, $tpl_html_ref, $usr_cfg_ref, $cookie_ref) = @_; # sub関数用の引数取得
    my($error, %cookie, $tmp, $i, $j);

    # クッキー指定なしか？
    if($k_cookie_enable) {
        if(!($cookie_ref)) {
            # なし：
            $cookie_ref = \%cookie;
            # クッキーの取得
            &get_cookie($k_CGI_INFO_ref->{'COOKIE_AUTHOR'}, $cookie_ref);
        }
    }

    # tpl_htmlをセットアップ
    &setup_tpl_html($in_ref, $tpl_html_ref, $usr_cfg_ref, $cookie_ref);

    # クッキーを保存
    if($k_cookie_enable) {
        &set_cookie($k_CGI_INFO_ref->{'COOKIE_AUTHOR'}, $cookie_ref);
    }

    # HTMLヘッダを出力
    &out_html_header();
    # メイン・ヘッダを出力
    print STDOUT $tpl_html_ref->{'MAIN_HEAD'};
    # メイン・フッタを出力
    print STDOUT $tpl_html_ref->{'MAIN_FOOT'};
}

# テンプレート初期化
sub setup_tpl
{
    my($in_ref, $tpl_ref, $usr_cfg_ref, $cookie_ref) = @_; # sub関数用の引数取得

    &setup_tpl_html($in_ref, $tpl_ref, $usr_cfg_ref, $cookie_ref);
}

# HTMLテンプレート初期化
sub setup_tpl_html
{
    my($in_ref, $tpl_html_ref, $usr_cfg_ref, $cookie_ref) = @_; # sub関数用の引数取得
    my($error, $prev, $next, $hash_key, $ret, $chk1, $chk2, $i);

    # エラー情報設定
    my($err_info) = "setup_tpl_html(); ";

    # ハッシュ・キーを取り出す
    foreach $hash_key (sort keys %$tpl_html_ref) {
        # 削除変更禁止 ------------------------------------------------------------------------------ #
        $chk1 += $tpl_html_ref->{$hash_key} =~ s/__%%CGI::(INFOMATION)%%__/$k_CGI_INFO_ref->{$1}/g;
        # ------------------------------------------------------------------------------ 削除変更禁止 #
        # 削除変更禁止 ------------------------------------------------------------------------------ #
        $chk2 += $tpl_html_ref->{$hash_key} =~ s/__%%CGI::(INFOMATION_URL)%%__/$k_CGI_INFO_ref->{$1}/g;
        # ------------------------------------------------------------------------------ 削除変更禁止 #
        # 削除変更禁止 ------------------------------------------------------------------------------ #
        $tpl_html_ref->{$hash_key} =~ s/__%%CGI::(.+?)%%__/$k_CGI_INFO_ref->{$1}/g;
        # ------------------------------------------------------------------------------ 削除変更禁止 #
        # 単純データ置換え文字列（ __%%keyword::property%%__ ）の処理
        for($i = 0; $i < $usr_cfg_ref->{'id-Nums'}; $i++) {
            # データ判別型特別置換文字列（ ==%%コンフィグ名::PROPERTY%%== ）の処理
            $tpl_html_ref->{$hash_key} =~ s/==%%($usr_cfg_ref->{'id-'.$i})::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$usr_cfg_ref->{$usr_cfg_ref->{'id-'.$i}."-".$2})/ge;
            # 単純データ置換え文字列（ __%%$usr_cfg_ref->{'id-'.$i}::property%%__ ）の処理
            $tpl_html_ref->{$hash_key} =~ s/__%%($usr_cfg_ref->{'id-'.$i})::(.+?)%%__/$usr_cfg_ref->{$1.'-'.$2}/g;
        }
        # データ判別型特別置換文字列（ ==%%G_IN::PROPERTY%%== ）の処理
        $tpl_html_ref->{$hash_key} =~ s/==%%(G_IN)::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$in_ref->{$2})/ge;
        # 単純データ置換え文字列（ __%%G_IN::PROPERTY%%__ ）の処理
        $tpl_html_ref->{$hash_key} =~ s/__%%G_IN::(.+?)%%__/$in_ref->{$1}/g;

        # クッキーデータ置換処理
        $tpl_html_ref->{$hash_key} =~ s/__%%CLIENT_COOKIE::(.+?)%%__/&cookie_data_replace($cookie_ref, $1)/ge;

    }
    # 削除変更禁止 ------------------------------------------------------------------------------------------------------------------------------------ #
    if(!($chk1)) {
        # 駄目
        $error .= " [ __%%CGI::INFOMATION%%__ ]";
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ 削除変更禁止 #
    # 削除変更禁止 ------------------------------------------------------------------------------------------------------------------------------------ #
    if(!($chk2)) {
        # 駄目
        $error .= " [ __%%CGI::INFOMATION_URL%%__ ]";
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ 削除変更禁止 #
    # 削除変更禁止 ------------------------------------------------------------------------------------------------------------------------------------ #
    if(length($error)) {
        # 駄目
        &$k_error_func_ref($err_info."置換え文字列 $error が足りません。$chk1, $chk2");
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ 削除変更禁止 #
    # 削除変更禁止 ------------------------------------------------------------------------------------------------------------------------------------ #
    if(!($chk1 == $chk2)) {
        # 駄目
        &$k_error_func_ref($err_info."置換え文字列 [ __%%CGI::INFOMATION%%__ ] [ __%%CGI::INFOMATION_URL%%__ ] の数が合いません。ERR = $chk1, $chk2", 1);
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ 削除変更禁止 #
}


# 記事データ置換
sub save_data_replace
{
    my($ret, $tpl_html_ref, $save_data_ref, $cookie_ref) = @_; # sub関数用の引数取得

    # データ判別型特別置換文字列（ ==%%keyword::property%%== ）の処理
    $ret =~ s/==%%(SAVE)::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$save_data_ref->{$2}, $cookie_ref)/ge;
    # 単純データ置換え文字列（ __%%keyword::property%%__ ）の処理
    $ret =~ s/__%%SAVE::(.+?)%%__/$save_data_ref->{$1}/g;
    # `結果を返す
    return $ret;
}

# 記事データ置換（キー有）
sub save_data_replace_with_key
{
    my($ret, $tpl_html_ref, $save_data_ref, $cookie_ref, $key) = @_; # sub関数用の引数取得

    # データ判別型特別置換文字列（ ==%%keyword::property%%== ）の処理
    $ret =~ s/==%%(SAVE)::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$save_data_ref->{$key."-".$2}, $cookie_ref)/ge;
    # 単純データ置換え文字列（ __%%keyword::property%%__ ）の処理
    $ret =~ s/__%%SAVE::(.+?)%%__/$save_data_ref->{$key."-".$1}/g;
    # `結果を返す
    return $ret;
}

# ==%%keyword::property%%== の置換文字列の処理
sub special_replace
{
    my($key, $pty, $tpl_html_str, $data_str_ref, $cookie_ref) = @_; # sub関数用の引数取得

    # 定義されているのか？
    if($$data_str_ref && !($$data_str_ref eq $cookie_ref->{'default-'.$pty})) {
        # なんらかの定義があれば置換する
        $tpl_html_str =~ s/__%%($key)::($pty)%%__/$$data_str_ref/g;
        # 処理結果を返す
        return $tpl_html_str;
    } else {
        # 何もしない（つまり空白）
        return;
    }
}

# クッキーデータ置換処理
sub cookie_data_replace
{
    my($in_ref, $cookie_ref, $property) = @_; # sub関数用の引数取得
    my($p_name, $p_value);

    # 有効？
    if($k_cookie_enable) {
        # プロパティをプロパティ名とプロパティ値に分解
        ($p_name, $p_value) = split(/=/, $property);
        # 暗号化前の入力フォームの中に対応するプロパティはあるか？
        if(exists $in_ref->{'src-'.$p_name}) {
            # ある：フォームからプロパティをセット
            $cookie_ref->{$p_name} = $in_ref->{'src-'.$p_name};
        # 入力されたフォームの中に対応するプロパティはあるか？
        } elsif(exists $in_ref->{$p_name}) {
            # ある：フォームからプロパティをセット
            $cookie_ref->{$p_name} = $in_ref->{$p_name};
        } else {
            # ない：プロパティに対するクライアントのクッキーはあるか？
            if(exists $cookie_ref->{$p_name}) {
                # ある：
            } else {
                # ない：デフォルトの設定値は，あるのか？
                if(length($p_value)) {
                    # ある：デフォルト値をセット
                    $cookie_ref->{$p_name} = $p_value;
                } else {
                    # ない：空白をセット
                    $cookie_ref->{$p_name} = "";
                }
            }
        }
        # デフォルト値があれば値を保存（入力フォームとの比較の為）
        if($p_value) {
            $cookie_ref->{'default-'.$p_name} = $p_value;
        }
        # 値を返す
        return $cookie_ref->{$p_name};
    }
}

# クッキーを取得
sub get_cookie
{
    my($cookie_author, $cookie_ref) = @_; # sub関数用の引数取得
    my($c_author, $c_str);
    my($c_it_name, $c_it_value);

    # クッキーを取得して分解
    for(split(/;/, $ENV{'HTTP_COOKIE'})) {
        ($c_author, $c_str) = split(/=/, $_);
        $c_author =~ s/\s//g;
        if($c_author eq $cookie_author) { last; }
    }
    # クッキー中身を分解して値をセット
    for(split(/,/, $c_str)) {
        ($c_it_name, $c_it_value) = split(/$k_sep/, $_);
        $cookie_ref->{$c_it_name} = $c_it_value;
    }
}

# クッキーを発行（$extra_stringsはそのまま反映されるので書式を整えておくこと [hogehoge=damydamy;]）
sub set_cookie
{
    my($coockie_author, $cookie_ref, $extra_strings) = @_; # sub関数用の引数取得
    my($cookie_str, $key, $secg, $ming, $hourg, $mdayg, $mong, $yearg, $wdayg, $ydayg, $isdstg, @mong, @weekg, $date_gmt);

    # クッキーは国際時間をキーとし、保存日数は60日間
    ($secg, $ming, $hourg, $mdayg, $mong, $yearg, $wdayg, $ydayg, $isdstg) = gmtime(time + 60 * 24 * 60 * 60);
    # 曜日と週を配列で定義
    @mong  = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
    @weekg = ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    # 60日後の国際時間を指定フォーマット化
    $date_gmt = sprintf("%s, %02d\-%s\-%04d %02d\:%02d\:%02d GMT", $weekg[$wdayg], $mdayg, $mong[$mong], $yearg+1900, $hourg, $ming, $secg);
    # 保存するクッキー情報を生成
    foreach $key (sort keys %$cookie_ref) {
        # デフォルト値をスキップ
        if($key =~ /default-(.+?)/) {
            next;
        }
        # クッキー文字列へ追加
        $cookie_str .= "$key"."$k_sep"."$cookie_ref->{$key}".",";
    }
    # 不要な最後の[,]を削除
    chop($cookie_str);

    # クッキーの標準フォーマットに整えます。
    print STDOUT "Set-Cookie: $coockie_author=$cookie_str; $extra_strings expires=$date_gmt;\n";
}


# クッキーを発行（一時的：期限指定無：$extra_stringsはそのまま反映されるので書式を整えておくこと [hogehoge=damydamy;]）
sub set_cookie_only_once
{
    my($coockie_author, $cookie_ref, $extra_strings) = @_; # sub関数用の引数取得
    my($cookie_str, $key);

    # 保存するクッキー情報を生成
    foreach $key (sort keys %$cookie_ref) {
        # デフォルト値をスキップ
        if($key =~ /default-(.+?)/) {
            next;
        }
        # クッキー文字列へ追加
        $cookie_str .= "$key"."$k_sep"."$cookie_ref->{$key}".",";
    }
    # 不要な最後の[,]を削除
    chop($cookie_str);
    # クッキーの標準フォーマットに整えます。
    print STDOUT "Set-Cookie: $coockie_author=$cookie_str; $extra_strings\n";
}


# データ暗号化
sub encrypt_data
{
    my($src_data_ref) = @_; # sub関数用の引数取得
    my(@SALT, $salt, $enc_data);

    # 乱数初期化処理
    srand;
    # 乱数発生の為の種リストを作成
    @SALT = ('a'..'z', 'A'..'Z', '0'..'9', '.', '/');
    # 種リストで乱数を発生させて暗号化用の種を生成
    $salt = $SALT[int(rand(@SALT))] . $SALT[int(rand(@SALT))];
    # 暗号化したパスワードを生成
    $enc_data = crypt($$src_data_ref, $salt) || crypt ($$src_data_ref, '$1$' . $salt);
    # 暗号化した文字を元変数へ代入
    $$src_data_ref = $enc_data;
}

# 暗号データ照合処理（ 一致 = 1, 不一致 = 0 ）
sub decrypt_data
{
    my($src_data, $enc_data) = @_; # sub関数用の引数取得
    my($salt, $key);

    # 種を取得
    $salt = $enc_data =~ /^\$1\$(.*)\$/ && $1 || substr($enc_data, 0, 2);
    # パスワードを照合
    if (crypt($src_data, $salt) eq "$enc_data" || crypt($src_data, '$1$' . $salt) eq "$enc_data") {
        # 一致
        return 1;
    } else {
        # 不一致
        return 0;
    }
}

#  時間の取得
sub get_time
{
    my($sec, $min, $hour, $mday, $mon, $year, $wday, $isdst, $week, $date);

    $ENV{'TZ'} = "JST-9";
    ($sec, $min, $hour, $mday, $mon, $year, $wday, $isdst) = localtime(time);
    $year += 1900;
    $mon++;
    if($mon < 10) {
        $mon  = "0$mon";
    }
    if($mday < 10) {
        $mday = "0$mday";
    }
    if($hour < 10) {
        $hour = "0$hour";
    }
    if($min < 10) {
        $min  = "0$min";
    }
    if($sec < 10) {
        $sec  = "0$sec";
    }
    # 曜日テーブル作成
    $week = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')[$wday];
    # 日時のフォーマット
    $date = "$year\/$mon\/$mday($week) $hour\:$min\:$sec";  # 秒あり
    # 値を返す
    return $date;
}

# ディスク空容量チェック（0 = OK, 1 = 容量不足, 2 = 処理エラー）
sub check_disk_availability
{
    my($check_size, $quota_path_ref) = @_; # sub関数用の引数取得
    my($err, $size_availability) = 0;

    # 値は 1 以上か？
    unless($check_size > 0) {
        # 違う：チェック無
        return $err;
    }

    # プログラムパスはあるか？
    unless($quota_path_ref) {
        $quota_path_ref = \$k_quota_path;
    }

    # 空き容量を取得
    if(0 <= ($size_availability = &get_disk_availability())) {
        # 空き容量は十分か？
        if($size_availability < $check_size) {
            # 容量不足
            $err = 1;
        }
    } else {
        # エラー：空き容量を取得できません
        $err = 2;
    }
    return $err;
}

# ディスク空容量の取得
sub get_disk_availability
{
    use Cwd;
    use Quota;

    #カレントのマウントポイントを取得
    my($wd) = Cwd::getcwd();
    my(@s_wd) = split(/\//,$wd);
    my($mp) = "\/"."$s_wd[1]";

    #quotaの値を取得
#    my($device) = Quota::getdev($mp);
    my($device) = Quota::getqcarg($mp);
    my(@wuid) = getpwuid($>);
    my(@prog_out_u) = Quota::query($device,$wuid[2],0);
    my(@prog_out_g) = Quota::query($device,$wuid[3],1);

      # 制限無しか？
      if($prog_out_u[2] == '0') {
        # 各サイズを取得
        my($blocks_g) = $prog_out_g[0];
        my($quota_g) = $prog_out_g[2];
        # 制限無し：webに容量配分された値を元に空き容量を計算して返す
        return (${quota_g} - ${blocks_g});
    }else{
        # 各サイズを取得
        my($blocks_u) = $prog_out_u[0];
        my($quota_u) = $prog_out_u[2];
        # 制限あり：adminのweb使用可能容量を元に空き容量を計算して返す
        return (${quota_u} - ${blocks_u});
    }
}

# ロックファイル開始
# $lock_type : lockWithOpen = 0, lockWithSym = 1
sub lock_start
{
    my($lock_file, $lock_type, $retry) = @_; # sub関数用の引数取得
    my($error) = "lock_start(); lockWithSym エラー";

    # リトライの回数指定はあるか？
    if(!($retry)) {
        # 省略時は，3回
        $retry = 3;
        # リトライサイクルは，高速モードか？
        if($k_lock_fast_cycle) {
            # リトライ回数を4倍する
            $retry *= 4;
        }
    }
    # 1分以上古いロックは削除する
    if(-e $lock_file) {
        # ファイルの作成された時間を取得
        my($mtime) = (stat($lock_file))[9];
        # 一分以上古いファイルなのか？
        if($mtime < time - 60) {
            # ロックを解除
            &lock_end($lock_file);
        }
    }
    # ファイル無になるまでリトライ回数分繰り返し分実行する
    while(-e $lock_file) {
        # ある：リトライサイクルは，高速モードか？
        # リトライ回数範囲内か？
        if(--$retry <= 0) {
            # リトライ回数を超えた：ファイル作成失敗
            return $error;
        }
        # リトライサイクルは，高速モードか？
        if($k_lock_fast_cycle) {
            # より早いサイクルでリトライを実行させます
            select(undef, undef, undef, 0.25);
        } else {
            # セーフモード
            sleep(1);
        }
    }
    # ロックファイルの種類は？
    if($lock_type == 1) {
        # リンク作成
        symlink(".", $lock_file) or return $error;
    } else {
        # ロックファイルを作成
        open(LOCK, ">$lock_file") or return $error;
        close(LOCK);
    }
    # 処理結果を返す
    return;
}

# ロックファイル終了
sub lock_end
{
    my($lock_file) = @_; # sub関数用の引数取得

    # ロックファイルはあるか？
    if(-e $lock_file) {
        # ある：ロックファイルを削除
        unlink($lock_file);
    }
}

# 任意のハッシュの一覧を出力（テスト用）
sub testHashOut
{
    my($comment, $hash) = @_;
    my($key);

    if($k_debug) {

        print DEBUG "\n<--- end of Test Hash Out ($comment) --->\n\n";

        print DEBUG "key = value\n";
        print DEBUG "--------------------------------------------------------\n";
        foreach $key (sort keys %$hash) {
            print DEBUG "$key = $hash->{$key}\n";
        }
        print DEBUG "--------------------------------------------------------\n";

        print DEBUG "\n--- end of Test Hash Out ($comment) --->\n\n";
    }
}

# 以下，情報の変更・削除を禁じます --------------------------------------------------------------------- #
$CGI{'TITLE'}           = "tk_util4.pl";
$CGI{'COPYRIGHT'}       = "Copyright(C) T.Kamitaki 2001";
$CGI{'COPYRIGHT_URL'}   = "";
$CGI{'VERSION'}         = "Ver. 4.00";
$CGI{'REVISION'}        = '$Revision: 3.2 $';
$CGI{'REVISION'}        =~ s/^\D*(\d+\.\d+)\D*$/$1/;
$CGI{'PROG_BY'}         = "Tomonori Kamitaki";
$CGI{'PROG_MAIL'}       = "info\@t-square.jp";
$CGI{'INFOMATION'}      = "";
$CGI{'INFOMATION_URL'}  = "";
$CGI{'SUPPORT_MAIL'}    = "";
# --------------------------------------------------------------------------------------------- ここまで #

# EOF
1;
