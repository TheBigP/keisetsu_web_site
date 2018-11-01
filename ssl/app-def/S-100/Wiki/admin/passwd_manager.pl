#!/usr/bin/perl
$| = 1;
#
# RCS Infomation.
# �폜�ύX�֎~ ----------------------------------------------------------------------------------------- #
$CGI{'RCS_ID'}      = "$Id: passwd_manager.pl 0.6 2003/06/08 11:43:59 Administrator Exp Administrator $damy";
$CGI{'RCS_SOURCE'}  = "$Source: D:/Users/Administrator/projects/works/salut/S-002_tksetup/tksetup_c002/share\\tpl\\custom\\admin\\RCS/passwd_manager.pl $damy";
# ------------------------------------------------------------------------------------------------------ #
# �ȉ��C���̕ύX�E�폜���ւ��܂� --------------------------------------------------------------------- #
# TKpasswd_manager�F�Ǘ��p�X���[�h�ύX�v���O�����Fpasswd_manager.pl
# Copyright(C) NTTPC Communications, Inc. 2001,2002
# Programmed by Tomonori Kamitaki
#
# [���ӎ���]
#   �X�N���v�g���̍폜�ύX�֎~�₻��Ɋւ���R�����g������R�[�h�́C
#  ���쌠�ی�ׂ̈Ɉ�؂̕ύX��F�߂܂���B
#
# [���p�K������ыK��]
#   �X�N���v�g�z�z���ł���Salut!�i�T�����j�̃z�[���y�[�W�������������B
# Salut!�i�T�����j�z�[���y�[�W => http://www.salut.ne.jp/
#
# --------------------------------------------------------------------------------------------- �����܂� #
# �ȉ��C���̕ύX�E�폜���ւ��܂� --------------------------------------------------------------------- #
$CGI{'TITLE'}           = "TKpasswd_manager";
$CGI{'COPYRIGHT'}       = "Copyright(C) NTTPC Communications, Inc. 2001";
$CGI{'COPYRIGHT_URL'}   = "http://www.nttpc.co.jp/";
$CGI{'VERSION'}         = "Ver. 1.20";
$CGI{'REVISION'}        = '$Revision: 0.6 $';
$CGI{'REVISION'}        =~ s/^\D*(\d+\.\d+)\D*$/$1/;
$CGI{'PROG_BY'}         = "Tomonori Kamitaki";
$CGI{'PROG_MAIL'}       = "";
$CGI{'INFOMATION'}      = "TKpasswd_manager by Salut! Web Master's Heaven";
$CGI{'INFOMATION_URL'}  = "http://www.salut.ne.jp/";
$CGI{'SUPPORT_MAIL'}    = "";
$CGI{'COOKIE_AUTHOR'}   = $CGI{'TITLE'}."PW_MAN";
# --------------------------------------------------------------------------------------------- �����܂� #
# �ϐ��̐ݒ� 1�i���ɉ����Đݒ肵�܂��j---------------------------------------------------------------- #

# htpasswd �̐ݒ�
$g_usr{'htpasswd'} = "/usr/local/httpd/bin/htpasswd -b ./.htpasswd admin";

# ----------------------------------------------------------------------------------------- �ϐ��̐ݒ� 1 #
# �ϐ��̐ݒ� 2�i�ʏ�͕ύX�s�v�F�ύX�����ꍇ�̓���ۏ؂͂���܂���j------------------------------------ #
# �ݒ�t�@�C��
$g_usr{'config'} = "../admin/passwd_manager.cfg";
# HTML�^�O�e���v���[�g�t�@�C��
$g_html{'xxxx_erro'}    = "../admin/tpl/pw_xxxx_error_tpl.html";    # �G���[
$g_html{'pwup_comp'}    = "../admin/tpl/pw_chge_comp_tpl.html"; # ����
# �Z�p���[�^����
$g_sep = "<>";
# ----------------------------------------------------------------------------------------- �ϐ��̐ݒ� 2 #

#���C�u���������[�h
require './share/tk_util4.pl';

#�O���[�o���ϐ�
%g_in;
# ���C������
&main();

# ���C�������֐�
sub main
{
    my($error);
    my(%usr_cfg);

    # ���̓t�H�[���Ǎ�
    &tk_util4::parseInput(\%g_in, "");
    # �ݒ�t�@�C���Ǎ�
    my(@usr_cfg_file) = ($g_usr{'config'});
    if($error = &tk_util4::readConfigFile(\@usr_cfg_file, \%usr_cfg)) { &error($error); }

    # �ݒ���e�̃`�F�b�N
    &check_usr_config(\%usr_cfg);

    # ���̓t�H�[���`�F�b�N
    &check_input_form(\%usr_cfg);

    # �p�X���[�h�̊m�F
    unless($g_in{'PASS_1'} eq $g_in{'PASS_2'}) {
        &error("2�̃p�X���[�h������Ă��܂��B�����p�X���[�h����͂��ĉ������B");
    }

    $g_in{'HTPASSWD_CODE'} = system "$g_usr{'htpasswd'} $g_in{'PASS_1'}";

    unless($g_in{'HTPASSWD_CODE'} == 0) {
        &error("�p�X���[�h�̕ύX�Ɏ��s���܂����B");
    }

    # �e���v���[�gHTML�̓Ǎ�
    if($error = &tk_util4::readDataFile($g_html{'pwup_comp'}, $tk_util4::k_tpl_html, \%tpl_html)) { &error($error); }

    # HTML��\��
    &tk_util4::show_view(\%g_in, \%tpl_html, \%usr_cfg);
}

