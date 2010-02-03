/*
* Copyright (c) 2005-2009 Nokia Corporation and/or its subsidiary(-ies). 
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
* Description:
*
*/


#if (!defined __TEST_SERVER_BASE__)
#define __TEST_SERVER_BASE__

//	EPOC includes
#include <testserver2.h>

class CTestServerBase : public CTestServer2
	{
public:
	// CTestServer implementation
	virtual CTestStep*	CreateTestStep(const TDesC& aStepName);
	};

#endif /* __TEST_SERVER_BASE__ */
