//
// Copyright (c) 2005-2009 Nokia Corporation and/or its subsidiary(-ies).
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
//

#if (!defined __T_GRAPHICS_BITGDI_API_SERVER_H__)
#define __T_GRAPHICS_BITGDI_API_SERVER_H__

//	User Include
#include "TestServerBase.h"

class CT_GraphicsBitgdiAPIServer : public CTestServerBase
	{
private:
	class CT_GraphicsBitgdiAPIBlock : public CTestBlockController
		{
	public:
		inline CT_GraphicsBitgdiAPIBlock();
		inline ~CT_GraphicsBitgdiAPIBlock();

		CDataWrapper*	CreateDataL(const TDesC& aData);
		};

public:
	inline CT_GraphicsBitgdiAPIServer();
	inline ~CT_GraphicsBitgdiAPIServer();

	static CT_GraphicsBitgdiAPIServer* NewL();

	inline CTestBlockController*	CreateTestBlock();
	};

#include "T_GraphicsBitgdiAPIServer.inl"

#endif /* __T_GRAPHICS_BITGDI_API_SERVER_H__ */
