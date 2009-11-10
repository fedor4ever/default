// Copyright (c) 2006-2009 Nokia Corporation and/or its subsidiary(-ies).
// All rights reserved.
// This component and the accompanying materials are made available
// under the terms of the License "Symbian Foundation License v1.0"
// which accompanies this distribution, and is available
// at the URL "http://www.symbianfoundation.org/legal/sfl-v10.html".
//
// Initial Contributors:
// Nokia Corporation - initial contribution.
//
// Contributors:
//
// Description:
// @file CT_LbsStep_SetATAMode.h
// This contains the header file for Set Autonomous Mode Test Step
// 
//



/**
 @file
 @internalTechnology
 @test
*/

#ifndef __CT_LBS_STEP_SET_ATA_MODE_H__
#define __CT_LBS_STEP_SET_ATA_MODE_H__

#include "ctlbsstep.h"
#include "ctlbsserver.h"

_LIT(KLbsStep_SetATAMode, "LbsStep_SetATAMode"); 

class CT_LbsStep_SetATAMode: public CT_LbsStep
	{
public:
	static CT_LbsStep_SetATAMode* New(CT_LbsServer& aParent);
	TVerdict doTestStepL();

private:
	CT_LbsStep_SetATAMode(CT_LbsServer& aParent);
	
	TBool SetAndVerifyATAModeL();
	
	};

#endif // __CT_LBS_STEP_SET_ATA_MODE_H__
