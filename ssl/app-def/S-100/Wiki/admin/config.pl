#! /usr/bin/env perl
$| = 1;

# Pukiwiki設定CGI
# config.pl Version 1.0.0
# Copyright(C) NTTPC Communications, Inc. 2009

use strict;
use warnings;
use utf8;
use Encode;
use Fcntl qw(:flock);
use Digest::MD5 qw/md5_hex/;

#---
# 変数設定
#---
my $DATA_FILE = '../pukiwiki.ini.php'; # 設定ファイル
my $FILE_ENCODE = 'UTF-8'; # 設定ファイル文字コード


my $URL_MANUAL = "./manual.html";
my $URL_RETURN = "./index.html";

my $HTML_TITLE       = 'PukiWikiの設定';
my $HTML_MANUAL      = "オンラインマニュアル";
my $HTML_HEADTILTE   = "PukiWiki：設定";
my $HTML_RETURN      = "管理メニューへ戻る";
my $HTML_SUCCESS     = "設定完了";
my $HTML_SUCCESSMESS = "設定の変更が完了しました。";
my $HTML_ERROR       = "エラー";
my $HTML_COMMENT     = "* 印があるものは必須設定項目です。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>各設定のタイトルをクリックするとマニュアルを参照できます。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
my $HTML_SUBMIT      = "設定";

# データ種別 / エラーメッセージ
my $DATA_ANY       =  1; # 全て
my $DATA_ALPHA     =  2; # 半角英
my $DATA_ALNUM     =  3; # 半角英数
my $DATA_NUM       =  4; # 半角数字
my $DATA_ONEBYTE   =  5; # 半角
my $DATA_COLOR     =  6; # #000000形式の色指定
my $DATA_URL       =  7; # http://で始まるURL
my $DATA_MAIL      =  8; # メールアドレス
my $DATA_SIZE      =  9; # 半角数字+px
my $DATA_FLG1      = 10; # 0 or 1
my $DATA_FLG2      = 11; # 0 or 1 or 2
my $DATA_FLG3      = 12; # 1 or 2
my $DATA_FLG4      = 13; # 10 or 12
my $DATA_NQUOT     = 14; # 括りなし
my $DATA_SQUOT     = 15; # ''括り
my $DATA_DQUOT     = 16; # ""括り
my $DATA_ARRAY     = 17; # ()括り
my $DATA_PASSWORD  = 18; # パスワード用
my $DATA_NECESSARY = 19; # 必須項目エラー用
my $DATA_MINERROR  = 20; # 最小文字数エラー用
my $DATA_MAXERROR  = 21; # 最大文字数エラー用
my $DATA_MINMAXNUM = 22; # 半角数字範囲値エラー
my $DATA_MINNUMERROR = 23; # 半角数字最小値エラー用
my $DATA_MAXNUMERROR = 24; # 半角数字最大値エラー用
my %VALIDATEERROR_MESSAGE = (
   $DATA_ALPHA     => "半角英字のみ利用できます。",
   $DATA_ALNUM     => "半角英数字のみ利用できます。",
   $DATA_NUM       => "半角数字のみ利用できます。",
   $DATA_ONEBYTE   => "半角のみ利用できます。",
   $DATA_COLOR     => "色指定は #000000 形式で入力する必要があります。",
   $DATA_URL       => "URL形式で入力する必要があります。",
   $DATA_MAIL      => "メールアドレス形式で入力する必要があります。",
   $DATA_SIZE      => "サイズ指定は 半角数字+px 形式で入力する必要があります。",
   $DATA_FLG1      => "半角の 0 または 1 以外は指定できません。",
   $DATA_FLG2      => "半角の 0 または 1 または 2 以外は指定できません。",
   $DATA_FLG3      => "半角の 1 または 2 以外は指定できません。",
   $DATA_FLG4      => "半角の 10 または 12 以外は指定できません。",
   $DATA_NQUOT     => "「&quot;」「&#39;」「;」を含む文字は設定できません。",
   $DATA_SQUOT     => "「&#39;」を含む文字は設定できません。",
   $DATA_DQUOT     => "「&quot;」を含む文字は設定できません。",
   $DATA_ARRAY     => "「(」及び「)」を含む文字は設定できません。",
   $DATA_NECESSARY => "入力必須項目です。",
   $DATA_MINERROR  => "文字以上で設定する必要があります。",
   $DATA_MAXERROR  => "文字以内で設定する必要があります。",
   $DATA_MINNUMERROR => "以上の数字で設定する必要があります。",
   $DATA_MAXNUMERROR => "以下の数字で設定する必要があります。",
);

