/*
* Copyright (c) 2002-2009 Nokia Corporation and/or its subsidiary(-ies).
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



#ifndef __CT_LBS_CLIENT_POS_TP176_H__
#define __CT_LBS_CLIENT_POS_TP176_H__

//  INCLUDES
#include "ctlbsportedstepbase.h"

// CONSTANTS

// FORWARD DECLARATIONS

// CLASS DECLARATION

/**
*  Test procedure 176
*
*/
class CT_LbsClientPosTp176 : public CT_LbsPortedStepBase
    {
    public:  // Constructors and destructor
        
        /**
        * C++ default constructor.
        */
    	CT_LbsClientPosTp176(CT_LbsServer& aParent);
        
        /**
        * Destructor.
        */
        ~CT_LbsClientPosTp176();

    public: // Functions from base classes

        /**
        * From CT_LbsPortedStepBase
        * Called after the tests
        */
        void CloseTest();

        /**
        * From CT_LbsPortedStepBase
        * Called after the tests
        */
        void InitTestL();

        /**
        * From CT_LbsPortedStepBase
        * Runs the test in the module
        */
        void StartL();


    private: 
       
        TBool IsQualityUpdatedL(TUid aUid);

    private:    // Data
        TPositionQuality iQuality;
        TPositionQuality iQualityTestPsy1;

    };

#endif      // __CT_LBS_CLIENT_POS_TP176_H__
            
// End of File
