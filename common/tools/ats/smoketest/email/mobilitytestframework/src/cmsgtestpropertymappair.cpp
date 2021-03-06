// Copyright (c) 2007-2009 Nokia Corporation and/or its subsidiary(-ies).
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

#include "cmsgtestpropertymappair.h"

/**
Class constructor

@param aFlag Flag value
@param aCall Call value
*/
EXPORT_C CMsgTestPropertyMapPair::CMsgTestPropertyMapPair(TMsgTestPropertyMapEntry* aFlag, TMsgTestPropertyMapEntry* aCall)
: flag(aFlag), call(aCall)
	{
	}
