/*
* Copyright (c) 2001-2009 Nokia Corporation and/or its subsidiary(-ies).
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




#ifndef __CT_LBS_CLIENT_POS_TP76_H__
#define __CT_LBS_CLIENT_POS_TP76_H__

//  INCLUDES
#include "ctlbsportedstepbase.h"

// FORWARD DECLARATIONS

// CLASS DECLARATION

/**
*  Test procedure 76
*
*/
class CT_LbsClientPosTp76 : public CT_LbsPortedStepBase
    {
    public:  // Constructors and destructor

        /**
        * C++ default constructor.
        */
        CT_LbsClientPosTp76(CT_LbsServer& aParent);

        /**
        * Destructor.
        */
        ~CT_LbsClientPosTp76();

    public: // Functions from base classes

        /**
        * From CT_LbsPortedStepBase
        * Runs the test in the module
        */
        void StartL();

	private: // New functions

        /**
        * Leaves if aCondition is false.
        * @param aCondition something that should be true
        */
        void AssertTrueL(TBool aCondition, const TDesC& errorMsg);

		/**
        * Leaves if aCondition is false.
        * @param aCondition something that should be true
        */
		void AssertTrueSecL(TBool aCondition, const TDesC& aErrorMsg, TInt aErrorCode);

        void CheckModuleInfoL(const TPositionModuleInfo& dbInfo,
                              const TPositionModuleInfo& clientInfo);

    };

#endif      // __CT_LBS_CLIENT_POS_TP76_H__

// End of File
