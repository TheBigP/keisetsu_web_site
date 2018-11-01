package tk_util4;

# RCS Infomation.
# �ȉ��C���̕ύX�E�폜���ւ��܂� ------------------------------------------------------------------------ #
$CGI{'RCS_ID'}      =  "$Id: tk_util4.pl 3.2 2002/07/11 10:48:13 Administrator Exp Administrator $damy";
$CGI{'RCS_SOURCE'}  =  "$Source: D:/Users/administrator/projects/works/salut/C-S03_tk_util4.pl/RCS/tk_util4.pl $damy";
# ------------------------------------------------------------------------------------------------ �����܂� #
# �ȉ��C���̕ύX�E�폜���ւ��܂� ------------------------------------------------------------------------ #
#
# TK's CGI�T�|�[�g���[�e�B���e�B���C�u����4�Ftk_util4.pl
# Copyright(C) Tomonori Kamitaki 2001
#
# [���p�K������ыK��]
#
#   ���̃v���O�����́C�t���[�E�F�A�ł����C�ȉ��̓_������Ďg�p���ĉ������B
#
#  1. ���̃v���O�������������Ă��ǂ��ł����C���쌠���̔j���͂��Ă���܂���̂ł���Ɋւ���S�Ă̕\�L�����
#     �R�����g�̍폜���֎~���܂��B
#
#  2. �z�z����ꍇ�́C�K���I���W�i���̃t�@�C����Y�t���ĉ������B
#
#  3. ���̃v���O�����̎g�p����щ������@�C�ݒu���@�Ɋւ���T�|�[�g�͒ʐM��i���킸��؍s���Ă���܂���B
#
#  4. ���ׂẴv���o�C�_����œ��삷�鎖�͕ۏ؂��Ă��܂���B
#
#  5. ���v���O�����𗘗p�������ɂ�邢���Ȃ鑹�Q����҂͈�؂̐ӔC�𕉂��܂���B
#
#  6. ��҂ɒ������s���v������Ɣ��f�����ꍇ�ɂ͈���I�Ƀv���O�����̎g�p�𒆎~���Ă����������Ƃ�����܂��B
#
# ------------------------------------------------------------------------------------------------ �����܂� #

# �f�[�^�E�^�C�v
$k_config_a         = 10;
$k_tpl_html         = 20;
$k_tpl              = $k_tpl_html;
$k_csv_data         = 30;
$k_plain_txt        = 40;

# �J���}�����ݒ�i���ʌ݊����p�F�����o�[�W�����ł͔p�~�\��j
$k_cm_char          = ",";
$k_cm_replace_head  = "&[";
$k_cm_replace_foot  = "]";

# �ėp�N�b�L�[�����̃f�t�H���g�ݒ�i0 = off, 1 = on�j
#   �����ŕύX���Ă͍s���܂���B
#   ���C���v���O�����̖{���C�u�����Ǎ���ɐݒ肷��i$tk_util4::g_cookie_enable = 1;���j
$k_cookie_enable = 0;

# �Z�p���[�^������
$k_sep = "<>";

# <BR>�^�O�����i0 = �����C1 = �L���j
$k_br_enable = 0;

# jcode.pl �ւ̃p�X
$k_jcode_pl_path = './share/jcode.pl';

# mimew.pl �ւ̃p�X
$k_mimew_path = './share/mimew.pl';

# nkf�ւ̃p�X
$k_nkf_path = '/usr/local/bin/nkf';

# nkf���{��R�[�h�e�[�u��
$k_jpn_code_nkf_tbl{'jis'}  = '-j';
$k_jpn_code_nkf_tbl{'sjis'} = '-s';
$k_jpn_code_nkf_tbl{'euc'}  = '-e';

# echo�ւ̃p�X
$k_echo_path = '/bin/echo';

# ���[�����M�v���O�����ւ̃p�X�ƃR�}���h�I�v�V����
$k_mail_prog_path = '/usr/lib/sendmail';
$k_mail_prog_opt = '-t -f';

# quota�ւ̃p�X
$k_quota_path = '/usr/bin/quota';

# �G���[�\���֐�
$k_error_func_ref = \&main::error;

# CGI���ϐ��i�n�b�V���j
$k_CGI_INFO_ref = \%main::CGI;

# ���b�N�ɍ������g���C�T�C�N�����[�h���g�p����i ON = 1, OFF = 0 �j
$k_lock_fast_cycle = 1;

# �f�b�o�O�ݒ�i0 = �����C1 = �L���j
$k_debug = 0;

if($k_debug) {
    open(DEBUG, ">./debug_tkutil4.txt") || die "DEBUG FILE ERROR!!";
}

require $k_mimew_path;

# &parseInput()
# <IN>  \%in            = parse�f�[�^���i�[����n�b�V��         ���ȗ��s��
#       $encoding       = �����R�[�h�Fjis|sjis|euc              ���ȗ���
#       $html_tag_flag  = html�^�O�F�L��     = 0                ���ȗ��i���̍ۂ�"1"�̓���j
#                                   <BR>�̂� = 1
#                                   ����     = ��L�ȊO�̐��l
sub parseInput
{
    my($in_ref, $encoding, $html_tag_flag) = @_; # sub�֐��p�̈����擾
    my($query, @query);
    my($key, $val);

    unless(length($html_tag_flag)) {
        $html_tag_flag = 1;
        $k_br_enable = 1;
    }

    # �N�G����"GET"�o�R���H
    if($ENV{'REQUEST_METHOD'} eq 'GET') {
        # Yes�F�N�G�����Z�b�g
        $query = $ENV{'QUERY_STRING'};
    # �N�G����"POST"�o�R���H
    } elsif($ENV{'REQUEST_METHOD'} eq 'POST') {
        # Yes�F�N�G����Ǎ�
        read(STDIN, $query, $ENV{'CONTENT_LENGTH'});
    } else {
        # �G���[�F
        return "error in parseInput()\n";
    }

    # "+" �� " "�i�X�y�[�X�j�֕ϊ�
    $query =~ tr/+/ /;
    # �N�G���������ʏ핶���֕ϊ�
    $query =~ s/%([A-Fa-f0-9][A-Fa-f0-9])/pack("C", hex($1))/gie;

    # ���{��ϊ��L��H
    if($encoding) {
        # �L��F
        &convert_jpn_code(\$query, \$encoding);
    }

    # �N�G���𕪉����Ĉ������
    foreach(split(/&/, $query)) {

        # �L�[�ƒl�iValue�j�ɕ���
        ($key, $val) = split(/=/, $_);

        # HTML������ɏ����镶����ւ̕ϊ��͕K�v���H
        if($html_tag_flag) {
            # �K�v�FHTML������ɏ����镶����ւ̕ϊ�
            &convert_char_std2html(\$val);
        }

        # �l���Z�b�g
        $in_ref->{$key} = $val;
    }
    return 0;
}