# フォーム大項目種別定義(表示順)
my $FORM_ADMIN      = 0;
my $FORM_ATTACHED   = 1;
my $FORM_SPAM       = 2;

# エラーメッセージ
my $ERROR_READ_DATA_FILE  = 0;
my $ERROR_WRITE_DATA_FILE = 1;
my %ERROR_MESSAGE = (
   $ERROR_READ_DATA_FILE  => "設定ファイル( $DATA_FILE )が読み込めませんでした。",
   $ERROR_WRITE_DATA_FILE => "設定ファイル( $DATA_FILE )に書き込みできませんでした。",
);

# フォーム大項目定義
# 表示順 => [大項目種別, マニュアルへのリンクURL]
my $FORM_MAP_TITLE = 0;
my $FORM_MAP_URL   = 1;
my %FORM_VALIDATION_MAP = (
   $FORM_ADMIN      => ["全体設定", "$URL_MANUAL#configtitle_admin"],
);

# 設定項目定義
# 項目名 => [大項目種別, 表示順, データ種別, 最小文字数, 最大文字数, フォームサイズ, フォームタイトル, フォーム説明]
my $MAP_FORM  =  0;
my $MAP_SORT  =  1;
my $MAP_TYPE  =  2;
my $MAP_MIN   =  3;
my $MAP_MAX   =  4;
my $MAP_FLEN  =  5;
my $MAP_TITLE =  6;
my $MAP_HINT  =  7;
my %DATA_VALIDATION_MAP = (
    "modifier"        => [$FORM_ADMIN, 1,  $DATA_ANY,       1, 256,  50,  "管理者の名前", "管理者の名前を指定します。"],
    "adminpass"       => [$FORM_ADMIN, 2,  $DATA_PASSWORD,  0, 256,  50,  "管理者パスワード", "管理者パスワードを変更します。<br>空白を指定した場合は、パスワードは変更されません。<br>MD5による暗号化したパスワードで保存されます。"],
    "modifierlink"    => [$FORM_ADMIN, 3,  $DATA_ANY,       1, 256,  50,  "管理者のサイトURL", "管理者のサイトのURLを指定します。"],
    "defaultpage"     => [$FORM_ADMIN, 4,  $DATA_ANY,       1, 256,  50,  "トップページの名前", "トップページの名前を指定します。"],
    "page_title"      => [$FORM_ADMIN, 5,  $DATA_ANY,       1, 256,  50,  "サイトのタイトル", "ブラウザのタイトルバーに表示される名前を指定します。"],
);

my $DOC_TYPE = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">';
my $CHARSET = 'UTF-8';
my $BINMODE = ':utf8';
my $SUBMIT_NAME = 'submit';
my $CRLF = "\x0D\x0A";
#---


my %DATA_MAP = ();
my %DATATYPE_MAP = ();
my @ERR_MSGS = ();

#---
sub init {
    binmode(STDOUT, $BINMODE);
}

#---
sub get_request_method {
    return $ENV{'REQUEST_METHOD'};
}

#---
sub get_request_uri {
    return $ENV{'REQUEST_URI'};
}

#---
# 改行処理
#---
sub regularize_new_line($) {
    my $data = shift;
    my @arr = split /\n/, $data;
    return join $CRLF, @arr;
}

