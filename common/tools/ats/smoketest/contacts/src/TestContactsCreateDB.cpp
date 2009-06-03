// Copyright (c) 2004-2009 Nokia Corporation and/or its subsidiary(-ies).
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
// This contains CTestContactsCreateDB
// 
//

#include <TestExecuteLog.h>

#include "TestContactsCreateDB.h"

CTestContactsCreateDB::CTestContactsCreateDB()
	{
	SetTestStepName(_L("CreateDB"));
	}

CTestContactsCreateDB::~CTestContactsCreateDB()
	{
	}

// Each test step must supply a implementation for doTestStepL
enum TVerdict CTestContactsCreateDB::doTestStepL()
	{
	// Printing to the console and log file
	INFO_PRINTF1(_L("Contacts CreateDB Test"));

	CreateDatabase();
	CleanupDatabase();

	// test steps return a result
	return TestStepResult();
	}
