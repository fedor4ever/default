#!/usr/bin/perl

use strict;
use File::Copy;
use File::Path;

unlink "smoketest.zip";
rmtree "temp";
mkpath "temp/smoketest/general";
mkpath "temp/smoketest/winscw_udeb";
mkpath "temp/smoketest/sms/general";
mkpath "temp/smoketest/emailmessage/general";
mkpath "temp/smoketest/emailsettings/general";

my $epoc=$ENV{'EPOCROOT'} . "epoc32/";
copy("smoketest.xml",												"temp/test.xml");
copy($epoc . "data/z/smoketest/smoketest_agenda.ini",				"temp/smoketest/general/smoketest_agenda.ini");
copy($epoc . "data/z/smoketest/smoketest_agenda.script",			"temp/smoketest/general/smoketest_agenda.script");
copy($epoc . "data/z/smoketest/smoketest_apploader.ini",			"temp/smoketest/general/smoketest_apploader.ini");
copy($epoc . "data/z/smoketest/smoketest_apploader.script",			"temp/smoketest/general/smoketest_apploader.script");
copy($epoc . "data/z/smoketest/smoketest_contacts.ini",				"temp/smoketest/general/smoketest_contacts.ini");
copy($epoc . "data/z/smoketest/smoketest_contacts.script",			"temp/smoketest/general/smoketest_contacts.script");
copy($epoc . "data/z/smoketest/smoketest_createsmsaccount.script",	"temp/smoketest/general/smoketest_createsmsaccount.script");
copy($epoc . "data/z/smoketest/smoketest_mess.ini",					"temp/smoketest/general/smoketest_mess.ini");
copy($epoc . "data/z/smoketest/smoketest_mess.script",				"temp/smoketest/general/smoketest_mess.script");
copy($epoc . "data/z/smoketest/smoketest_phone.script",				"temp/smoketest/general/smoketest_phone.script");
copy($epoc . "data/z/smoketest/smoketest_syncmlapp.script",			"temp/smoketest/general/smoketest_syncmlapp.script");
copy($epoc . "data/z/smoketest/smoketest_system.script",			"temp/smoketest/general/smoketest_system.script");
copy($epoc . "data/z/smoketest/smoketest_timew.ini",				"temp/smoketest/general/smoketest_timew.ini");
copy($epoc . "data/z/smoketest/smoketest_timew.script",				"temp/smoketest/general/smoketest_timew.script");
copy($epoc . "data/z/smoketest/smoketest_email.ini",				"temp/smoketest/general/smoketest_email.ini");
copy($epoc . "data/z/smoketest/smoketest_email.script",				"temp/smoketest/general/smoketest_email.script");
copy($epoc . "data/z/smoketest/smoketest_lbs.ini",					"temp/smoketest/general/smoketest_lbs.ini");
copy($epoc . "data/z/smoketest/smoketest_lbs.script",				"temp/smoketest/general/smoketest_lbs.script");
copy($epoc . "data/z/smoketest/sms/message1.txt",					"temp/smoketest/sms/general/message1.txt");
copy($epoc . "data/z/smoketest/MachineName.txt",					"temp/smoketest/general/MachineName.txt");
copy($epoc . "data/z/smoketest/emailmessage/20KBody.txt",			"temp/smoketest/emailmessage/general/20KBody.txt");
copy($epoc . "data/z/smoketest/emailsettings/popsettings_test908.txt",	"temp/smoketest/emailsettings/general/popsettings_test908.txt");
copy($epoc . "release/winscw/udeb/SmokeTestSecureFSclient.dll",		"temp/smoketest/winscw_udeb/SmokeTestSecureFSclient.dll");
copy($epoc . "release/winscw/udeb/SmokeTestSecureFSserver.exe",		"temp/smoketest/winscw_udeb/SmokeTestSecureFSserver.exe");
copy($epoc . "release/winscw/udeb/Smoketest_Agenda_Server.exe",		"temp/smoketest/winscw_udeb/Smoketest_Agenda_Server.exe");
copy($epoc . "release/winscw/udeb/smoketest_apploader.exe",			"temp/smoketest/winscw_udeb/smoketest_apploader.exe");
copy($epoc . "release/winscw/udeb/Smoketest_Contacts_Server.exe",	"temp/smoketest/winscw_udeb/Smoketest_Contacts_Server.exe");
copy($epoc . "release/winscw/udeb/Smoketest_Mess_Server.exe",		"temp/smoketest/winscw_udeb/Smoketest_Mess_Server.exe");
copy($epoc . "release/winscw/udeb/Smoketest_System.exe",			"temp/smoketest/winscw_udeb/Smoketest_System.exe");
copy($epoc . "release/winscw/udeb/Smoketest_Timew_Server.exe",		"temp/smoketest/winscw_udeb/Smoketest_Timew_Server.exe");
copy($epoc . "release/winscw/udeb/SmokeTest_Utils.dll",				"temp/smoketest/winscw_udeb/SmokeTest_Utils.dll");
copy($epoc . "release/winscw/udeb/t_msgutilityserver.dll",			"temp/smoketest/winscw_udeb/t_msgutilityserver.dll");
copy($epoc . "release/winscw/udeb/t_msgpopserver.exe",				"temp/smoketest/winscw_udeb/t_msgpopserver.exe");
copy($epoc . "release/winscw/udeb/t_msgsmtpserver.exe",				"temp/smoketest/winscw_udeb/t_msgsmtpserver.exe");
copy($epoc . "release/winscw/udeb/lbstestutils.dll",				"temp/smoketest/winscw_udeb/lbstestutils.dll");
copy($epoc . "release/winscw/udeb/lbstestclient.dll",				"temp/smoketest/winscw_udeb/lbstestclient.dll");
copy($epoc . "release/winscw/udeb/lbstestchannel.dll",				"temp/smoketest/winscw_udeb/lbstestchannel.dll");
copy($epoc . "release/winscw/udeb/lbstestserver.exe",				"temp/smoketest/winscw_udeb/lbstestserver.exe");
copy($epoc . "release/winscw/udeb/ctlbsexeclient.exe",				"temp/smoketest/winscw_udeb/ctlbsexeclient.exe");
copy($epoc . "release/winscw/udeb/lbsclienttestserver.exe",			"temp/smoketest/winscw_udeb/lbsclienttestserver.exe");

