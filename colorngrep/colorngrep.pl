#!/usr/bin/perl -w

########################################################################
#                                                                      #
# colorNgrep - colorize ngrep output for SIP text                      #
#                                                                      #
# Copyright (C) 2013 Ruben Gomez (rugoli AT gmail.com)                 #
#                                                                      #
# Based on ColorDiff by  Dave Ewart (davee@sungate.co.uk)              #
#                                                                      #
########################################################################
#                                                                      #
# This program is free software; you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation; either version 2 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
########################################################################

use strict;
# ANSI sequences for colors
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# http://confignewton.com/wp-content/uploads/2011/07/bash_color_codes.png# http://misc.flogisoft.com/bash/tip_colors_and_formatting
my %color;
$color{yellow}      = "\033[1;33m";
$color{green}       = "\033[1;32m";
$color{blue}        = "\033[1;34m";
$color{cyan}        = "\033[1;36m";
$color{red}         = "\033[1;31m";
$color{magenta}     = "\033[1;35m";

#underlined
$color{uyellow}      = "\033[4;33m";
$color{ugreen}       = "\033[4;32m";
$color{ublue}        = "\033[4;34m";
$color{ucyan}        = "\033[4;36m";
$color{ured}         = "\033[4;31m";
$color{umagenta}     = "\033[4;35m";

#backgrounds
$color{byellow}      = "\033[43m\033[1;37m";
$color{bgreen}       = "\033[42m\033[1;37m";
$color{bblue}        = "\033[44m\033[1;37m";
$color{bcyan}        = "\033[46m\033[1;37m";
$color{bred}         = "\033[41m\033[1;37m";
$color{bmagenta}     = "\033[45m\033[1;37m";
$color{borange}      = "\033[48;5;208m\033[1;37m";

$color{off}         = "\033[0;0m";

my $option     = "$color{bgreen}OPTIONS$color{off}";
my $notify     = "$color{byellow}NOTIFY$color{off}";
my $invite     = "$color{bmagenta}INVITE$color{off}";
my $register   = "$color{bblue}REGISTER$color{off}";
my $subscribe  = "$color{borange}SUBSCRIBE$color{off}";
my $ack        = "$color{ugreen}ACK$color{off}";
my $from       = "$color{ucyan}FROM:$color{off}";
my $to         = "$color{ured}TO:$color{off}";
my $ringing    = "$color{green}Ringing$color{off}";
my $trying     = "$color{magenta}Trying$color{off}";

while (<STDIN>) {
    #replace IP -> IP
    $_ =~ s/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{1,5}) -> (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{1,5})/$color{cyan}$1$color{off} -> $color{red}$2$color{off}/g;
    
    $_ =~ s/^OPTIONS/$option/g ;
    $_ =~ s/^NOTIFY/$notify/g ;
    $_ =~ s/^INVITE/$invite/g ;
    $_ =~ s/^REGISTER/$register/g ;
    $_ =~ s/^SUBSCRIBE/$subscribe/g ;
    $_ =~ s/^ACK/$ack/g ;

    #colorize FROM  IP
    my @from_results = ($_ =~ /From:.*\@(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*/ );
    $_ =~ s/@from_results/$color{ucyan}@from_results$color{off}/g;
    $_ =~ s/From:/$from/g ;

    #colorize TO IP
    my @to_results = ($_ =~ /To:.*@(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*/ );
    $_ =~ s/@to_results/$color{ured}@to_results$color{off}/g;
    $_ =~ s/To:/$to/g ;

    $_ =~ s/Ringing/$ringing/g ;
    $_ =~ s/Trying/$trying/g ;
    print "$_";
}