# ���{��ϊ������֐�
sub convert_jpn_code
{
    my($val_ref, $encoding_ref) = @_; # sub�֐��p�̈����擾

    # nkf �͂��邩�H
    if(-e $k_nkf_path) {
        # ����F
        &convert_jpn_code_by_nkf($val_ref, $encoding_ref);
    # jcode.pl �͂��邩�H
    } elsif(-e $k_jcode_pl_path) {
        # ����F
        if(\&jcode::convert) {
            require $k_jcode_pl_path;
        }
        &convert_jpn_code_by_jcode($val_ref, $encoding_ref);
    }
}

# ���{��ϊ������֐��i���ʏ풼�ڂ��̊֐������s���܂���Bconvert_jpn_code()�֐����g�p���ĕϊ����s���܂��B�Fnkf���g�p�j
sub convert_jpn_code_by_nkf
{
    my($val_ref, $encoding_ref) = @_; # sub�֐��p�̈����擾

    $$val_ref =~ s/'/'\\''/g;
    open(NKF,"$k_echo_path '$$val_ref' | $k_nkf_path $k_jpn_code_nkf_tbl{$$encoding_ref} |");
    $$val_ref = "";
    while (<NKF>) {
          $$val_ref .= $_;
    }
    close(NKF);
    chop($$val_ref);
}

# ���{��ϊ������֐��i���ʏ풼�ڂ��̊֐������s���܂���Bconvert_jpn_code()�֐����g�p���ĕϊ����s���܂��B�Fjcode.pl���g�p�j
sub convert_jpn_code_by_jcode
{
    my($val_ref, $encoding_ref) = @_; # sub�֐��p�̈����擾

    &jcode::convert(\$val_ref, $$encoding_ref);
}

# �ʏ�̕������HTML�ɏ����镶����ɕϊ����܂��B
sub convert_char_std2html
{
    my($val_ref) = @_; # sub�֐��p�̈����擾

    if($k_br_enable) {
        # <BR>�^�O���ꎞ�I�ɉ��s�ɒu��
        $$val_ref =~ s/<BR>/\n/gi;
    }
    $$val_ref =~ s/</&lt;/g;
    $$val_ref =~ s/>/&gt;/g;
    $$val_ref =~ s/\"/&#34;/g;
    $$val_ref =~ s/\'/&#39;/g;
    $$val_ref =~ s/,/&#44;/g;

    # ���s��u��
    $$val_ref =~ s/\r\n/<BR>/g;
    $$val_ref =~ s/\n/<BR>/g;
    $$val_ref =~ s/\r/<BR>/g;
}

# HTML�ɏ����镶�����ʏ�̕�����ɕϊ����܂��B
sub convert_char_html2std
{
    my($val_ref) = @_; # sub�֐��p�̈����擾

    $$val_ref =~ s/&lt;/</g;
    $$val_ref =~ s/&gt;/>/g;
    $$val_ref =~ s/&#34;/\"/g;
    $$val_ref =~ s/&#39;/\'/g;
    $$val_ref =~ s/&#44;/,/g;
    $$val_ref =~ s/<BR>/\n/gi;
}

# �ݒ�t�@�C���Ǎ��֐�
# $config_file_list_ref = �ǂݍ��ސݒ�t�@�C�����X�g�ւ̃��t�@�����X
# $config_ref           = �ݒ�i�[�n�b�V���z��ւ̃��t�@�����X
# �Ԓl                  = �G���[������F�G���[�����͖���`�l
sub readConfigFile
{
    my($config_file_list_ref, $config_ref) = @_; # sub�֐��p�̈����擾
    my($error);

    for(@$config_file_list_ref) {
        if(&tk_util4::readDataFile($_, $k_config_a, $config_ref)) {
            $error .= '�ݒ�t�@�C���u'.$_.'�v�̓Ǎ��Ɏ��s���܂����B<BR>';
        }
    }
    return $error;
}