# ���̓t�H�[���`�F�b�N
sub check_input_form
{
    my($config_ref, $check_disble) = @_;
    my($error, $i);

    # �`�F�b�N�����s����̂��H
    if($check_disble != 1) {
        # �`�F�b�N�A�C�e���擾���ă��X�g�ɂ���A�C�e�����`�F�b�N����
        for(split(/,/, $config_ref->{$config_ref->{'id-0'}."-CHECK_INPUT_FORM_ITEM_LIST"})) {
            my($item, $name) = split(/$g_sep/, $_);
            # ���͂͂��邩�H
            if(!(length($g_in{$item}))) {
                # �Ȃ��F�G���[������ɃG���[���e��ǉ�
                $error .= $name."������܂���B\n";
            }
        }
    }
    # �G���[�͂��������H
    if($error) {
        # ����F�G���[��\��
        &error("�G���[���������܂����B�ڍׂ͎��̒ʂ�ł��B\n\n".$error);
    }
}

# �ݒ���e�̃`�F�b�N
sub check_usr_config
{
    my($config_ref) = @_;

    # �y�[�W�^�C�g���̃`�F�b�N
    if(!($config_ref->{$config_ref->{'id-0'}."-TITLE"})) {
        # �f�t�H���g�ݒ�
        $config_ref->{$config_ref->{'id-0'}."-TITLE"} = $CGI{'TITLE'};
    }

    # �߂�ׂ̃����N��̃`�F�b�N
    if(!($config_ref->{$config_ref->{'id-0'}."-RETURN_URL"})) {
        # �f�t�H���g�ݒ�FHTTP_REFERER
        $config_ref->{$config_ref->{'id-0'}."-RETURN_URL"} = $ENV{'HTTP_REFERER'};
    }

    # �߂�ׂ̃����N��̃^�C�g���^���O�̃`�F�b�N
    if(!($config_ref->{$config_ref->{'id-0'}."-RETURN_URL_TITLE"})) {
        # �߂�ׂ̃����N��͐ݒ肳��Ă���̂��H
        if($config_ref->{$config_ref->{'id-0'}."-RETURN_URL"}) {
            # �f�t�H���g�F�߂�
            $config_ref->{$config_ref->{'id-0'}."-RETURN_URL_TITLE"} = "�߂�";
        } else {
            # �f�t�H���g�F����
            $config_ref->{$config_ref->{'id-0'}."-RETURN_URL_TITLE"} = "";
        }
    }
}


