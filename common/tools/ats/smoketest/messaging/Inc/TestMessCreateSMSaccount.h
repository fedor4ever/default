// Copyright (c) 2002-2009 Nokia Corporation and/or its subsidiary(-ies).
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
// TestMessCreateSmsAccount.cpp
// This contains CTestMessCreateSmsAccount which creates an SMS
// account folder for GSM or CDMA
// 
//

#if (!defined __TEST_MESS_CREATE_SMS_ACCOUNT_H__)
#define __TEST_MESS_CREATE_SMS_ACCOUNT_H__

#include "TestMessBase.h"

/**
 This class creates an SMS account folder for GSM or CDMA
*/
class CTestMessCreateSmsAccount : public CTestMessBase
	{
public:
	CTestMessCreateSmsAccount();

	virtual	TVerdict	doTestStepL();
	};

#endif /* __TEST_MESS_CREATE_SMS_ACCOUNT_H__ */
