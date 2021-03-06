/*
* Copyright (c) 2009 Nokia Corporation and/or its subsidiary(-ies). 
* All rights reserved.
* This component and the accompanying materials are made available
* under the terms of the License "Eclipse Public License v1.0"
* which accompanies this distribution, and is available
* at the URL "http://www.eclipse.org/legal/epl-v10.html".
*
* Initial Contributors:
* Nokia Corporation - initial contribution.
*
* Contributors:
* 
* Description: This file contains testclass implementation.
*
*/

// [INCLUDE FILES] - do not remove
#include <e32svr.h>
#include <StifParser.h>
#include <Stiftestinterface.h>
#include <ImplementationInformation.h>
#include <SwInstApi.h>
#include "AppInstallSmokeTestModule.h"

// EXTERNAL DATA STRUCTURES
//extern  ?external_data;

// EXTERNAL FUNCTION PROTOTYPES  
//extern ?external_function( ?arg_type,?arg_type );

// CONSTANTS
//const ?type ?constant_var = ?constant;

// MACROS
//#define ?macro ?macro_def

// LOCAL CONSTANTS AND MACROS
//const ?type ?constant_var = ?constant;
//#define ?macro_name ?macro_def

// MODULE DATA STRUCTURES
//enum ?declaration
//typedef ?declaration

// LOCAL FUNCTION PROTOTYPES
//?type ?function_name( ?arg_type, ?arg_type );

// FORWARD DECLARATIONS
//class ?FORWARD_CLASSNAME;
using namespace SwiUI;

// ============================= LOCAL FUNCTIONS ===============================

// -----------------------------------------------------------------------------
// ?function_name ?description.
// ?description
// Returns: ?value_1: ?description
//          ?value_n: ?description_line1
//                    ?description_line2
// -----------------------------------------------------------------------------
//
/*
?type ?function_name(
    ?arg_type arg,  // ?description
    ?arg_type arg)  // ?description
    {

    ?code  // ?comment

    // ?comment
    ?code
    }
*/

// ============================ MEMBER FUNCTIONS ===============================

// -----------------------------------------------------------------------------
// CAppInstallSmokeTestModule::Delete
// Delete here all resources allocated and opened from test methods. 
// Called from destructor. 
// -----------------------------------------------------------------------------
//
void CAppInstallSmokeTestModule::Delete() 
    {

    }

// -----------------------------------------------------------------------------
// CAppInstallSmokeTestModule::RunMethodL
// Run specified method. Contains also table of test mothods and their names.
// -----------------------------------------------------------------------------
//
TInt CAppInstallSmokeTestModule::RunMethodL( 
    CStifItemParser& aItem ) 
    {

    static TStifFunctionInfo const KFunctions[] =
        {  
        // Copy this line for every implemented function.
        // First string is the function name used in TestScripter script file.
        // Second is the actual implementation member function.
        ENTRY( "InstallApp", CAppInstallSmokeTestModule::InstallAppL ),
        ENTRY( "UninstallApp", CAppInstallSmokeTestModule::UninstallAppL ),
        //ADD NEW ENTRY HERE
        // [test cases entries] - Do not remove

        };

    const TInt count = sizeof( KFunctions ) / 
                        sizeof( TStifFunctionInfo );

    return RunInternalL( KFunctions, count, aItem );

    }

// -----------------------------------------------------------------------------
// CAppInstallSmokeTestModule::ExampleL
// Example test method function.
// (other items were commented in a header).
// -----------------------------------------------------------------------------
//
TInt CAppInstallSmokeTestModule::InstallAppL( CStifItemParser& aItem )
    {
    // Print to UI
    _LIT( KAppInstallSmokeTestModule, "AppInstallSmokeTestModule" );
    _LIT( KInstallApp, "In InstallApp" );
    TestModuleIf().Printf( 0, KAppInstallSmokeTestModule, KInstallApp );
    // Print to log file
    iLog->Log( KInstallApp );

    TInt i = 0;
    TPtrC sisPath;
    if ( aItem.GetNextString ( sisPath ) == KErrNone )
        {
        RSWInstSilentLauncher installer;
        CleanupClosePushL(installer);
        User::LeaveIfError(installer.Connect());
        
        TInstallOptionsPckg options;
        options().iUpgrade = SwiUI::EPolicyAllowed;
        options().iPackageInfo = SwiUI::EPolicyAllowed;
        options().iOverwrite = SwiUI::EPolicyAllowed;
        options().iKillApp = SwiUI::EPolicyAllowed;

        
        User::LeaveIfError(installer.SilentInstall(sisPath, options));
        
        CleanupStack::PopAndDestroy(&installer);
        }

    return KErrNone;
    }

// -----------------------------------------------------------------------------
// CAppInstallSmokeTestModule::ExampleL
// Example test method function.
// (other items were commented in a header).
// -----------------------------------------------------------------------------
//
TInt CAppInstallSmokeTestModule::UninstallAppL( CStifItemParser& aItem )
    {

    // Print to UI
    _LIT( KAppInstallSmokeTestModule, "AppInstallSmokeTestModule" );
    _LIT( KUninstallApp, "In UninstallApp" );
    TestModuleIf().Printf( 0, KAppInstallSmokeTestModule, KUninstallApp );
    // Print to log file
    iLog->Log( KUninstallApp );

    TUint pkgUid;
    if ( aItem.GetNextInt(pkgUid, EHex) == KErrNone )
        {
        RSWInstSilentLauncher uninstaller;
        CleanupClosePushL(uninstaller);
        User::LeaveIfError(uninstaller.Connect());
        
        TInstallOptionsPckg options;
        options().iUpgrade = SwiUI::EPolicyAllowed;
        options().iPackageInfo = SwiUI::EPolicyAllowed;
        options().iOverwrite = SwiUI::EPolicyAllowed;
        options().iKillApp = SwiUI::EPolicyAllowed;
        
        User::LeaveIfError(uninstaller.SilentUninstall( TUid::Uid(pkgUid), options, SwiUI::KSisxMimeType ));
        
        CleanupStack::PopAndDestroy(&uninstaller);
        }

    return KErrNone;
    }

// -----------------------------------------------------------------------------
// CAppInstallSmokeTestModule::?member_function
// ?implementation_description
// (other items were commented in a header).
// -----------------------------------------------------------------------------
//
/*
TInt CAppInstallSmokeTestModule::?member_function(
   CItemParser& aItem )
   {

   ?code

   }
*/

// ========================== OTHER EXPORTED FUNCTIONS =========================
// None

//  [End of File] - Do not remove