copy($epoc . "release/winscw/udeb/ProfileSmokeTestModule.dll",      "temp/smoketest/winscw_udeb/ProfileSmokeTestModule.dll");
copy($epoc . "winscw/c/smoketest/ProfileSmokeTestModule.cfg",       "temp/smoketest/general/ProfileSmokeTestModule.cfg");
copy($epoc . "release/winscw/udeb/AppInstallSmokeTestModule.dll",   "temp/smoketest/winscw_udeb/AppInstallSmokeTestModule.dll");
copy($epoc . "winscw/c/smoketest/AppInstallSmokeTestModule.cfg",    "temp/smoketest/general/AppInstallSmokeTestModule.cfg");
copy($epoc . "release/winscw/udeb/TestNpdApi.dll",					"temp/smoketest/winscw_udeb/TestNpdApi.dll");
copy($epoc . "data/c/smoketest/smoketest_notepad.cfg",				"temp/smoketest/general/smoketest_notepad.cfg");
copy($epoc . "data/c/smoketest/ui_TestNpdApi.cfg",					"temp/smoketest/general/ui_TestNpdApi.cfg");
copy($epoc . "release/winscw/udeb/testsdkskins.dll",				"temp/smoketest/winscw_udeb/testsdkskins.dll");
copy($epoc . "data/c/smoketest/smoketest_uiresources.cfg",			"temp/smoketest/general/smoketest_uiresources.cfg");
copy($epoc . "data/c/smoketest/ui_testsdkskinsu.cfg",				"temp/smoketest/general/ui_testsdkskinsu.cfg");

system("7z a -tzip smoketest.zip ./temp/*");
