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
// @file ctlbsasyncwaiter.cpp
// 
//

// User includes
#include "ctlbsasyncwaiter.h"


/**
  Function : NewL
  Description : Creates an object of CT_LbsAsyncWaiter
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
EXPORT_C CT_LbsAsyncWaiter* CT_LbsAsyncWaiter::NewL()
	{
	CT_LbsAsyncWaiter* self = new(ELeave) CT_LbsAsyncWaiter();
	return self;
	}

	
/**
  Function : CT_LbsAsyncWaiter
  Description : Constructor
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
CT_LbsAsyncWaiter::CT_LbsAsyncWaiter() : CActive(EPriorityStandard)
	{
	CActiveScheduler::Add(this);
	}	


/**
  Function : CT_LbsAsyncWaiter
  Description : Destructor
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
CT_LbsAsyncWaiter::~CT_LbsAsyncWaiter()
	{
	Cancel();
	}

	
/**
  Function : StartAndWait
  Description : Starts the Active scheduler
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
EXPORT_C void CT_LbsAsyncWaiter::StartAndWait()
	{
	SetActive();
	iError = iStatus.Int();
	CActiveScheduler::Start();
	}
	
	
/**
  Function : Result
  Description : Gives the error
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
EXPORT_C TInt CT_LbsAsyncWaiter::Result() const
	{
	return iError;
	}
	
	
/**
  Function : RunL
  Description : 
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
void CT_LbsAsyncWaiter::RunL()
	{
	iError = iStatus.Int();
	CActiveScheduler::Stop();
	}

	
/**
  Function : DoCancel
  Description : 
  @internalTechnology
  @param :
  @return : N/A
  @precondition : none
  @postcondition : none
*/
void CT_LbsAsyncWaiter::DoCancel()
	{
	iError = KErrCancel;
	CActiveScheduler::Stop();
	}