# �G���[�����֐�
# $error_type�Fauto_text = 0; plain_text = 1; img = 10
# $error_lock�F���� = 0; ���u = 1; 
# ��auto_text �́CHTML�e���v���[�g�����鎞�� HTML �Ȃ����� plain �ŃG���[��\�����܂��B
sub error
{
    my($errorStr, $error_type, $error_lock, $error_level) = @_;
    my(%tpl_html, %usr_cfg);

    # ���b�N��������H
    unless($error_lock) {
        # ���b�N�����F
        &tk_util4::lock_end($g_lock_file);
    }

    # �G���[�̎�ނ́H
    if($error_type < 10) {
        # text�F�^�C�v�́Hauto || plain
        if($error_type == 0) {
            # auto�F�G���[�p�e���v���[�gHTML�͑��݂��邩�H
            if(!(-e $g_html{'xxxx_erro'})) {
                # ���݂��Ȃ��iplain text�j�FHTML�w�b�_���o��
                &tk_util4::out_html_header();
                # <BR>�����s��
                $errorStr =~ s/<BR>/\n/g;
                # �G���[���b�Z�[�W���o��
                print "Error : $errorStr\n";
            } else {
                # ���݂���iHTML�j
                # �G���[�������Z�b�g
                $g_in{'ERROR'} = $errorStr;

                # �ݒ�t�@�C���̓Ǎ�
                my(@usr_cfg_file) = ($g_usr{'config'});
                if($error = &tk_util4::readConfigFile(\@usr_cfg_file, \%usr_cfg)) {
                    # �Ǎ��G���[�FHTML�w�b�_���o��
                    &tk_util4::out_html_header();
                    # <BR>�����s��
                    $errorStr =~ s/<BR>/\n/g;
                    # �G���[���b�Z�[�W���o��
                    print "Error : $errorStr\nError : $error\n";
                } else {
                    # �ݒ���e�̃`�F�b�N
                    &check_usr_config(\%usr_cfg);

                    # �G���[���x���w��L��H
                    unless($error_level) {
                        $error_level = "0";
                    }
                    $usr_cfg{$usr_cfg{'id-0'}.'-ERROR_LEVEL-'.$error_level} = "enable";

                    # �e���v���[�gHTML�̓Ǎ�
                    if($error = &tk_util4::readDataFile($g_html{'xxxx_erro'}, $tk_util4::k_tpl_html, \%tpl_html)) {
                        # �Ǎ��G���[�FHTML�w�b�_���o��
                        &tk_util4::out_html_header();
                        # <BR>�����s��
                        $errorStr =~ s/<BR>/\n/g;
                        # �G���[���b�Z�[�W���o��
                        print "Error : $errorStr\nError : $error\n";
                    } else {
                        $g_in{'ERROR'} =~ s/\n/<BR>/g;
                        # HTML��\��
                        &tk_util4::show_view(\%g_in, \%tpl_html, \%usr_cfg);
                    }
                }
            }
        } else {
            # plain text�FHTML�w�b�_���o��
            &out_html_header();
            # �G���[���b�Z�[�W���o��
            print "Error : $errorStr\n";
        }
        # �G���[���̃f�b�o�O�p�Ƀt�H�[���ϐ��̓��e���o��
        &tk_util4::testHashOut("g_in", \%g_in);
    } else {
        # �C���[�W���쐬
        my(@err_img) = (
            '89', '50', '4E', '47', '0D', '0A', '1A', '0A', '00', '00', '00', '0D', '49', '48', '44', '52',
            '00', '00', '00', '59', '00', '00', '00', '0F', '08', '02', '00', '00', '00', '00', 'BE', 'F4',
            '12', '00', '00', '00', '01', '73', '52', '47', '42', '00', 'AE', 'CE', '1C', 'E9', '00', '00',
            '00', '04', '67', '41', '4D', '41', '00', '00', 'B1', '8F', '0B', 'FC', '61', '05', '00', '00',
            '00', '20', '63', '48', '52', '4D', '00', '00', '7A', '26', '00', '00', '80', '84', '00', '00',
            'FA', '00', '00', '00', '80', 'E8', '00', '00', '75', '30', '00', '00', 'EA', '60', '00', '00',
            '3A', '98', '00', '00', '17', '70', '9C', 'BA', '51', '3C', '00', '00', '00', '09', '70', '48',
            '59', '73', '00', '00', '0E', 'C4', '00', '00', '0E', 'C4', '01', '95', '2B', '0E', '1B', '00',
            '00', '00', 'DC', '49', '44', '41', '54', '58', '47', 'ED', '96', 'DB', '0A', 'C4', '30', '08',
            '44', 'FB', 'FF', '3F', 'BD', '5D', '08', '15', '3B', '63', '74', '48', 'BA', 'B0', '50', 'F3',
            '54', '4C', 'E2', 'E5', '78', '49', '8F', 'A3', '57', '13', '68', '02', '1A', '81', '8F', '5B',
            'E3', 'C6', '57', '60', '57', 'C7', '37', '4B', '58', 'B7', 'D7', '63', 'E7', '4D', '98', '68',
            '66', '07', '40', '39', '6B', '0E', '7D', '06', '5B', 'C3', 'ED', 'B1', 'CC', '3A', '9F', 'B9',
            'D9', '52', '22', '07', '8D', '09', '64', 'AF', '6D', '16', 'BF', '97', 'F3', 'F9', '90', '32',
            'D3', '29', 'B3', 'A5', 'C4', '85', 'B6', '94', '3B', '0F', 'B2', 'B0', '42', 'E3', '8A', '9B',
            '21', '56', 'F8', '8A', '51', '00', 'C1', '45', '16', 'D6', '29', '79', '26', '4B', 'BF', 'FF',
            '9D', '85', 'D2', 'D5', 'BF', '63', '51', 'F4', 'B0', '6B', 'FB', 'A4', 'F3', 'C3', '09', 'C2',
            '7D', 'A4', 'CE', '0B', '6F', '29', 'EC', '46', 'A5', 'AA', 'CB', 'BA', '00', 'A6', '9B', 'F3',
            '82', '7D', '2E', 'A3', '80', 'A7', '60', '65', '76', 'FA', '51', 'BC', '39', '3B', '3D', 'D3',
            '4D', '16', '61', 'B5', '72', 'CE', '66', '92', 'F5', '79', '61', 'AF', 'D4', '8B', '58', '84',
            '2F', '73', '31', '81', 'AF', '6D', 'C8', '73', '38', '89', 'A0', '2E', 'B8', 'D5', '95', 'FF',
            '8B', 'F2', '4D', 'DD', '89', '22', '49', '76', '6F', '35', '81', '17', '12', '38', '01', 'CE',
            '1C', 'DF', '3D', 'BE', '71', '09', '19', '00', '00', '00', '00', '49', '45', '4E', '44', 'AE',
            '42', '60', '82'
        );
        # �C���[�W�w�b�_���o��
        print "Content-type: image/png\n\n";
        foreach (@err_img) {
            print pack('C*',hex($_));
        }
    }
    exit(1);
}

#EOF
1;
