// Copyright (c) 2001-2009 Nokia Corporation and/or its subsidiary(-ies).
// All rights reserved.
// This component and the accompanying materials are made available
// under the terms of the License "Eclipse Public License v1.0"
// which accompanies this distribution, and is available
// at the URL "http://www.eclipse.org/legal/epl-v10.html".
//
// Initial Contributors:
// Nokia Corporation - initial contribution.
//
// Contributors:
//
// Description:
//



//  INCLUDES
#include "ctlbsclientpostp4707.h"
#include <EPos_CPosModules.h>
#include <EPos_CPosModuleUpdate.h>
#include <EPos_CPosModuleIdList.h>


// ================= MEMBER FUNCTIONS =======================

// ---------------------------------------------------------
// Constructor.
// ---------------------------------------------------------
CT_LbsClientPosTp4707::CT_LbsClientPosTp4707(CT_LbsServer& aParent): CT_LbsPortedStepBase(aParent)
    {  
    _LIT(KTestName, "TP4707 - Default Proxy fallback-partial update3");
    SetTestStepName(KTestName); 
    }

// ---------------------------------------------------------
// Destructor.
// ---------------------------------------------------------
CT_LbsClientPosTp4707::~CT_LbsClientPosTp4707()
    {
    }

// ---------------------------------------------------------
// CPosTp4707::CloseTest
//
// (other items were commented in a header).
// ---------------------------------------------------------
//
void CT_LbsClientPosTp4707::CloseTest()
    {
    ClosePositioner();
    Disconnect();
    }

// ---------------------------------------------------------
// CPosTp4707::StartL
//
// (other items were commented in a header).
// ---------------------------------------------------------
//
void CT_LbsClientPosTp4707::StartL()
    {
    ConnectL();

    SetupProxyPSYsL();

    TInt err = OpenPositioner();
    _LIT(KOpenErr, "Error when opening positioner, %d");
    AssertTrueL(err == KErrNone, KOpenErr, err);
    
    _LIT(KServiceName, "TP4707");
    iPositioner.SetRequestor(CRequestor::ERequestorService, CRequestor::EFormatApplication, KServiceName);

    // Issue a pre position request
    TInt request = 100;
    TPositionInfo posInfo;
    RequestL(posInfo, request, KEspectedErrorCodePSY1);
    
    /////////////////////////////////////////////
	// Request 1
	/////////////////////////////////////////////
    // Check that partial update is not supported
    TPositionUpdateOptions updateOptions;
    updateOptions.SetAcceptPartialUpdates(ETrue);    
    iPositioner.SetUpdateOptions(updateOptions);
    
    request = 4707;
    RequestL(posInfo, request, KEspectedErrorCodePSY2);    

    VerifyPositionFromL(posInfo, iUidTestPsyPartialUpdate);    
    VerifyRequestTimeLessThanL(5001000);
    
    VerifyPositionL(posInfo, 30, 40, 50);
    }
    
// ---------------------------------------------------------
// CPosTp4707::SetupProxyPSYsL
//
// (other items were commented in a header).
// ---------------------------------------------------------
//
void CT_LbsClientPosTp4707::SetupProxyPSYsL()
    {
    CPosModules* db = CPosModules::OpenL();
    CleanupStack::PushL(db);

    CPosModuleUpdate* moduleUpdate = CPosModuleUpdate::NewLC();

    moduleUpdate->SetUpdateAvailability(EFalse);
    
    CPosModuleIdList* prioList = db->ModuleIdListLC();
	
    // Disable all PSY:s except PSYs used by this test case
    
    for (TInt i = 0 ; i < prioList->Count(); i++)
        {
        if ((*prioList)[i] !=  iUidTestProxyPsy1 &&
            (*prioList)[i] != iUidTestPsyPartialUpdate)
            {
            db->UpdateModuleL((*prioList)[i], *moduleUpdate);
            }
        }
    moduleUpdate->SetUpdateAvailability(ETrue);
    db->UpdateModuleL(iUidTestProxyPsy1, *moduleUpdate);
    db->UpdateModuleL(iUidTestPsyPartialUpdate, *moduleUpdate);
    
    db->SetModulePriorityL(iUidTestProxyPsy1, 0);
    db->SetModulePriorityL(iUidTestPsyPartialUpdate, 1);
    
    CleanupStack::PopAndDestroy(prioList);
    CleanupStack::PopAndDestroy(moduleUpdate);
    CleanupStack::PopAndDestroy(db);
    } 

//  End of File

    
