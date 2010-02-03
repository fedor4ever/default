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

/**
@test
@internalComponent

This contains CT_DataLinkedTypefaceSpecification
*/

#if (!defined __T_DATA_LINKED_TYPEFACE_SPECIFICATION_H__)
#define __T_DATA_LINKED_TYPEFACE_SPECIFICATION_H__

//	User Includes
#include "DataWrapperBase.h"

//	EPOC includes
#include <e32std.h>
#include <linkedfonts.h>

class CT_DataLinkedTypefaceSpecification : public CDataWrapperBase
	{
public:
	
	~CT_DataLinkedTypefaceSpecification();
	static	CT_DataLinkedTypefaceSpecification*	NewL();

	virtual TBool	DoCommandL(const TTEFFunction& aCommand, const TTEFSectionName& aSection, const TInt aAsyncErrorIndex);
	virtual TAny*	GetObject();
	virtual void	SetObjectL(TAny* aObject);
	virtual void	DisownObjectL();
	void			DestroyData();

protected:
	CT_DataLinkedTypefaceSpecification();
	void ConstructL();
	
private:
	void	DoCmdNewL(const TDesC& aSection);
	void	DoCmdDestructor();

private:
	/** CLinkedTypefaceSpecification class instance to work with*/
    CLinkedTypefaceSpecification*	iSpec;
	};

#endif /* __T_DATA_LINKED_TYPEFACE_SPECIFICATION_H__ */
