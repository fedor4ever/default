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
#
# Description:
# Common constants for the raptor parser suite

package RaptorCommon;

our $CATEGORY_GENERAL = 'general';

our $CATEGORY_RAPTORERROR = 'raptor_error';
our $CATEGORY_RAPTORERROR_CANNOTPROCESSSCHEMAVERSION = 'cannot_process_schema_version';
our $CATEGORY_RAPTORERROR_NOBLDINFFOUND = 'no_bld_inf_found';

our $SEVERITY_UNKNOWN = 'unknown';
our $SEVERITY_CRITICAL = 'critical';

sub dump_fault
{
	my ($category, $subcategory, $severity, $component, $phase, $recipe, $file, $line) = @_;
	
	open(SUMMARY, ">>$::basedir/summary.csv");
	print SUMMARY "$category,$subcategory,$severity,$component,$phase,$recipe,$file,$line\n";
	close(SUMMARY);
}

1;