#---
# 禁止文字確認("';)
#---
sub is_nquot($) {
    my $data = shift;
    return $data =~ /["';]/ ? !undef : undef;
}

#---
# 禁止文字確認(')
#---
sub is_squot($) {
    my $data = shift;
    return $data =~ /[']/ ? !undef : undef;
}

#---
# 禁止文字確認(")
#---
sub is_dquot($) {
    my $data = shift;
    return $data =~ /["]/ ? !undef : undef;
}

#---
# 禁止文字確認(())
#---
sub is_array($) {
    my $data = shift;
    return $data =~ /[\(]|[\)]/ ? !undef : undef;
}

#---
# 禁止文字確認(半角英字のみ)
#---
sub is_alpha($) {
    my $data = shift;
    return $data =~ /^[A-Za-z]+$/ ? !undef : undef;
}

#---
# 禁止文字確認(半角英数字のみ)
#---
sub is_alnum($) {
    my $data = shift;
    return $data =~ /^[A-Za-z0-9]+$/ ? !undef : undef;
}

#---
# 禁止文字確認(半角数字のみ)
#---
sub is_num($) {
    my $data = shift;
    return $data =~ /^[0-9]+$/ ? !undef : undef;
}

#---
# 禁止文字確認(半角数字のみ)
#---
sub is_onebyte($) {
    my $data = shift;
    return $data =~ /^[ -~｡-ﾟ]*$/ ? !undef : undef;
}

#---
# 禁止文字確認(#000000形式)
#---
sub is_color($) {
    my $data = shift;
    return $data =~ /^#[0-9A-Fa-f]{6}/ ? !undef : undef;
}

#---
# 禁止文字確認(URL形式)
#---
sub is_url($) {
    my $data = shift;
    return $data =~ /^https?:\/\/[-_.!~*'()\w;\/?:@&=+\$,%#]+$/ ? !undef : undef;
}

#---
# 禁止文字確認(メールアドレス形式)
#---
sub is_mail($) {
    my $data = shift;
    return $data =~ /^[A-Za-z].*@[\.-_A-Za-z0-9].+\.[A-Za-z]+$/ ? !undef : undef;
}

#---
# 禁止文字確認(数字+px)
#---
sub is_size($) {
    my $data = shift;
    return $data =~ /^[0-9]+(px)$/ ? !undef : undef;
}

#---
# 禁止文字確認(0 or 1)
#---
sub is_flg1($) {
    my $data = shift;
    return $data =~ /^[0-1]$/ ? !undef : undef;
}

#---
# 禁止文字確認(0 or 1 or 2)
#---
sub is_flg2($) {
    my $data = shift;
    return $data =~ /^[0-2]$/ ? !undef : undef;
}

#---
# 禁止文字確認(1 or 2)
#---
sub is_flg3($) {
    my $data = shift;
    return $data =~ /^[1-2]$/ ? !undef : undef;
}

#---
# 禁止文字確認(10 or 12)
#---
sub is_flg4($) {
    my $data = shift;
    return $data =~ /^(10|12)$/ ? !undef : undef;
}

#---
# 入力項目の妥当性チェック
# エラー時は@ERR_MSGSにpush
#---
sub validate_data($$) {
    my $key = shift;
    my $val = shift;

    my $val_len = length $val;
    my $data_type = $DATA_VALIDATION_MAP{$key}->[$MAP_TYPE];
    my $min_len = $DATA_VALIDATION_MAP{$key}->[$MAP_MIN];
    my $max_len = $DATA_VALIDATION_MAP{$key}->[$MAP_MAX];
    my $title = $DATA_VALIDATION_MAP{$key}->[$MAP_TITLE];

    # 共通禁止文字関連
    if ($DATATYPE_MAP{$key} eq $DATA_NQUOT) {
        if (&is_nquot($val)) {
            push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_NQUOT}";
            return undef;
        }
    } elsif ($DATATYPE_MAP{$key} eq $DATA_SQUOT) {
        if (&is_squot($val)) {
            push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_SQUOT}";
            return undef;
        }
    } elsif ($DATATYPE_MAP{$key} eq $DATA_DQUOT) {
        if (&is_dquot($val)) {
            push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_DQUOT}";
            return undef;
        }
    } elsif ($DATATYPE_MAP{$key} eq $DATA_ARRAY) {
        if (&is_array($val)) {
            push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_ARRAY}";
            return undef;
        }
    }

    # 文字数関連
    if ($data_type eq $DATA_MINMAXNUM) {
        unless (&is_num($val)) {
            push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_NUM}";
            return undef;
        } elsif ($val < $min_len) {
            push @ERR_MSGS, "$title : $min_len $VALIDATEERROR_MESSAGE{$DATA_MINNUMERROR}";
            return undef;
        } elsif ($val > $max_len) {
            push @ERR_MSGS, "$title : $max_len $VALIDATEERROR_MESSAGE{$DATA_MAXNUMERROR}";
            return undef;
        }
    } elsif ($val_len == 0 && $min_len != 0) {
        push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_NECESSARY}";
        return undef;
    } elsif ($val_len < $min_len) {
        push @ERR_MSGS, "$title : $min_len $VALIDATEERROR_MESSAGE{$DATA_MINERROR}";
        return undef;
    } elsif ($val_len > $max_len) {
        push @ERR_MSGS, "$title : $max_len $VALIDATEERROR_MESSAGE{$DATA_MAXERROR}";
        return undef;
    }

    # 項目別妥当性
    if ($val_len != 0) {
        if ($data_type eq $DATA_ALPHA) {
            unless (&is_alpha($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_DQUOT}";
                return undef;
            }
        } elsif ($data_type eq $DATA_ALNUM) {
            unless (&is_alnum($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_ALNUM}";
                return undef;
            }
        } elsif ($data_type eq $DATA_NUM) {
            unless (&is_num($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_NUM}";
                return undef;
            }
        } elsif ($data_type eq $DATA_ONEBYTE) {
            unless (&is_onebyte($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_ONEBYTE}";
                return undef;
            }
        } elsif ($data_type eq $DATA_COLOR) {
            unless (&is_color($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_COLOR}";
                return undef;
            }
        } elsif ($data_type eq $DATA_URL) {
            unless (&is_url($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_URL}";
                return undef;
            }
        } elsif ($data_type eq $DATA_MAIL) {
            unless (&is_mail($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_MAIL}";
                return undef;
            }
        } elsif ($data_type eq $DATA_SIZE) {
            unless (&is_size($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_SIZE}";
                return undef;
            }
        } elsif ($data_type eq $DATA_FLG1) {
            unless (&is_flg1($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_FLG1}";
                return undef;
            }
        } elsif ($data_type eq $DATA_FLG2) {
            unless (&is_flg2($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_FLG2}";
                return undef;
            }
        } elsif ($data_type eq $DATA_FLG3) {
            unless (&is_flg3($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_FLG3}";
                return undef;
            }
        } elsif ($data_type eq $DATA_FLG4) {
            unless (&is_flg4($val)) {
                push @ERR_MSGS, "$title : $VALIDATEERROR_MESSAGE{$DATA_FLG4}";
                return undef;
            }
        }
    }

    return !undef;
}

