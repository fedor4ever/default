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

This contains CT_GraphicsFntstoreAPIServer inline functions
*/


/*@{*/
/*@}*/

inline CT_GraphicsFntstoreAPIServer::CT_GraphicsFntstoreAPIBlock::CT_GraphicsFntstoreAPIBlock()
	{
	}

inline CT_GraphicsFntstoreAPIServer::CT_GraphicsFntstoreAPIBlock::~CT_GraphicsFntstoreAPIBlock()
	{
	}

inline CT_GraphicsFntstoreAPIServer::CT_GraphicsFntstoreAPIServer()
	{
	}

inline CT_GraphicsFntstoreAPIServer::~CT_GraphicsFntstoreAPIServer()
	{
	}

inline CTestBlockController*	CT_GraphicsFntstoreAPIServer::CreateTestBlock()
	{
	return new CT_GraphicsFntstoreAPIBlock();
	}