# &readDataFile()
# <IN>  $file_name          = �t�@�C����(�p�X�܉�)
#       $data_type          = �Ǎ��f�[�^�̎��( �t�@�C���㕔�Q�� )
#       \($ | @ | %)object  = �f�[�^���i�[����I�u�W�F�N�g( �f�[�^�̎�ނɉ����ĉ� )
#       $extend_property    = �f�[�^�̎�ނɂ��w��
sub readDataFile
{
    my($file_name, $data_type, $data_ref, $extend_property) = @_; # sub�֐��p�̈����擾
    my($id, $saveSeprater) = 0;

    # �����͑���Ă���̂��H
    if(($file_name) && ($data_type) && ($data_ref)) {
        open(IN, "$file_name") || return "readDataFile(); �t�@�C���Ǎ����s $file_name";
        $saveSeprater = $/;
        $/ = "\n";
        # �f�[�^�^�C�v�́C$k_config_a�ł��邩�H
        if($data_type == $k_config_a) {
            $data_ref->{'id-Nums'} = exists $data_ref->{'id-Nums'} ? $data_ref->{'id-Nums'} : 0;
            while(<IN>) {
                $_ =~ s/\r\n/\n/g;
                # ��s�H
                if(length($_) > 1) {
                    # �R�����g�s�H
                    if($_ =~ m/^[^#]/) {
                        # :��`�s�H
                        if($_ =~ m/^:(.+?)\n/) {
                            $id = $1;
                            unless(exists $data_ref->{$id."-id"}) {
                                $data_ref->{"id-".$data_ref->{'id-Nums'}} = $id;
                                $data_ref->{$id."-id"} = $id;
                                $data_ref->{'id-Nums'}++;
                            }
                        } else {
                            # ��`�̓��e�H
                            if($_ =~ m/^(.+?)=((.+?)\n)$/) {
                                $data_ref->{$id."-".$1} = $3;
                            }
                        }
                    }
                }
            }
        # �f�[�^�^�C�v�́C$k_tpl_html�ł��邩�H
        } elsif($data_type == $k_tpl_html) {
            my($len) = 1;
            # �v���p�e�B�͂��邩�H
            if($extend_property) {
                # ������ 1 �ȉ��i���s�j�𖳎����Ȃ�
                $len = 0;
            }
            $data_ref->{'id-Nums'} = exists $data_ref->{'id-Nums'} ? $data_ref->{'id-Nums'} : 0;
            while(<IN>) {
                $_ =~ s/\r\n/\n/g;
                # ��s�H
                if(length($_) > $len) {
                    # �R�����g�s�H
                    if($_ =~ m/^[^#]/) {
                        # :��`�s�H
                        if($_ =~ m/^:(.+?)\n/) {
                            $id = $1;
                        } else {
                            $data_ref->{$id} .= $_;
                        }
                    }
                }
            }
        # �f�[�^�^�C�v�́C$k_csv_data�ł��邩�H
        } elsif($data_type == $k_csv_data) {
            # ��؂蕶���́C���ʎw��ł��邩�H
            if(!($extend_property)) {
                # �ȗ����ݒ�
                $extend_property = ",";
            }
            $data_ref->{'id-Nums'} = exists $data_ref->{'id-Nums'} ? $data_ref->{'id-Nums'} : 0;
            while(<IN>) {
                $_ =~ s/\r\n/\n/g;
                # ��s�H
                if(length($_) > 1) {
                    # �R�����g�s�H
                    if($_ =~ m/^[^#]/) {
                        # :��`�s�H
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

                            # ���ʌ݊����p�F�����o�[�W�����ł͔p�~�\�� ------- #
                            $st1 = quotemeta($k_cm_replace_head);
                            $st2 = quotemeta($k_cm_replace_foot);
                            # ----------------------------------- ���ʌ݊����p #

                            $i = 0;
                            foreach(@csv_item_name) {

                                # ���ʌ݊����p�F�����o�[�W�����ł͔p�~�\�� ------- #
                                $csv_array[$i] =~ s/$st1(.+?)$st2/&char_pack($1)/ge;
                                # ----------------------------------- ���ʌ݊����p #

                                $data_ref->{$csv_array[0]."-".$_} = $csv_array[$i];
                                $i++;
                            }
                            $data_ref->{$csv_array[0]."-position"} = ++$data_ref->{'id-Nums'};
                        }
                    }
                }
            }
        # �f�[�^�^�C�v�́C$k_plain_txt�ł��邩�H
        } elsif($data_type == $k_plain_txt) {
            while(<IN>) {
                $_                  =~ s/\r\n/\n/g;
                $data_ref->[$id]    = $_;
                $id++;
            }
        } else {
            return "readDataFile(); �������ł��邩�C��`����Ă��Ȃ��f�[�^�^�C�v���w�肳��܂����B$data_type";
        }
        $/ = $saveSeprater;
        close(IN);
    } else {
        return "readDataFile(); ����������܂���B$file_name, $data_type";
    }
    return 0;
}

# &saveDataFile()
# <IN>  $file_name              = �t�@�C����(�p�X�܉�)
#       $data_type              = �����f�[�^�̎��( �t�@�C���㕔�Q�� )
#       \($ | @ | %)object_ref  = �ۑ�����I�u�W�F�N�g( �f�[�^�̎�ނɉ����ĉ� )
#       \$data_head_ref         = �t�@�C���̐擪�ɏ������ރf�[�^( �f�[�^�̎�ނɉ����ĉ� ) �����w���
#       \$data_foot_ref         = �t�@�C���̏I�[�ɏ������ރf�[�^( �f�[�^�̎�ނɉ����ĉ� ) �����w���
#       $extend_property        = �f�[�^�̎�ނɂ��w��
sub saveDataFile
{
    my($file_name, $data_type, $data_ref, $data_head_ref, $data_foot_ref, $extend_property) = @_; # sub�֐��p�̈����擾
    my($id, $tmp);

    # �����͑���Ă���̂��H
    if(($file_name) && ($data_type) && ($data_ref)) {
        # �t�@�C�����쐬�F�����̃t�@�C���́C�㏑�����
        open(OUT, ">$file_name") || return "saveDataFile(); �t�@�C���쐬���s $file_name";
        # �f�[�^�^�C�v�́C$k_csv_data�ł��邩�H
        if($data_type == $k_csv_data) {
            # ��؂蕶���́C���ʎw��ł��邩�H
            if(!($extend_property)) {
                # �ȗ����ݒ�
                $extend_property = ",";
            }
            # �w�b�_�̏o��
            if($data_head_ref) {
                foreach(@$data_head_ref) {
                    print OUT $_;
                }
            } else {
                return "saveDataFile(); csv �f�[�^�̕ۑ��ɂ́C�K���w�b�_���K�v�ł��B"
            }
            # �A�C�e����������
            $data_head_ref->[0] =~ m/^:(.+?)\n/;
            my(@csv_item_name)  = split(/$extend_property/, $1);
            # �s�P�ʂɃA�C�e�������Ԃɏo��
            my($u_id);
            for($id = 0; $id < $data_ref->{'id-Nums'}; $id++) {
                $u_id = $data_ref->{"id-".$id};
                foreach(@csv_item_name) {

                    # ���ʌ݊����p�F�����o�[�W�����ł͔p�~�\�� ------- #
                    $data_ref->{$u_id."-".$_} =~ s/($k_cm_char)/&#44;/g;
                    # ----------------------------------- ���ʌ݊����p #

                    print OUT $data_ref->{$u_id."-".$_}, "$extend_property";
                }
                print OUT "\n";
            }
            # �t�b�^�̏o��
            if($data_foot_ref) {
                foreach(@$data_foot_ref) {
                    print OUT $_;
                }
            }

            $ret = 0;
        } else {
            # �G���[�F�f�[�^�^�C�v�ُ̈�
            $ret = "saveDataFile();  �������ł��邩�C��`����Ă��Ȃ��f�[�^�^�C�v���w�肳��܂����B$data_type";
        }
        # �t�@�C�������
        close(OUT);
    } else {
        # �G���[�F�t�@�C������ׂ̈̈����s��
        $ret = "saveDataFile(); ����������܂���B$file_name";
    }
    return 0;
}

sub char_unpack
{
    my($char) = @_; # sub�֐��p�̈����擾
    $char = unpack("C*", $char);
    $char = $k_cm_replace_head.$char.$k_cm_replace_foot;
    return $char;
}

sub char_pack
{
    my($char) = @_; # sub�֐��p�̈����擾
    $char = pack("C*", $char);
    return $char;
}

# ASV �w�b�_�F�Ǎ��i�t�@�C���擪�A�C�e������`��Ǎ��j
sub asv_read_head
{
    my($FH_ref, $item_name_ref, $sep) = @_; # sub�֐��p�̈����擾
    my($str) = "";

    # �ǂݍ���
    if(!($str = <$FH_ref>)) {
        # �ǂݍ��݃f�[�^�Ȃ�
        return 1;
    }

    $str =~ s/\r\n/\n/g;

    # ��`�s�ł��邩�H
    if($str =~ m/^:(.+?)\n/) {
        @$item_name_ref = split(/$sep/, $1);
    }
    return;
}

# ASV �w�b�_�F�����i�t�@�C���擪�A�C�e������`��Ǎ��j
sub asv_write_head
{
    my($FH_ref, $item_name_ref, $sep) = @_; # sub�֐��p�̈����擾

    print $FH_ref ":";

    for(@$item_name_ref) {
        if( 1 != print $FH_ref $_, $sep ) {
            # �o�̓G���[
            return 1;
        }
    }
    if( 1 != print $FH_ref "\n" ) {
        # �o�̓G���[
        return 1;
    }
    return;
}

# ASV �f�[�^�F�Ǎ� (Any-char Separated Value)
sub asv_read_data
{
    my($FH_ref, $log_data_ref, $item_name_ref, $sep) = @_; # sub�֐��p�̈����擾
    my($str, $i) = "";

    # �ǂݍ���
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

    # ���s�R�[�h�����폜
    $str =~ s/\r//g;
    $str =~ s/\n//g;

    # ��������Z�p���[�^�ŕ���
    my(@log_tmp) = split(/$sep/, $str);

    # ���ʌ݊����p�F�����o�[�W�����ł͔p�~�\�� ------- #
    my($st1) = quotemeta($k_cm_replace_head);
    my($st2) = quotemeta($k_cm_replace_foot);
    # ----------------------------------- ���ʌ݊����p #

    # �A�C�e�������L�[�ɂ��Ď擾�f�[�^���n�b�V���փZ�b�g
    for(@log_tmp) {

        # ���ʌ݊����p�F�����o�[�W�����ł͔p�~�\�� ------- #
        $_ =~ s/$st1(.+?)$st2/&char_pack($1)/ge;
        # ----------------------------------- ���ʌ݊����p #

        $log_data_ref->{$item_name_ref->[$i]} = $_;
        $i++;
    }
    return;
}

# ASV �f�[�^�F���� (Any-char Separated Value)
sub asv_write_data
{
    my($FH_ref, $log_data_ref, $item_name_ref, $sep) = @_; # sub�֐��p�̈����擾

    # �f�[�^���w��̃t�@�C���n���h���֏o��
    for(@$item_name_ref) {
        if( 1 != print $FH_ref $log_data_ref->{$_}, $sep ) {
            # �o�̓G���[
            return 1;
        }
    }
    if( 1 != print $FH_ref "\n" ) {
        # �o�̓G���[
        return 1;
    }
    return;
}

# v4.0 New Function. --------------------------------------------------------------------------------------------------#

# ���̓t�H�[���̃`�F�b�N
sub check_input_form
{
    my($in_ref, $check_list_strings_ref, $error_ref, $chk_numeric_flag, $i_sep, $v_sep) = @_; # sub�֐��p�̈����擾
    my($ret);

    # �Z�p���[�^�����̃`�F�b�N
    unless($i_sep) { $i_sep = $k_cm_char; }
    unless($v_sep) { $v_sep = $k_sep; }
    if($i_sep eq $v_sep) { return "Item�l��Value�l�̃Z�p���[�^�����������ł��B"; }

    # �������F�O�̈�
    $$error_ref = "";

    # �`�F�b�N�A�C�e���擾���ă��X�g�ɂ���A�C�e�����`�F�b�N����
    for(split(/$i_sep/, $$check_list_strings_ref)) {
        my($item, $name) = split(/$v_sep/, $_);
        # ���͂͂��邩�H
        if(!(length($in_ref->{$item}))) {
            # �Ȃ��F�G���[������ɃG���[���e��ǉ�
            $$error_ref .= $name."������܂���B\n";
        } else {
            # ����F
            if($chk_numeric_flag) {
                if($in_ref->{$item} =~ m/[\D]/) {
                    $$error_ref .= $name."�ɐ����ȊO�̕���������܂��B\n";
                }
            }
            $ret++;
        }
    }
    # ���͖�������Ԓl
    return $ret;
}


# ���[���A�h���X�̃`�F�b�N�i�����I�Ɂj
sub check_email_address
{
    my($email_address_ref) = @_; # sub�֐��p�̈����擾

    if(length($$email_address_ref)) {
        # ����F�������͂��邩�H�i�����I�Ɂj
        unless($$email_address_ref =~ m/(.+?)\@(.+?)\.(.+?)/) {
            # �s���F�G���[�\��������ݒ�
            return "���[���A�h���X���s���ł��B���������[���A�h���X����͂��ĉ������B";
        }
    }
    return 0;
}


# ���[�����M����
sub send_mail
{
    my($mail_data_ref, $mail_addresser) = @_; # sub�֐��p�̈����擾

    my($err_info) = "send_mail(); ";

    # HTML���������ɖ߂�
    &convert_char_html2std($mail_data_ref);

    # �����R�[�h�̕ϊ�
    &convert_jpn_code($mail_data_ref, 'jis');


    if(1) { # �]���̓���ɂ���ꍇ�́C0 �ɂ��Ă��������B

        # Subject �̓��{��� MIME-B �ɕϊ�
        $$mail_data_ref =~ s/^(Subject:\s+)(.*)$/&mail_head_encode($1, $2)/me;

    }

    unless(-e $k_mail_prog_path) {
        if($k_debug) {
            print DEBUG "$k_mail_prog_path $k_mail_prog_opt$mail_addresser\n";
            print DEBUG "$$mail_data_ref\n";
            return;
        } else {
            return $err_info."���[�����M�Ɏ��s���܂����B\n���[�����M�v���O�����i$k_mail_prog_path�j������܂���B";
        }
    }

    # mail program �ւ̃p�C�v���J��
    open(MAIL_PROG, "| $k_mail_prog_path $k_mail_prog_opt$mail_addresser") || return $err_info."���[�����M�Ɏ��s���܂����B\n���΂炭���Ă��������x�A�N�Z�X���Ă݂ĉ������B\n����ł��������Ȃ��ꍇ�̓T�C�g�Ǘ��҂ւ��₢���킹�������B";
    # ���[���̓��e���o��
    print MAIL_PROG $$mail_data_ref;
    # mail program �ւ̃p�C�v�����
    close(MAIL_PROG);

    # �G���[����Ԓl
    return 0;
}

# MIME-B�G���R�[�f�B���O�ϊ�
sub mail_head_encode
{
    my($head, $data) = @_; # sub�֐��p�̈����擾

    my($result) = &main::mimeencode($data);

    return $head.$result;
}

# CGI���ݒ�
sub set_cgi_info
{
    my($in_ref, $config_ref) = @_; # sub�֐��p�̈����擾

    my($remote_host);
    # ���ϐ�[REMOTE_HOST]�̓Z�b�g����Ă��邩�H
    if(!$ENV{'REMOTE_HOST'}){
        # �Ȃ��FSocket�Ǎ�
        use Socket;
        # [REMOTE_ADDR]����[REMOTE_HOST]���擾
        $remote_host = gethostbyaddr(inet_aton($ENV{'REMOTE_ADDR'}),AF_INET);
    } else {
        $remote_host = $ENV{'REMOTE_HOST'};
    }

    # �z�X�g�̃f�[�^�E�A�C�e�����̃`�F�b�N
    if(!($config_ref->{$config_ref->{'id-0'}."-HOST_ITEM_NAME"})) {
        # �f�t�H���g�ݒ�FHOST
        $config_ref->{$config_ref->{'id-0'}."-HOST_ITEM_NAME"} = "HOST";
    }
    # �z�X�g�A�h���X��ݒ�
    $in_ref->{$config_ref->{$config_ref->{'id-0'}."-HOST_ITEM_NAME"}} = $remote_host;

    # �����̃f�[�^�E�A�C�e�����̃`�F�b�N
    if(!($config_ref->{$config_ref->{'id-0'}."-DATE_ITEM_NAME"})) {
        # �f�t�H���g�ݒ�FDATE
        $config_ref->{$config_ref->{'id-0'}."-DATE_ITEM_NAME"} = "DATE";
    }
    # ���t��ݒ�
    $in_ref->{$config_ref->{$config_ref->{'id-0'}."-DATE_ITEM_NAME"}} = &get_time();
}

# ���O���e���v���[�g�Ɋ�Â��ĕϊ��iASV�`�����O�j��$src_file_path = "." �Ń��O��
sub convert_log2file_with_tpl
{
    my($in_ref, $usr_cfg_ref, $tpl_file_path, $src_file_path, $dst_file_path, $log_sep) = @_; # sub�֐��p�̈����擾
    my($error, %tpl, %usr_log, @item_name, %cookie);

    # �G���[���ݒ�
    my($err_info) = "convert_log2file_with_tpl(); \n";
    # �e���v���[�g�Ǎ�
    if($error = &readDataFile($tpl_file_path, $k_tpl_html, \%tpl)) { &$k_error_func_ref($err_info.$error); }
    # �e���v���[�g������
    &setup_tpl($in_ref, \%tpl, $usr_cfg_ref, \%cookie);
    # ���o����쐬
    open(DST, ">$dst_file_path") or &$k_error_func_ref($err_info."���o����쐬�ł��܂���ł����B\n$!");
    # ���C���E�w�b�_�����o��֏o��
    print DST $tpl{'MAIN_HEAD'};

    # ���O�L�H
    unless($src_file_path eq ".") {
        # ���O���J��
        open(SRC, $src_file_path) or &$k_error_func_ref($err_info."���O�Ǎ��F[ $src_file_path ]���O�t�@�C���̃I�[�v���Ɏ��s���܂����B\n$!");
        # ���O�E�w�b�_�ǂݍ���
        if(&asv_read_head(\*SRC, \@item_name, $log_sep)) { &$k_error_func_ref($err_info."���O�t�@�C���w�b�_�̓Ǎ��Ɏ��s���܂����B\n$!"); }
        # ���O�Ǎ�
        while(!(&asv_read_data(\*SRC, \%usr_log, \@item_name, $log_sep))) {
            # �L���㑤�����̒u�����������o��֏o��
            print DST save_data_replace($tpl{'COMMENT_MAIN_HEAD'}, \%tpl, \%usr_log, \%cookie);
            # �L�����������̒u�����������o��֏o��
            print DST save_data_replace($tpl{'COMMENT_MAIN_FOOT'}, \%tpl, \%usr_log, \%cookie);
            # �Ǎ����O���N���A
            undef %usr_log;
        }
        # ���O�t�@�C�������
        close(SRC);
    }

    # ���C���E�t�b�^�����o��֏o��
    print DST $tpl{'MAIN_FOOT'};
    # ���o��HTML�����
    close(DST);
}

# HTML�w�b�_�o�͊֐�
sub out_html_header
{
    my($extend_strings_ref) = @_;

    # �w�b�_�o��
    &out_header(\("text/html"), $extend_strings_ref);
}


# �w�b�_�o�͊֐�
sub out_header
{
    my($mime_type_ref, $extend_strings_ref) = @_;

    unless(length($$mime_type_ref)) {
        $$mime_type_ref = \("text/html");
    }

    print STDOUT "Content-type: $$mime_type_ref", "\n";
    print STDOUT "Pragma: no-cache", "\n";
    print STDOUT "Cache-Control: no-cache", "\n";

    # �g��������͂��邩�H
    if(length($$extend_strings_ref)) {
        # �g����������o��
        print STDOUT $$extend_strings_ref, "\n";
    }

    # ���s���o��
    print STDOUT "\n";
}


# HTML�e���v���[�g�\���i�P���^�ȑf�j
sub show_view
{
    my($in_ref, $tpl_html_ref, $usr_cfg_ref, $cookie_ref) = @_; # sub�֐��p�̈����擾
    my($error, %cookie, $tmp, $i, $j);

    # �N�b�L�[�w��Ȃ����H
    if($k_cookie_enable) {
        if(!($cookie_ref)) {
            # �Ȃ��F
            $cookie_ref = \%cookie;
            # �N�b�L�[�̎擾
            &get_cookie($k_CGI_INFO_ref->{'COOKIE_AUTHOR'}, $cookie_ref);
        }
    }

    # tpl_html���Z�b�g�A�b�v
    &setup_tpl_html($in_ref, $tpl_html_ref, $usr_cfg_ref, $cookie_ref);

    # �N�b�L�[��ۑ�
    if($k_cookie_enable) {
        &set_cookie($k_CGI_INFO_ref->{'COOKIE_AUTHOR'}, $cookie_ref);
    }

    # HTML�w�b�_���o��
    &out_html_header();
    # ���C���E�w�b�_���o��
    print STDOUT $tpl_html_ref->{'MAIN_HEAD'};
    # ���C���E�t�b�^���o��
    print STDOUT $tpl_html_ref->{'MAIN_FOOT'};
}

# �e���v���[�g������
sub setup_tpl
{
    my($in_ref, $tpl_ref, $usr_cfg_ref, $cookie_ref) = @_; # sub�֐��p�̈����擾

    &setup_tpl_html($in_ref, $tpl_ref, $usr_cfg_ref, $cookie_ref);
}

# HTML�e���v���[�g������
sub setup_tpl_html
{
    my($in_ref, $tpl_html_ref, $usr_cfg_ref, $cookie_ref) = @_; # sub�֐��p�̈����擾
    my($error, $prev, $next, $hash_key, $ret, $chk1, $chk2, $i);

    # �G���[���ݒ�
    my($err_info) = "setup_tpl_html(); ";

    # �n�b�V���E�L�[�����o��
    foreach $hash_key (sort keys %$tpl_html_ref) {
        # �폜�ύX�֎~ ------------------------------------------------------------------------------ #
        $chk1 += $tpl_html_ref->{$hash_key} =~ s/__%%CGI::(INFOMATION)%%__/$k_CGI_INFO_ref->{$1}/g;
        # ------------------------------------------------------------------------------ �폜�ύX�֎~ #
        # �폜�ύX�֎~ ------------------------------------------------------------------------------ #
        $chk2 += $tpl_html_ref->{$hash_key} =~ s/__%%CGI::(INFOMATION_URL)%%__/$k_CGI_INFO_ref->{$1}/g;
        # ------------------------------------------------------------------------------ �폜�ύX�֎~ #
        # �폜�ύX�֎~ ------------------------------------------------------------------------------ #
        $tpl_html_ref->{$hash_key} =~ s/__%%CGI::(.+?)%%__/$k_CGI_INFO_ref->{$1}/g;
        # ------------------------------------------------------------------------------ �폜�ύX�֎~ #
        # �P���f�[�^�u����������i __%%keyword::property%%__ �j�̏���
        for($i = 0; $i < $usr_cfg_ref->{'id-Nums'}; $i++) {
            # �f�[�^���ʌ^���ʒu��������i ==%%�R���t�B�O��::PROPERTY%%== �j�̏���
            $tpl_html_ref->{$hash_key} =~ s/==%%($usr_cfg_ref->{'id-'.$i})::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$usr_cfg_ref->{$usr_cfg_ref->{'id-'.$i}."-".$2})/ge;
            # �P���f�[�^�u����������i __%%$usr_cfg_ref->{'id-'.$i}::property%%__ �j�̏���
            $tpl_html_ref->{$hash_key} =~ s/__%%($usr_cfg_ref->{'id-'.$i})::(.+?)%%__/$usr_cfg_ref->{$1.'-'.$2}/g;
        }
        # �f�[�^���ʌ^���ʒu��������i ==%%G_IN::PROPERTY%%== �j�̏���
        $tpl_html_ref->{$hash_key} =~ s/==%%(G_IN)::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$in_ref->{$2})/ge;
        # �P���f�[�^�u����������i __%%G_IN::PROPERTY%%__ �j�̏���
        $tpl_html_ref->{$hash_key} =~ s/__%%G_IN::(.+?)%%__/$in_ref->{$1}/g;

        # �N�b�L�[�f�[�^�u������
        $tpl_html_ref->{$hash_key} =~ s/__%%CLIENT_COOKIE::(.+?)%%__/&cookie_data_replace($cookie_ref, $1)/ge;

    }
    # �폜�ύX�֎~ ------------------------------------------------------------------------------------------------------------------------------------ #
    if(!($chk1)) {
        # �ʖ�
        $error .= " [ __%%CGI::INFOMATION%%__ ]";
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ �폜�ύX�֎~ #
    # �폜�ύX�֎~ ------------------------------------------------------------------------------------------------------------------------------------ #
    if(!($chk2)) {
        # �ʖ�
        $error .= " [ __%%CGI::INFOMATION_URL%%__ ]";
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ �폜�ύX�֎~ #
    # �폜�ύX�֎~ ------------------------------------------------------------------------------------------------------------------------------------ #
    if(length($error)) {
        # �ʖ�
        &$k_error_func_ref($err_info."�u���������� $error ������܂���B$chk1, $chk2");
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ �폜�ύX�֎~ #
    # �폜�ύX�֎~ ------------------------------------------------------------------------------------------------------------------------------------ #
    if(!($chk1 == $chk2)) {
        # �ʖ�
        &$k_error_func_ref($err_info."�u���������� [ __%%CGI::INFOMATION%%__ ] [ __%%CGI::INFOMATION_URL%%__ ] �̐��������܂���BERR = $chk1, $chk2", 1);
    }
    # ------------------------------------------------------------------------------------------------------------------------------------ �폜�ύX�֎~ #
}


# �L���f�[�^�u��
sub save_data_replace
{
    my($ret, $tpl_html_ref, $save_data_ref, $cookie_ref) = @_; # sub�֐��p�̈����擾

    # �f�[�^���ʌ^���ʒu��������i ==%%keyword::property%%== �j�̏���
    $ret =~ s/==%%(SAVE)::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$save_data_ref->{$2}, $cookie_ref)/ge;
    # �P���f�[�^�u����������i __%%keyword::property%%__ �j�̏���
    $ret =~ s/__%%SAVE::(.+?)%%__/$save_data_ref->{$1}/g;
    # `���ʂ�Ԃ�
    return $ret;
}

# �L���f�[�^�u���i�L�[�L�j
sub save_data_replace_with_key
{
    my($ret, $tpl_html_ref, $save_data_ref, $cookie_ref, $key) = @_; # sub�֐��p�̈����擾

    # �f�[�^���ʌ^���ʒu��������i ==%%keyword::property%%== �j�̏���
    $ret =~ s/==%%(SAVE)::(.+?)%%==/&special_replace($1, $2, $tpl_html_ref->{$2}, \$save_data_ref->{$key."-".$2}, $cookie_ref)/ge;
    # �P���f�[�^�u����������i __%%keyword::property%%__ �j�̏���
    $ret =~ s/__%%SAVE::(.+?)%%__/$save_data_ref->{$key."-".$1}/g;
    # `���ʂ�Ԃ�
    return $ret;
}

# ==%%keyword::property%%== �̒u��������̏���
sub special_replace
{
    my($key, $pty, $tpl_html_str, $data_str_ref, $cookie_ref) = @_; # sub�֐��p�̈����擾

    # ��`����Ă���̂��H
    if($$data_str_ref && !($$data_str_ref eq $cookie_ref->{'default-'.$pty})) {
        # �Ȃ�炩�̒�`������Βu������
        $tpl_html_str =~ s/__%%($key)::($pty)%%__/$$data_str_ref/g;
        # �������ʂ�Ԃ�
        return $tpl_html_str;
    } else {
        # �������Ȃ��i�܂�󔒁j
        return;
    }
}

# �N�b�L�[�f�[�^�u������
sub cookie_data_replace
{
    my($in_ref, $cookie_ref, $property) = @_; # sub�֐��p�̈����擾
    my($p_name, $p_value);

    # �L���H
    if($k_cookie_enable) {
        # �v���p�e�B���v���p�e�B���ƃv���p�e�B�l�ɕ���
        ($p_name, $p_value) = split(/=/, $property);
        # �Í����O�̓��̓t�H�[���̒��ɑΉ�����v���p�e�B�͂��邩�H
        if(exists $in_ref->{'src-'.$p_name}) {
            # ����F�t�H�[������v���p�e�B���Z�b�g
            $cookie_ref->{$p_name} = $in_ref->{'src-'.$p_name};
        # ���͂��ꂽ�t�H�[���̒��ɑΉ�����v���p�e�B�͂��邩�H
        } elsif(exists $in_ref->{$p_name}) {
            # ����F�t�H�[������v���p�e�B���Z�b�g
            $cookie_ref->{$p_name} = $in_ref->{$p_name};
        } else {
            # �Ȃ��F�v���p�e�B�ɑ΂���N���C�A���g�̃N�b�L�[�͂��邩�H
            if(exists $cookie_ref->{$p_name}) {
                # ����F
            } else {
                # �Ȃ��F�f�t�H���g�̐ݒ�l�́C����̂��H
                if(length($p_value)) {
                    # ����F�f�t�H���g�l���Z�b�g
                    $cookie_ref->{$p_name} = $p_value;
                } else {
                    # �Ȃ��F�󔒂��Z�b�g
                    $cookie_ref->{$p_name} = "";
                }
            }
        }
        # �f�t�H���g�l������Βl��ۑ��i���̓t�H�[���Ƃ̔�r�ׁ̈j
        if($p_value) {
            $cookie_ref->{'default-'.$p_name} = $p_value;
        }
        # �l��Ԃ�
        return $cookie_ref->{$p_name};
    }
}

# �N�b�L�[���擾
sub get_cookie
{
    my($cookie_author, $cookie_ref) = @_; # sub�֐��p�̈����擾
    my($c_author, $c_str);
    my($c_it_name, $c_it_value);

    # �N�b�L�[���擾���ĕ���
    for(split(/;/, $ENV{'HTTP_COOKIE'})) {
        ($c_author, $c_str) = split(/=/, $_);
        $c_author =~ s/\s//g;
        if($c_author eq $cookie_author) { last; }
    }
    # �N�b�L�[���g�𕪉����Ēl���Z�b�g
    for(split(/,/, $c_str)) {
        ($c_it_name, $c_it_value) = split(/$k_sep/, $_);
        $cookie_ref->{$c_it_name} = $c_it_value;
    }
}

# �N�b�L�[�𔭍s�i$extra_strings�͂��̂܂ܔ��f�����̂ŏ����𐮂��Ă������� [hogehoge=damydamy;]�j
sub set_cookie
{
    my($coockie_author, $cookie_ref, $extra_strings) = @_; # sub�֐��p�̈����擾
    my($cookie_str, $key, $secg, $ming, $hourg, $mdayg, $mong, $yearg, $wdayg, $ydayg, $isdstg, @mong, @weekg, $date_gmt);

    # �N�b�L�[�͍��ێ��Ԃ��L�[�Ƃ��A�ۑ�������60����
    ($secg, $ming, $hourg, $mdayg, $mong, $yearg, $wdayg, $ydayg, $isdstg) = gmtime(time + 60 * 24 * 60 * 60);
    # �j���ƏT��z��Œ�`
    @mong  = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
    @weekg = ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    # 60����̍��ێ��Ԃ��w��t�H�[�}�b�g��
    $date_gmt = sprintf("%s, %02d\-%s\-%04d %02d\:%02d\:%02d GMT", $weekg[$wdayg], $mdayg, $mong[$mong], $yearg+1900, $hourg, $ming, $secg);
    # �ۑ�����N�b�L�[���𐶐�
    foreach $key (sort keys %$cookie_ref) {
        # �f�t�H���g�l���X�L�b�v
        if($key =~ /default-(.+?)/) {
            next;
        }
        # �N�b�L�[������֒ǉ�
        $cookie_str .= "$key"."$k_sep"."$cookie_ref->{$key}".",";
    }
    # �s�v�ȍŌ��[,]���폜
    chop($cookie_str);

    # �N�b�L�[�̕W���t�H�[�}�b�g�ɐ����܂��B
    print STDOUT "Set-Cookie: $coockie_author=$cookie_str; $extra_strings expires=$date_gmt;\n";
}


# �N�b�L�[�𔭍s�i�ꎞ�I�F�����w�薳�F$extra_strings�͂��̂܂ܔ��f�����̂ŏ����𐮂��Ă������� [hogehoge=damydamy;]�j
sub set_cookie_only_once
{
    my($coockie_author, $cookie_ref, $extra_strings) = @_; # sub�֐��p�̈����擾
    my($cookie_str, $key);

    # �ۑ�����N�b�L�[���𐶐�
    foreach $key (sort keys %$cookie_ref) {
        # �f�t�H���g�l���X�L�b�v
        if($key =~ /default-(.+?)/) {
            next;
        }
        # �N�b�L�[������֒ǉ�
        $cookie_str .= "$key"."$k_sep"."$cookie_ref->{$key}".",";
    }
    # �s�v�ȍŌ��[,]���폜
    chop($cookie_str);
    # �N�b�L�[�̕W���t�H�[�}�b�g�ɐ����܂��B
    print STDOUT "Set-Cookie: $coockie_author=$cookie_str; $extra_strings\n";
}


# �f�[�^�Í���
sub encrypt_data
{
    my($src_data_ref) = @_; # sub�֐��p�̈����擾
    my(@SALT, $salt, $enc_data);

    # ��������������
    srand;
    # ���������ׂ̈̎탊�X�g���쐬
    @SALT = ('a'..'z', 'A'..'Z', '0'..'9', '.', '/');
    # �탊�X�g�ŗ����𔭐������ĈÍ����p�̎�𐶐�
    $salt = $SALT[int(rand(@SALT))] . $SALT[int(rand(@SALT))];
    # �Í��������p�X���[�h�𐶐�
    $enc_data = crypt($$src_data_ref, $salt) || crypt ($$src_data_ref, '$1$' . $salt);
    # �Í����������������ϐ��֑��
    $$src_data_ref = $enc_data;
}

# �Í��f�[�^�ƍ������i ��v = 1, �s��v = 0 �j
sub decrypt_data
{
    my($src_data, $enc_data) = @_; # sub�֐��p�̈����擾
    my($salt, $key);

    # ����擾
    $salt = $enc_data =~ /^\$1\$(.*)\$/ && $1 || substr($enc_data, 0, 2);
    # �p�X���[�h���ƍ�
    if (crypt($src_data, $salt) eq "$enc_data" || crypt($src_data, '$1$' . $salt) eq "$enc_data") {
        # ��v
        return 1;
    } else {
        # �s��v
        return 0;
    }
}

#  ���Ԃ̎擾
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
    # �j���e�[�u���쐬
    $week = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')[$wday];
    # �����̃t�H�[�}�b�g
    $date = "$year\/$mon\/$mday($week) $hour\:$min\:$sec";  # �b����
    # �l��Ԃ�
    return $date;
}

# �f�B�X�N��e�ʃ`�F�b�N�i0 = OK, 1 = �e�ʕs��, 2 = �����G���[�j
sub check_disk_availability
{
    my($check_size, $quota_path_ref) = @_; # sub�֐��p�̈����擾
    my($err, $size_availability) = 0;

    # �l�� 1 �ȏォ�H
    unless($check_size > 0) {
        # �Ⴄ�F�`�F�b�N��
        return $err;
    }

    # �v���O�����p�X�͂��邩�H
    unless($quota_path_ref) {
        $quota_path_ref = \$k_quota_path;
    }

    # �󂫗e�ʂ��擾
    if(0 <= ($size_availability = &get_disk_availability())) {
        # �󂫗e�ʂ͏\�����H
        if($size_availability < $check_size) {
            # �e�ʕs��
            $err = 1;
        }
    } else {
        # �G���[�F�󂫗e�ʂ��擾�ł��܂���
        $err = 2;
    }
    return $err;
}

# �f�B�X�N��e�ʂ̎擾
sub get_disk_availability
{
    use Cwd;
    use Quota;

    #�J�����g�̃}�E���g�|�C���g���擾
    my($wd) = Cwd::getcwd();
    my(@s_wd) = split(/\//,$wd);
    my($mp) = "\/"."$s_wd[1]";

    #quota�̒l���擾
#    my($device) = Quota::getdev($mp);
    my($device) = Quota::getqcarg($mp);
    my(@wuid) = getpwuid($>);
    my(@prog_out_u) = Quota::query($device,$wuid[2],0);
    my(@prog_out_g) = Quota::query($device,$wuid[3],1);

      # �����������H
      if($prog_out_u[2] == '0') {
        # �e�T�C�Y���擾
        my($blocks_g) = $prog_out_g[0];
        my($quota_g) = $prog_out_g[2];
        # ���������Fweb�ɗe�ʔz�����ꂽ�l�����ɋ󂫗e�ʂ��v�Z���ĕԂ�
        return (${quota_g} - ${blocks_g});
    }else{
        # �e�T�C�Y���擾
        my($blocks_u) = $prog_out_u[0];
        my($quota_u) = $prog_out_u[2];
        # ��������Fadmin��web�g�p�\�e�ʂ����ɋ󂫗e�ʂ��v�Z���ĕԂ�
        return (${quota_u} - ${blocks_u});
    }
}

# ���b�N�t�@�C���J�n
# $lock_type : lockWithOpen = 0, lockWithSym = 1
sub lock_start
{
    my($lock_file, $lock_type, $retry) = @_; # sub�֐��p�̈����擾
    my($error) = "lock_start(); lockWithSym �G���[";

    # ���g���C�̉񐔎w��͂��邩�H
    if(!($retry)) {
        # �ȗ����́C3��
        $retry = 3;
        # ���g���C�T�C�N���́C�������[�h���H
        if($k_lock_fast_cycle) {
            # ���g���C�񐔂�4�{����
            $retry *= 4;
        }
    }
    # 1���ȏ�Â����b�N�͍폜����
    if(-e $lock_file) {
        # �t�@�C���̍쐬���ꂽ���Ԃ��擾
        my($mtime) = (stat($lock_file))[9];
        # �ꕪ�ȏ�Â��t�@�C���Ȃ̂��H
        if($mtime < time - 60) {
            # ���b�N������
            &lock_end($lock_file);
        }
    }
    # �t�@�C�����ɂȂ�܂Ń��g���C�񐔕��J��Ԃ������s����
    while(-e $lock_file) {
        # ����F���g���C�T�C�N���́C�������[�h���H
        # ���g���C�񐔔͈͓����H
        if(--$retry <= 0) {
            # ���g���C�񐔂𒴂����F�t�@�C���쐬���s
            return $error;
        }
        # ���g���C�T�C�N���́C�������[�h���H
        if($k_lock_fast_cycle) {
            # ��葁���T�C�N���Ń��g���C�����s�����܂�
            select(undef, undef, undef, 0.25);
        } else {
            # �Z�[�t���[�h
            sleep(1);
        }
    }
    # ���b�N�t�@�C���̎�ނ́H
    if($lock_type == 1) {
        # �����N�쐬
        symlink(".", $lock_file) or return $error;
    } else {
        # ���b�N�t�@�C�����쐬
        open(LOCK, ">$lock_file") or return $error;
        close(LOCK);
    }
    # �������ʂ�Ԃ�
    return;
}

# ���b�N�t�@�C���I��
sub lock_end
{
    my($lock_file) = @_; # sub�֐��p�̈����擾

    # ���b�N�t�@�C���͂��邩�H
    if(-e $lock_file) {
        # ����F���b�N�t�@�C�����폜
        unlink($lock_file);
    }
}

# �C�ӂ̃n�b�V���̈ꗗ���o�́i�e�X�g�p�j
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

# �ȉ��C���̕ύX�E�폜���ւ��܂� --------------------------------------------------------------------- #
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
# --------------------------------------------------------------------------------------------- �����܂� #

# EOF
1;