#---
# POSTデータの妥当性チェック
#---
sub validate_post_data {
    for (sort keys %DATA_VALIDATION_MAP) {
        my $key = $_;
        my $data = $DATA_MAP{$key};
        if (defined $key && defined $data) {
            &validate_data($key, $data);
        }
    }
}

#---
# HTML入力フォーム生成
#---
sub make_form_data {
    my $retval = '';
    for (sort {$a <=> $b} keys %FORM_VALIDATION_MAP) {
        my $form_type = $_;
        my $form_title = $FORM_VALIDATION_MAP{$_}->[$FORM_MAP_TITLE];
        my $form_url = $FORM_VALIDATION_MAP{$_}->[$FORM_MAP_URL];
        $retval .= <<EOF;
                  <tr>
                    <th colspan ='2'><a href='$form_url' target='manual'>$form_title</a></th>
                  </tr>
EOF
;
        for (sort {$DATA_VALIDATION_MAP{$a}->[$MAP_SORT] <=> $DATA_VALIDATION_MAP{$b}->[$MAP_SORT]} keys %DATA_VALIDATION_MAP) {
            if ($DATA_VALIDATION_MAP{$_}->[$MAP_FORM] != $form_type) {
                next;
            }
            my $val = $DATA_MAP{$_};
            unless (defined $val) {
                next;
            }
            $val =~ s/&/&amp;/g;
            $val =~ s/"/&quot;/g;
            $val =~ s/</&lt;/g;
            $val =~ s/>/&gt;/g;
            $val =~ s/\0//g;
            $val =~ s/\r\n/<br>/g;
            $val =~ s/\r/<br>/g;
            $val =~ s/\n/<br>/g;

            my $title = $DATA_VALIDATION_MAP{$_}->[$MAP_TITLE];
            if ($DATA_VALIDATION_MAP{$_}->[$MAP_MIN] > 0) {
                $title = "<font class='hissu'>* </font>" . $title;
            }
            my $size = $DATA_VALIDATION_MAP{$_}->[$MAP_FLEN];
            my $hint = $DATA_VALIDATION_MAP{$_}->[$MAP_HINT];
            if ($DATA_VALIDATION_MAP{$_}->[$MAP_TYPE] eq $DATA_PASSWORD) {
                # 種別がパスワード時の特殊処理
                $retval .= <<EOF;
                  <tr>
                    <td nowrap>$title</td>
                    <td><input type="password" size="$size" name="$_" value="$val"><br><div class="att">$hint<br></div>
                  </tr>
EOF
;
            } else {
                $retval .= <<EOF;
                  <tr>
                    <td nowrap>$title</td>
                    <td><input type="text" size="$size" name="$_" value="$val"><br><div class="att">$hint<br></div></td>
                  </tr>
EOF
;
           }
        }
    }

    return $retval;
}

