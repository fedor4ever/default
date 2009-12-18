/*
* Copyright (c) 2005-2009 Nokia Corporation and/or its subsidiary(-ies). 
* All rights reserved.
* This component and the accompanying materials are made available
* under the terms of the License "Symbian Foundation License v1.0"
* which accompanies this distribution, and is available
* at the URL "http://www.symbianfoundation.org/legal/sfl-v10.html".
*
* Initial Contributors:
* Nokia Corporation - initial contribution.
*
* Contributors:
*
* Description:
*
*/


#if (!defined __T_GRAPHICS_WSERV_WSSPRITE_H__)
#define __T_GRAPHICS_WSERV_WSSPRITE_H__

// User Includes
#include "T_DataWsSpriteBase.h"
/**
 * Test Active Notification class
 *
 */
class CT_DataWsSprite : public CT_DataWsSpriteBase
	{
public:
	/**
	* Two phase constructor
	*/
	static CT_DataWsSprite*	NewL();

	/**
	* Public destructor
	*/
	~CT_DataWsSprite();

	/**
	* Return a pointer to the object that the data wraps
	*
	* \return pointer to the object that the data wraps
	*/
	virtual TAny*	GetObject()	{ return iWsSprite; }

	/**
	* Set the object that the data wraps
	*
	* @param	aObject object that the wrapper is testing
	*
	*/
	virtual void	SetObjectL(TAny* aAny);

	/**
	* The object will no longer be owned by this
	*
	* @leave	KErrNotSupported if the the function is not supported
	*/
	virtual void	DisownObjectL();
	virtual TBool	DoCommandL(const TTEFFunction& aCommand, const TTEFSectionName& aSection, const TInt aAsyncErrorIndex);

protected:
	/**
	* Protected constructor. First phase construction
	*/
	CT_DataWsSprite();

	/**
	* Second phase construction
	*/
	void  ConstructL();

	virtual RWsSpriteBase*		GetWsSpriteBase() const{return iWsSprite;}
private:
	void	DestroyData();
    void	DoCmdNewL(const TDesC& aSection);
	void    DoCmdConstructL(const TDesC& aSection);
	void	DoCmdSetPosition(const TDesC& aSection);
	
private:
    RWsSprite* iWsSprite;
	};

#endif /* __T_GRAPHICS_WSERV_WSSPRITE_H__ */
