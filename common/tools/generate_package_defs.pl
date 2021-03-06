use strict;

my $SYSDEFTOOLS_PATH = "packages\\sysdeftools";
my $XALAN_J = "java -jar $SYSDEFTOOLS_PATH\\xalan.jar";
my $XALAN_C = "packages\\sysmodelgen\\rsc\\installed\\Xalan\\Xalan.exe";

system("rmdir /S /Q tmp") if (-d "tmp");
mkdir("tmp");
chdir("tmp");

print "\n\n### CLONE MCL/sftools/fbf/projects/packages REPO ###\n";
system("hg clone -r default http://developer.symbian.org/oss/MCL/sftools/fbf/projects/packages");
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
my $timestamp = sprintf "%4d%02d%02d%02d%02d%02d",$year+1900,$mon+1,$mday,$hour,$min,$sec;
#print "\n\n### CLONE MCL/sf/os/buildtools REPO ###\n";
#system("hg clone -r RCL_3 http://developer.symbian.org/oss/MCL/sf/os/buildtools");
print "\n\n### CLONE MCL/sftools/fbf/projects/platforms REPO ###\n";
system("hg clone -r default http://developer.symbian.org/oss/MCL/sftools/fbf/projects/platforms");

# get the codelines from the packages repo
opendir(DIR, "packages");
my @codelines = grep(($_ !~ /^\.\.?$/ and $_ =~ /^symbian/), readdir(DIR));
close(DIR);

# get the changeset from the platform repo 
my $platform_changeset = `hg -R platforms identify -i`;
chomp $platform_changeset;
print "-->$platform_changeset<--\n";

# loop over codelines
for my $codeline (@codelines)
{
	mkdir($codeline);
	
	# Split model into package models
	print "\n\n### SPLIT MODEL INTO PACKAGE MODELS ###\n";
	my $updatedefault_cmd = "hg -R packages update -r default";
	print "$updatedefault_cmd\n";
	system($updatedefault_cmd);
	my $rmdir_cmd = "del /S packages\\$codeline\\package_definition.xml >nul";
	print "$rmdir_cmd\n";
	system($rmdir_cmd);
	my $splitmodel_cmd = "perl ..\\split_sysdef.pl -s platforms\\$codeline\\single\\sysdefs\\system_model.xml -o packages\\$codeline";
	print "$splitmodel_cmd\n";
	system($splitmodel_cmd);
	if ($codeline eq 'symbian3') # also update CompilerCompatibility, tip_bulk_s3 and RCL_3
	{
		my $rmdir2_cmd = "del /S  packages\\CompilerCompatibility\\package_definition.xml >nul";
		print "$rmdir2_cmd\n";
		system($rmdir2_cmd);
		my $splitmodel2_cmd = "perl ..\\split_sysdef.pl -s platforms\\$codeline\\single\\sysdefs\\system_model.xml -o packages\\CompilerCompatibility";
		print "$splitmodel2_cmd\n";
		system($splitmodel2_cmd);
		
		my $rmdir3_cmd = "del /S  packages\\tip_bulk_s3\\package_definition.xml >nul";
		print "$rmdir3_cmd\n";
		system($rmdir3_cmd);
		my $splitmodel3_cmd = "perl ..\\split_sysdef.pl -s platforms\\$codeline\\single\\sysdefs\\system_model.xml -o packages\\tip_bulk_s3";
		print "$splitmodel3_cmd\n";
		system($splitmodel3_cmd);
		
		my $rmdir4_cmd = "del /S  packages\\RCL_3\\package_definition.xml >nul";
		print "$rmdir4_cmd\n";
		system($rmdir4_cmd);
		my $splitmodel4_cmd = "perl ..\\split_sysdef.pl -s platforms\\$codeline\\single\\sysdefs\\system_model.xml -o packages\\RCL_3";
		print "$splitmodel4_cmd\n";
		system($splitmodel4_cmd);
	}
	if ($codeline eq 'symbian4') # also update tip_pbc (package based contribution) branch
	{
		my $rmdir3_cmd = "del /S  packages\\tip_pbc\\package_definition.xml >nul";
		print "$rmdir3_cmd\n";
		system($rmdir3_cmd);
		my $splitmodel3_cmd = "perl ..\\split_sysdef.pl -s platforms\\$codeline\\single\\sysdefs\\system_model.xml -o packages\\tip_pbc";
		print "$splitmodel3_cmd\n";
		system($splitmodel3_cmd);
	}
	my $addremove_cmd = "hg -R packages addremove";
	print "$addremove_cmd\n";
	system($addremove_cmd);
	my $diff_cmd = "hg -R packages diff --stat";
	print "$diff_cmd\n";
	my @diff_output = `$diff_cmd`;
	if (@diff_output)
	{
		my $commit_cmd = "hg -R packages commit -m \"Update package models from latest system model  (platform\@$platform_changeset)\" -u\"Dario Sestito <darios\@symbian.org>\"";
		print "$commit_cmd\n";
		system($commit_cmd);
		my $push_cmd = "hg -R packages push http://darios:symbian696b\@developer.symbian.org/oss/MCL/sftools/fbf/projects/packages";
		print "$push_cmd\n";
		system($push_cmd);
	}
}