#---
# HTMLエラーメッセージ部生成
#---
sub make_err_msgs {
    my $nr_errs = @ERR_MSGS;
    return '' if $nr_errs == 0;

    my $retval = <<EOF;
              <br>
              <font class='bold-green'>${HTML_ERROR}</font><br>
              <table width="95%" bordercolor="#66bb66" border="1" cellspacing="0" cellpadding="10" bgcolor="#EEFFEE">
                <tr>
                  <td align="center">
                    <table>
EOF
;
    for (@ERR_MSGS) {
        $retval .= <<EOF;
                      <tr>
                        <td><b>$_</b></td>
                      </tr>
EOF
;
    }
    $retval .= <<EOF;
                    </table>
                  </td>
                </tr>
              </table>
              <br>
EOF
;

    return $retval;
}

#---
# HTML共通上部生成
#---
sub make_body_head {
    my $request_uri = &get_request_uri;
    my $body_head = <<EOF;
<html>
  <head>
    <style type='text/css'>
      <!--
      body          {background-color:#FFFFFF; color:#000000;}
      a:link        {color:#0033FF;}
      a:active      {color:#FF3300;}
      a:visited     {color:#666699;}
      a:hover       {color:#FF00FF;}
      a.name        {font-weight:bold;}
      td            {font-size:10pt;}
      th            {font-size:10pt;}
      code          {font-size: 9pt;}
      hr            {color:#66bb66;}
      input.field1  {width:320;}
      input.field2  {width:240;}
      input.field3  {width:160;}
      input.field4  {width:80;}
      textarea      {width:320; height:80;}
      textarea.harf {width:320; height:40;}
      .small-bold   {font-size: 8pt; font-weight:bold; color:#007700;}
      .small        {font-size: 8pt; color: #007700;}
      .bold-green   {font-weight: bold; color:#007700;}
      .att          {font-size:8pt; color: #FF0000;}
      .hissu        {font-size:9pt; color:#FF0000;}
      .nini         {font-size:9pt; color:#007700;}
      .setsumei     {font-size:9pt;}
      -->
    </style>
    <title>${HTML_TITLE}</title>
  </head>
  <body>
    <font face='Osaka, MS UI Gothic' size='2'>
      <center>
        <a name='top'></a>
        <table border='0' cellspacing='0' cellpadding='0' width='560' hspace='0' vspace='0'>
          <tr align='center'>
            <td>
              <table border='0' cellspacing='0' cellpadding='0' width='100%' hspace='0' vspace='0'>
                <tr valign='bottom'>
                  <td><font class='small-bold'>${HTML_HEADTILTE}</font></td>
                  <td align='right'><font class='small-bold'>&nbsp;</font></td>
                </tr>
                <tr>
                  <td align='center' colspan='2'><hr width='100%'></td>
                </tr>
                <tr valign='top'>
                  <td><font class='small-bold'><a href="${URL_MANUAL}" target="manual">${HTML_MANUAL}</a></font></td>
                  <td align='right'><font class='small-bold'>MENU ： <a href='${URL_RETURN}'>${HTML_RETURN}</a></font></td>
                </tr>
              </table>
              <hr width='100%'>
              <br>
              <font class='bold-green'>${HTML_TITLE}</font><br>
              <br>
EOF
;
    return &regularize_new_line($body_head);
}

#---
# HTML共通下部生成
#---
sub make_body_foot {
    my $body_foot = <<EOF;
              <hr width='100%'>
              <table border='0' cellspacing='0' cellpadding='0' width='100%' hspace='0' vspace='0'>
                <tr valign='bottom'>
                  <td><font class='small-bold'>&nbsp;</font></td>
                  <td align='right'><font class='small-bold'><a href='${URL_RETURN}'>${HTML_RETURN}</a></font></td>
                </tr>
                <tr>
                  <td align='center' colspan='2'>
                    <hr width='100%'>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </center>
    </font>
  </body>
</html>
EOF
;
    return &regularize_new_line($body_foot);
}

#---
# HTML中部生成(入力時)
#---
sub make_body_form {
    my $request_uri = &get_request_uri;
    my $err_paragraph = &make_err_msgs;
    my $form_data = &make_form_data;
    my $body_form = <<EOF;
              <br>
${err_paragraph}
              <form action="${request_uri}" method='post' name='config'>
                <div align='right' class='att'>${HTML_COMMENT}</div>
                <table width='95%' bordercolor='#66bb66' border='1' cellspacing='0' cellpadding='10' bgcolor='#EEFFEE'>
${form_data}
                </table><br>
                <input type="submit" name="${SUBMIT_NAME}" value="${HTML_SUBMIT}">
              </form>
EOF
;
    return &regularize_new_line($body_form);
}

#---
# HTML中部生成(致命的エラー時)
#---
sub make_body_error {
    my $err_paragraph = &make_err_msgs;
    my $body_error = <<EOF;
${err_paragraph}
              <font class='small-bold'><a href='${URL_RETURN}'>${HTML_RETURN}</a><br>
EOF
;
    return &regularize_new_line($body_error);
}

#---
# HTML中部生成(完了時)
#---
sub make_body_success {
    my $body_success = <<EOF;
              <br>
              <font class='bold-green'>${HTML_SUCCESS}</font><br>
              <br>
              <table width="95%" bordercolor="#66bb66" border="1" cellspacing="0" cellpadding="10" bgcolor="#EEFFEE">
                <tr>
                  <td align="center">
                    <table>
                      <tr>
                        <td>${HTML_SUCCESSMESS}</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <br>
              <font class='small-bold'><a href='${URL_RETURN}'>${HTML_RETURN}</a><br>
EOF
;
    return &regularize_new_line($body_success);
}

#---
# ヘッダ生成
#---
sub make_head($) {
    my $body = shift;
    my $body_len = bytes::length $body;
    my $head = <<EOF;
Content-type: text/html; charset=${CHARSET}
Content-Length: ${body_len}
EOF
;
    return &regularize_new_line($head);
}

#---
# HTML表示(入力時)
#---
sub print_form {
    my $body = $CRLF . $CRLF . &make_body_head . $CRLF . &make_body_form . $CRLF . &make_body_foot . $CRLF;
    my $head = &make_head($body);
    print $head, $body;
}

#---
# HTML表示(完了時)
#---
sub print_success {
    my $body = $CRLF . $CRLF . &make_body_head . $CRLF . &make_body_success . $CRLF . &make_body_foot . $CRLF;
    my $head = &make_head($body);
    print $head, $body;
}

#---
# HTML表示(致命的エラー時)
#---
sub print_error {
    my $body = $CRLF . $CRLF . &make_body_head . &make_body_error . &make_body_foot . $CRLF;
    my $head = &make_head($body);
    print $head, $body;
}

#---
# POSTデータ解析
#---
sub parse_data {
    my $q_str = <>;
    my @q = split '&', $q_str;
    for (@q) {
        my ($key, $val) = split /=/, $_, 2;
        $key =~ tr/+/ /;
        $key =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("H2", $1)/eg;
        utf8::decode($key);
        $val =~ tr/+/ /;
        $val =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("H2", $1)/eg;
        utf8::decode($val);
            $DATA_MAP{$key} = $val;
#        if (exists($DATA_VALIDATION_MAP{$key})) {
#            $DATA_MAP{$key} = $val;
#        }
    }
}

#---
# 設定ファイルからデータ読み込み
# エラー時は@ERR_MSGSにpush
#---
sub read_data {
    %DATA_MAP = ();
    unless (open(FILE, "< $DATA_FILE")) {
        push @ERR_MSGS, "$ERROR_MESSAGE{$ERROR_READ_DATA_FILE}";
        return undef;
    }
    flock(FILE, LOCK_EX);
    while (<FILE>) {
        chomp;
        $_ = Encode::decode($FILE_ENCODE, $_);
        my ($key, $val) = split /=/, $_, 2;
        if (defined $key && defined $val) {
            $key =~ s/(^\$|^\@)(\S+)\s*/$2/;
            if (exists($DATA_VALIDATION_MAP{$key})) {
                if ($val =~ /^(.*\()([^\)]+)(\);.*)/) {
                    $val =~ s/^(.*\()([^\)]+)(\);.*)$/$2/;
                } elsif ($val =~ /^(.*\()(\);.*)/) {
                    $val = '';
                } elsif ($val =~ /^(.*')([^']+)(';.*)/) {
                    $val =~ s/^(.*')([^']+)(';.*)$/$2/;
                } elsif ($val =~ /^(.*')(';.*)/) {
                    $val = '';
                } elsif ($val =~ /^(.*")([^"]+)(";.*)/) {
                    $val =~ s/^(.*")([^"]+)(";.*)$/$2/;
                } elsif ($val =~ /^(.*")(";.*)/) {
                    $val = '';
                } elsif ($val =~ /^(.* )([^;]+)(;.*)/) {
                    $val =~ s/^(.* )([^;]+)(;.*)$/$2/;
                } else {
                    $val =~ s/^([^;]+)(;.*)$/$1/;
                }
                if ($DATA_VALIDATION_MAP{$key}->[$MAP_TYPE] eq $DATA_PASSWORD) {
                    # 種別がパスワード時の特殊処理
                    $DATA_MAP{$key} = '';
                } else {
                    $DATA_MAP{$key} = $val;
                }
            }
        }
    }
    close(FILE);

    return !undef;
}

#---
# 設定ファイルからデータ種別読み込み
# エラー時は@ERR_MSGSにpush
#---
sub read_datatype {
    %DATATYPE_MAP = ();
    unless (open(FILE, "< $DATA_FILE")) {
        push @ERR_MSGS, "$ERROR_MESSAGE{$ERROR_READ_DATA_FILE}";
        return undef;
    }
    flock(FILE, LOCK_EX);
    while (<FILE>) {
        chomp;
        $_ = Encode::decode($FILE_ENCODE, $_);
        my ($key, $val) = split /=/, $_, 2;
        if (defined $key && defined $val) {
            $key =~ s/(^\$|^\@)(\S+)\s*/$2/;
            if (exists($DATA_VALIDATION_MAP{$key})) {
                if ($val =~ /^(.*\()([^\)]+)(\);.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_ARRAY;
                } elsif ($val =~ /^(.*\()(\);.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_ARRAY;
                } elsif ($val =~ /^(.*')([^']+)(';.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_SQUOT;
                } elsif ($val =~ /^(.*')(';.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_SQUOT;
                } elsif ($val =~ /^(.*")([^"]+)(";.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_DQUOT;
                } elsif ($val =~ /^(.*")(";.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_DQUOT;
                } elsif ($val =~ /^(.* )([^;]+)(;.*)/) {
                    $DATATYPE_MAP{$key} = $DATA_NQUOT;
                } else {
                    $DATATYPE_MAP{$key} = $DATA_NQUOT;
                }
            }
        }
    }
    close(FILE);

    return !undef;
}

#---
# 設定ファイル書き込み
# エラー時は@ERR_MSGSにpush
#---
sub write_data {
    unless (open(FILE, "+< $DATA_FILE")) {
        push @ERR_MSGS, "$ERROR_MESSAGE{$ERROR_WRITE_DATA_FILE}";
        return undef;
    }
    flock(FILE, LOCK_EX);
    my @new_data;
    while (<FILE>) {
        my $line = Encode::decode($FILE_ENCODE, $_);
        for (keys %DATA_VALIDATION_MAP) {
            my $key = $_;
            my $data = $DATA_MAP{$key};

            # 種別がパスワード時の特殊処理
            if ($DATA_VALIDATION_MAP{$key}->[$MAP_TYPE] eq $DATA_PASSWORD) {
                if ($data eq '') {
                    next;
                } else {
                    $data = "{x-php-md5}" . md5_hex($data);
                }
            }

            if ($line =~ /(^\$$key|^\@$key)(\s|=)/) {
                if ($line =~ /^(.*=)(.*\()([^\)]+)(\);.*)/) {
                    $line =~ s/^(.*=)(.*\()([^\)]+)(\);.*)$/$1$2${data}$4/;
                } elsif ($line =~ /^(.*=)(.*\()(\);.*)/) {
                    $line =~ s/^(.*=)(.*\()(\);.*)$/$1$2${data}$3/;
                } elsif ($line =~ /^(.*=)(.*')([^']+)(';.*)/) {
                    $line =~ s/^(.*=)(.*')([^']+)(';.*)$/$1$2${data}$4/;
                } elsif ($line =~ /^(.*=)(.*')(';.*)/) {
                    $line =~ s/^(.*=)(.*')(';.*)$/$1$2${data}$3/;
                } elsif ($line =~ /^(.*=)(.*")([^"]+)(";.*)/) {
                    $line =~ s/^(.*=)(.*")([^"]+)(";.*)$/$1$2${data}$4/;
                } elsif ($line =~ /^(.*=)(.*")(";.*)/) {
                    $line =~ s/^(.*=)(.*")(";.*)$/$1$2${data}$3/;
                } elsif ($line =~ /^(.*= )([^;]+)(;.*)/) {
                    $line =~ s/^(.*= )([^;]+)(;.*)$/$1${data}$3/;
                } else {
                    $line =~ s/^(.*=)([^;]+)(;.*)$/$1${data}$3/;
                }
            }
        }
        my $str = Encode::encode($FILE_ENCODE, $line);
        push(@new_data, $str);
    }
    seek(FILE, 0, 0);
    print FILE @new_data;
    truncate(FILE, tell(FILE));
    close(FILE);

    return !undef;
}

#---
# GET時処理
#---
sub do_get {
    if (&read_data) {
        &print_form;
    } else {
        &print_error;
    }
}

#---
# POST時処理
#---
sub do_post {
    &parse_data;
    unless (&read_datatype) {
        &print_error;
        return undef;
    }
    &validate_post_data;
    my $nr_errs = @ERR_MSGS;
    if ($nr_errs == 0) {
        unless (&write_data) {
            &print_error;
            return undef;
        }
        unless (&read_data) {
            &print_error;
            return undef;
        }
        &print_success;
    } else {
        &print_form;
    }

    return !undef;
}

#---
# メイン処理
#---
sub main {
    &init;
    my $request_method = &get_request_method;
    if ($request_method eq 'GET') {
        &do_get;
    } elsif ($request_method eq 'POST') {
        &do_post;
    } else {
        &do_get;
    }
}

&main;
