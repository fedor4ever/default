#!/usr/bin/perl
# Copyright (c) 2009 Symbian Foundation Ltd
# This component and the accompanying materials are made available
# under the terms of the License "Eclipse Public License v1.0"
# which accompanies this distribution, and is available
# at the URL "http://www.eclipse.org/legal/epl-v10.html".
#
# Initial Contributors:
# Symbian Foundation Ltd - initial contribution.
#
# Contributors:
# Maciej Seroka <maciejs@symbian.org>
#
# Description:
# Script to build ATS test drop for Connection Settings BC tests


use strict;
use File::Copy;
use File::Path;

unlink "cmmgrbctest.zip";
rmtree "temp";
mkpath "temp/cmmgrbctest/general/testframework";
mkpath "temp/cmmgrbctest/winscw_udeb";

my $epoc=$ENV{'EPOCROOT'} . "epoc32/";
copy("cmmgrbc.xml",	"temp/test.xml");

copy($epoc . "release/winscw/udeb/cmmgrbc.dll",						"temp/cmmgrbctest/winscw_udeb/cmmgrbc.dll") or die "failed : $!";
copy($epoc . "winscw/c/testframework/testframework_cmmgrbc.ini",	"temp/cmmgrbctest/general/testframework/testframework_cmmgrbc.ini") or die "failed : $!";

system("7z a -tzip cmmgrbctest.zip ./temp/*");
