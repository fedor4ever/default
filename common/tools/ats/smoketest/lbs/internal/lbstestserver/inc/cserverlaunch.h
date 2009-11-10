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
// Definition of class used to launch a LBS server 
// 
//



/**
 @file
 @internalTechnology
*/


#ifndef __LBSSERVERLAUNCH_H__
#define __LBSSERVERLAUNCH_H__

#include <e32base.h>

// forward classes
class TServerStartParams;

class CServerLaunch : public CBase
	{
public:
	static TInt ServerLaunch(TServerStartParams& aParams);
protected:
	static TInt CreateServerProcess(TServerStartParams& aParams);
	};
	
#endif // __LBSSERVERLAUNCH_H__
