**Formats for HINTS 5 Cycle 4;
**For more information on formatting see, "How to format HINTS 5 Cycle 4 SAS Data File";

proc format library=INSERT LIBRARY NAME HERE;
        Value $Stratum
            "CA" = "Appalachia Stratum"
            "HM" = "High Minority Areas"
            "LM" = "Low Minority Areas"
        ;
        Value $APP_REG
            "." = "Non-Appalachia"
            "C" = "Central Appalachia"
            "N" = "Northern Appalachia"
            "S" = "Southern Appalachia"
			"A" = "Appalachia"
        ;
        Value DRA
            1 = "In the Mississippi Delta region"
            2 = "Not in the Mississippi Delta region"
        ;
        Value HIGHSPAN
            1 = "Yes"
            2 = "No"
        ;
        Value Treatmen
            1 = "Mail only"
        ;


		 VALUE RUCA2013R
 		           1 = "Metro - Counties in metro areas of 1 million population or more"
 		           2 = "Metro - Counties in metro areas of 250,000 to 1 million population"
 		           3 = "Metro - Counties in metro areas of fewer than 250,000 population"
 		           4 = "Nonmetro - Urban population of 20,000 or more, adjacent to a metro area"
 		           5 = "Nonmetro - Urban population of 20,000 or more, not adjacent to a metro area"
 		           6 = "Nonmetro - Urban population of 2,500 to 19,999, adjacent to a metro area"
 		           7 = "Nonmetro - Urban population of 2,500 to 19,999, not adjacent to a metro area"
 		           8 = "Nonmetro - Completely rural or less than 2,500 urban population"
 		   ;

		Value PR_RUCAR
 		           1 = "Metropolitan"
 		           4 = "Micropolitan"
 		           7 = "Small town"
 		          10 = "Rural"
 		 ;

       Value NCHSURCO
            1 = "Metropolitan: large metro"
            2 = "Metropolitan: large fringe metro"
            3 = "Metropolitan: medium metro"
            4 = "Metropolitan: small metro"
            5 = "Non-metropolitan: micropolitan"
            6 = "Non-metropolitan: noncore"
        ;
      Value CENSDIV
            01 = "New England"
            02 = "Middle Atlantic"
            03 = "East North Central"
            04 = "West North Central"
            05 = "South Atlantic"
            06 = "East South Central"
            07 = "West South Central"
            08 = "Mountain"
            09 = "Pacific"
        ;
        Value CENSREG
            01 = "Northeast"
            02 = "Midwest"
            03 = "South"
            04 = "West"
        ;
        Value $VAR_STR
            "5_4_HM" = "HINTS Cycle 5_4 high minority stratum"
            "5_4_LM" = "HINTS Cycle 5_4 low minority stratum"
        ;
        Value Language
            1 = "English"
            2 = "Spanish"
        ;
        Value QDisp
            1 = "Complete"
            2 = "Partial complete"
        ;
        Value Pandemi
            -1 = "Inapplicable, UpdateDate equal/before 03/11/2020"
            1 = "UpdateDate later than 03/11/2020"
        ;
        Value AdultsI
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value MailHHA
            -1 = "Inapplicable, coded 2 in AdultsInHH"
            -2 = "Question answered in error (Commission Error)"
            -4 = "Unreadable or Non-conforming numeric response"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            00-74 = "Number of adults living in the household"
        ;
        Value SeekCan
            -9 = "Missing data"
            1 = "Yes"
            2 = "No"
        ;
        Value CancerL
            -1 = "Inapplicable, coded 2 in CancerSeekInfo"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Strongly agree"
            2 = "Somewhat agree"
            3 = "Somewhat disagree"
            4 = "Strongly disagree"
        ;
        Value CancerC
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Completely confident"
            2 = "Very confident"
            3 = "Somewhat confident"
            4 = "A little confident"
            5 = "Not confident at all"
        ;
        Value CancerT
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "A lot"
            2 = "Some"
            3 = "A little"
            4 = "Not At All"
        ;
        Value StrongF
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Books"
            10 = "Newspapers"
            11 = "Telephone information number"
            12 = "Complementary, alternative, or unconventional practitioner"
            2 = "Brochures, pamphlets, etc."
            3 = "Cancer organization"
            4 = "Family"
            5 = "Friend/Co-worker"
            6 = "Doctor or health care provider"
            7 = "Internet"
            8 = "Library"
            9 = "Magazines"
            91 = "Other - Specify:"
        ;
        Value $StrongN
            "-1" = "Inapplicable, 91 not selected in StrongNeedHealthInfo"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data (Not Ascertained)"
            "A"-"Z" = "Verbatim response"
        ;
        Value UseInte
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value Interne
            -1 = "Inapplicable, coded 2 in UseInternet"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value WhereUs
            -1 = "Inapplicable, coded 2 in UseInternet"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Daily"
            2 = "Sometimes"
            3 = "Never"
            4 = "Not applicable"
        ;
        Value InternF
            -1 = "Inapplicable, coded 2 in UseInternet"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Not at all satisfied"
            2 = "Not very satisfied"
            3 = "Somewhat satisfied"
            4 = "Very satisfied"
            5 = "Extremely satisfied"
        ;
        Value Electro
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value HaveDev
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value HaveDeF
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value HaveDeG
            -9 = "Missing data (Not Ascertained)"
            1 = "Tablet computer only"
            2 = "Smartphone only"
            3 = "Basic cell phone only"
            4 = "None"
            5 = "Multiple devices selected"
        ;
        Value TabletH
            -1 = "Inapplicable, coded 1 in HaveDevice_CellPh or coded 1 in HaveDevice_None"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Don't know"
        ;
        Value UsedHea
            -1 = "Inapplicable, coded 2 in UseInternet"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Don't Know"
        ;
        Value Tablet_
            -1 = "Inapplicable, coded 1 in HaveDevice_CellPh or coded 1 in HaveDevice_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value Wearabl
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value FreqWea
            -1 = "Inapplicable, coded 1 in WearableDevTrackHealth"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Everyday"
            2 = "Almost everyday"
            3 = "1-2 times per week"
            4 = "Less than once per week"
            5 = "I did not use a wearable device in the past month"
        ;
        Value Willing
            -1 = "Inapplicable, coded 1 in WearableDevTrackHealth"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value SharedH
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Not Applicable"
        ;
        Value FreqGoP
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            0 = "None"
            1 = "1 time"
            2 = "2 times"
            3 = "3 times"
            4 = "4 times"
            5 = "5-9 times"
            6 = "10 or more times"
        ;
        Value Quality
            -1 = "Inapplicable, coded 0 in FreqGoProvider"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Excellent"
            2 = "Very good"
            3 = "Good"
            4 = "Fair"
            5 = "Poor"
        ;
        Value ChanceA
            -1 = "Inapplicable, coded 0 in FreqGoProvider"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Always"
            2 = "Usually"
            3 = "Sometimes"
            4 = "Never"
        ;
        Value ProbCar
            -1 = "Inapplicable, coded 0 in FreqGoProvider"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value HealthF
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value $HealthI
            "-1" = "Inapplicable, coded 2 in HealthIns_Other"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data (Not Ascertained)"
            "A"-"Z" = "Verbatim response"
        ;
        Value Provide
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Don't know"
        ;
        Value HCPEnco
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value AccessO
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            0 = "None"
            1 = "1 to 2 times"
            2 = "3 to 5 times"
            3 = "6 to 9 times"
            4 = "10 or more times"
        ;
        Value NotAcce
            -1 = "Inapplicable, coded 1-4 in AccessOnlineRecord"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value Records
            -1 = "Inapplicable, coded 0 in AccessOnlineRecord"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value HowAcce
            -1 = "Inapplicable, coded 0 in AccessOnlineRecord"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "App"
            2 = "Website"
            3 = "Both app and website"
            4 = "Don't Know"
        ;
        Value OnlineR
            -1 = "Inapplicable, coded 0 in AccessOnlineRecord"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Don't know"
        ;
        Value Underst
            -1 = "Inapplicable, coded 0 in AccessOnlineRecord"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Very easy"
            2 = "Somewhat easy"
            3 = "Somewhat difficult"
            4 = "Very difficult"
        ;
        Value CaregiK
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value CaregiL
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes, a child/children only"
            2 = "Yes, a spouse/partner only"
            3 = "Yes, a parent/parents only"
            5 = "Yes, a friend or other non-relative only"
            6 = "No only"
            7 = "Multiple caregiving relationships selected"
            8 = "Yes, another family member only"
        ;
        Value Caregiv
            -1 = "Inapplicable, coded 1 Caregiving_No"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value CaregiG
            -1 = "Inapplicable, coded 1 Caregiving_No"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value CaregiH
            -1 = "Inapplicable, coded 1 Caregiving_No"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value $CaregiJ
            "-1" = "Inapplicable, coded 1 Caregiving_No or coded 2 in Caregiving_Other"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data (Not Ascertained)"
            "A"-"Z" = "Verbatim response"
        ;
        Value CaregiI
            -1 = "Inapplicable, coded 1 Caregiving_No"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Cancer only"
            10 = "Multiple caregiving conditions selected"
            2 = "Alzheimer's, confusion, dementia, forgetfulness only"
            3 = "Orthopedic/Musculoskeletal Issues only"
            4 = "Mental health/Behavioral/Substance Abuse Issues only"
            5 = "Chronic Conditions only"
            6 = "Neurological/Developmental Issues only"
            7 = "Acute Conditions only"
            8 = "Aging/Aging related health issues only"
            9 = "Not sure/Don't know only"
            91 = "Other (Specify) only"
        ;
        Value CaregiF
            -1 = "Inapplicable, coded 1 Caregiving_No"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            0 = "None"
            1 = "1 to 2 times"
            2 = "3 to 5 times"
            3 = "6 to 9 times"
            4 = "10 or more times"
            5 = "Care recipient does not have an online medical record"
        ;
        Value HeardGF
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data"
            1 = "Selected"
            2 = "Not Selected"
        ;
        Value $HeardGe
            "-1" = "Inapplicable, coded 2 HeardGenTest_Other"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data"
            "A"-"Z" = "Verbatim Response"
        ;
        Value HeardGG
            -9 = "Missing data"
            1 = "Selected"
            2 = "Not Selected"
        ;
        Value HeardGH
            -9 = "Missing data (Not Ascertained)"
            1 = "Ancestry testing only"
            2 = "Genetic health risk testing only"
            3 = "High risk cancer testing only"
            4 = "Not sure only"
            5 = "None only"
            6 = "Multiple genetic tests selected"
            91 = "Other (Specify) only"
        ;
        Value TestSou
            -1 = "Inapplicable, coded 1 HeardGenTest_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data"
            1 = "Selected"
            2 = "Not Selected"
        ;
        Value $TestSoF
            "-1" = "Inapplicable, coded 1 HeardGenTest_None or coded 2 in TestSource_Other"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data"
            "A"-"Z" = "Verbatim Response"
        ;
        Value TestSoG
            -1 = "Inapplicable, coded 1 HeardGenTest_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Newspaper only"
            10 = "Have not heard of such tests only"
            11 = "Not sure only"
            12 = "Multiple sources selected"
            13 = "Genetic counselor only"
            14 = "Friend only"
            2 = "Magazine only"
            3 = "Radio only"
            4 = "Your health care provider only"
            5 = "Family member only"
            6 = "Social media only"
            7 = "Television only"
            8 = "Internet only"
            91 = "Other (Specify) only"
        ;
        Value $HadTesG
            "-1" = "Inapplicable, coded 1 HeardGenTest_None or coded 2 in HadTest2_Other"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data"
            "A"-"Z" = "Verbatim Response"
        ;
        Value HadTest
            -1 = "Inapplicable, coded 1 HeardGenTest_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data"
            1 = "Selected"
            2 = "Not Selected"
        ;
        Value HadTesF
            -1 = "Inapplicable, coded 1 HeardGenTest_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            10 = "Multiple genetic tests selected"
            11 = "Genetic health risk testing only"
            12 = "High risk cancer testing only"
            13 = "None of the above only"
            2 = "Ancestry testing only"
            8 = "Not sure only"
            91 = "Other (Specify) only"
        ;
        Value SharedR
            -1 = "Inapplicable, coded 1 HeardGenTest_None or coded 1 in HadTest2_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not Selected"
        ;
        Value SharedF
            -1 = "Inapplicable, coded 1 HeardGenTest_None or coded 1 in HadTest2_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Your health care provider only"
            2 = "Genetic Counselor only"
            3 = "Spouse/partner only"
            4 = "Parents only"
            5 = "Siblings only"
            6 = "Children only"
            7 = "Friend only"
            8 = "Did not share the results only"
            9 = "Multiple people selected"
            91 = "Other only"
        ;
        Value UndGenT
            -1 = "Inapplicable, coded 1 HeardGenTest_None or coded 1 in HadTest2_None"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Your health care provider only"
            2 = "Genetic Counselor only"
            3 = "Spouse only"
            4 = "Parents only"
            5 = "Siblings only"
            6 = "Children only"
            7 = "Friend only"
            8 = "No one helped me understand the results only"
            9 = "Multiple genetic testing selected"
            91 = "Other only"
        ;
        Value Genetic
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "A lot"
            2 = "Somewhat"
            3 = "A little"
            4 = "Not At All"
        ;
        Value KnowGen
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Very"
            2 = "Somewhat"
            3 = "A little"
            4 = "Not At All"
        ;
        Value ClinicF
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "I don't know anything about clinical trials"
            2 = "I know a little bit about clinical trials"
            3 = "I know a lot about clinical trials"
        ;
        Value ClinTri
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "A lot"
            2 = "Somewhat"
            3 = "A little"
            4 = "Not at all"
        ;
        Value FirstIn
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "My health care provider"
            2 = "My family and friends"
            3 = "Government health agencies"
            4 = "Health organizations or groups (for example, the American Cancer Society,"
            5 = "Diseaese-specific patient support groups"
            6 = "Drug companies"
            7 = "Internet search"
        ;
        Value TrustIn
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "My health care provider"
            2 = "My family and friends"
            3 = "Government health agencies"
            4 = "Health organizations or groups (for example, the American Cancer Society,"
            5 = "Disease-specific patient support groups"
            6 = "Drug companies"
        ;
        Value Invited
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "I didn't know/I don't remember"
        ;
        Value Partici
            -1 = "Inapplicable, coded 2 or 3 in InvitedClinTrial"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "I don't remember"
        ;
        Value General
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Excellent,"
            2 = "Very good,"
            3 = "Good,"
            4 = "Fair, or"
            5 = "Poor?"
        ;
        Value HeightF
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            4-7 = "Height, in feet"
        ;
        Value Height_
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            00-11 = "Height, in inches"
        ;
        Value Weight
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            040-500 = "Weight, in pounds"
        ;
        Value LittleI
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Nearly every day"
            2 = "More than half the days"
            3 = "Several days"
            4 = "Not at all"
        ;
        Value Threate
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Strongly agree"
            2 = "Somewhat agree"
            3 = "Somewhat disagree"
            4 = "Strongly disagree"
        ;
        Value ExpectW
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Strongly agree"
            2 = "Agree"
            3 = "Neither agree nor disagree"
            4 = "Disagree"
            5 = "Strongly disagree"
        ;
        Value MostImp
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Making my own decisions"
            2 = "Being happy"
            3 = "Helping people"
            4 = "Being loyal to family and friends"
            5 = "Having a deep connection to my religion"
            6 = "Keeping myself in good health"
            7 = "Assuring my family is safe and secure"
        ;
        Value JunkFoo
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Strongly oppose"
            2 = "Oppose"
            3 = "Neither support nor oppose"
            4 = "Support"
            5 = "Strongly support"
        ;
        Value DrinkDa
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            0 = "None"
            1-7 = "Days per week"
        ;
        Value DrinksP
            -1 = "Inapplicable, coded 0 in DrinkDaysPerWeek"
            -2 = "Question answered in error (Commission Error)"
            -4 = "Unreadable or Non-conforming numeric response"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            00-99 = "Drinks per day"
        ;
        Value DrinksO
            -1 = "Inapplicable, coded 0 in DrinkDaysPerWeek"
            -2 = "Question answered in error (Commission Error)"
            -4 = "Unreadable or Non-conforming numeric response"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Never"
            2 = "1 or 2 times"
            3 = "3 to 5 times"
            4 = "6 to 10 times"
            5 = "11 or more times"
        ;
        Value Beer_Ca
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Decrease risk a lot"
            2 = "Decrease risk a little"
            3 = "No effect"
            4 = "Increase risk a little"
            5 = "Increase risk a lot"
            6 = "Don't know"
        ;
        Value Excessi
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Strongly oppose"
            2 = "Oppose"
            3 = "Neither support not oppose"
            4 = "Support"
            5 = "Strongly support"
        ;
        Value TimesMo
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            0 = "None"
            1 = "1 day per week"
            2 = "2 days per week"
            3 = "3 days per week"
            4 = "4 days per week"
            5 = "5 days per week"
            6 = "6 days per week"
            7 = "7 days per week"
        ;
        Value HowLong
            -1 = "Inapplicable, coded 0 in TimesModerateExercise"
            -2 = "Question answered in error (Commission Error)"
            -4 = "Unreadable or Non-conforming numeric response"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            000-999 = "Minutes of exercise time per day"
        ;
        Value TimesSt
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            0 = "None"
            1 = "1 day per week"
            2 = "2 days per week"
            3 = "3 days per week"
            4 = "4 days per week"
            5 = "5 days per week"
            6 = "6 days per week"
            7 = "7 days per week"
        ;
        Value Average
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            00-24 = "Hours per day"
        ;
        Value Smoke1F
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value SmokeNo
            -1 = "Inapplicable, coded 2 in Smoke100"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Everyday"
            2 = "Some days"
            3 = "Not at all"
        ;
        Value ElectCi
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Much less harmful"
            2 = "Less harmful"
            3 = "Just as harmful"
            4 = "More harmful"
            5 = "Much more harmful, or"
            7 = "I don't know"
        ;
        Value UsedECi
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value UseECig
            -1 = "Inapplicable, coded 2 in UsedEcCigEver"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Every day"
            2 = "Some days"
            3 = "Not at all"
        ;
        Value HeardHe
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "I have never heard of heated tobacco products"
            2 = "I have heard of heated tobacco products but have never tried them"
            3 = "I have tried heated tobacco products but do not use them anymore"
            4 = "I currently use heated tobacco products"
            5 = "Don't know"
        ;
        Value SeenFed
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value Tobacco
            -1 = "Inapplicable, coded 2 in SeenFederalCourtTobaccoMessages2"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value TobaccF
            -1 = "Inapplicable, coded 2 in SeenFederalCourtTobaccoMessages2"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Federal Court ordered tobacco messages: health effects of smoking only"
            2 = "Federal Court ordered tobacco messages: health effects secondhand smoke only"
            3 = "Federal Court ordered tobacco messages: addictiveness only"
            4 = "Federal Court ordered tobacco messages: enhance delivery only"
            5 = "Federal Court ordered tobacco messages: low tar and light cigarettes only"
            6 = "Multiple Federal Court ordered tobacco messages selected"
        ;
        Value DrTalkL
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Don't Know"
        ;
        Value WhenPap
            -1 = "Inapplicable, coded 1 in BirthGender"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "A year ago or less"
            2 = "More than 1, up to 2 years ago"
            3 = "More than 2, up to 3 years ago"
            4 = "More than 3, up to 5 years ago"
            5 = "More than 5 years ago"
            6 = "I have never had a Pap test"
        ;
        Value WhenMam
            -1 = "Inapplicable, coded 1 in GenderC"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "A year ago or less"
            2 = "More than 1, up to 2 years ago"
            3 = "More than 2, up to 3 years ago"
            4 = "More than 3, up to 5 years ago"
            5 = "More than 5 years ago"
            6 = "I have never had a mammogram"
        ;
        Value HeardHP
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value HPVCaus
            -1 = "Inapplicable, coded 2 in HeardHPV"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Not sure"
        ;
        Value FreqWor
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Not at all"
            2 = "Slightly"
            3 = "Somewhat"
            4 = "Moderately"
            5 = "Extremely"
        ;
        Value CaInflu
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "A lot"
            2 = "A little"
            3 = "Not at all"
            4 = "Don't know"
        ;
        Value EverHad
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value CaBladd
            -1 = "Inapplicable, coded 2 in EverHadCancer"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not selected"
        ;
        Value CaOther
            -1 = "Inapplicable, coded 2 in EverHadCancer"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected - Specify"
            2 = "Not selected"
        ;
        Value $CaOtheF
            "-1" = "Inapplicable, coded 2 in EverHadCancer or coded 2 in CaOther"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data (Not Ascertained)"
            "A"-"Z" = "Verbatim response"
        ;
        Value Cancer_
            -1 = "Inapplicable, coded 2 in EverHadCancer"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Bladder cancer only"
            10 = "Leukemia only"
            11 = "Liver cancer only"
            12 = "Lung cancer only"
            13 = "Melanoma only"
            14 = "Non-Hodgkins only"
            15 = "Oral cancer only"
            16 = "Ovarian cancer only"
            17 = "Pancreatic cancer only"
            18 = "Pharyngeal cancer only"
            19 = "Prostate cancer only"
            2 = "Bone cancer only"
            20 = "Rectal cancer only"
            22 = "Skin cancer only"
            23 = "Stomach cancer only"
            25 = "More than one cancer checked"
            3 = "Breast cancer only"
            4 = "Cervical cancer only"
            5 = "Colon cancer only"
            6 = "Endometrial cancer only"
            7 = "Head/Neck cancer only"
            8 = "Hodgkins only"
            9 = "Renal cancer only"
            91 = "Other cancer only"
        ;
        Value WhenDia
            -1 = "Inapplicable, coded 2 in EverHadCancer"
            -2 = "Question answered in error (Commission Error)"
            -4 = "Unreadable or Non-conforming numeric response"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            000-101 = "Age at diagnosis"
        ;
        Value Discuss
            -1 = "Inapplicable, coded 2 in EverHadCancer"
            -2 = "Question answered in error (Commission Error)"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
        ;
        Value Clinica
            -1 = "Inapplicable, coded 2 in EverHadCancer"
            -2 = "Question answered in error (Commission Error)"
            -5 = "Multiple responses selected in error"
            -6 = "Missing data (Filter Missing)"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Don't Know"
        ;
        Value Familia
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Very well"
            2 = "Well"
            3 = "Somewhat"
            4 = "A little"
            5 = "Not at all"
        ;
        Value FamilyE
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Yes"
            2 = "No"
            3 = "Not sure"
        ;
        Value Age
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            18-106 = "Current age, in years"
        ;
        Value BirthGe
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Male"
            2 = "Female"
        ;
        Value OccupaF
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected - Specify"
            2 = "Not selected"
        ;
        Value $Occupat
            "-1" = "Inapplicable, coded 2 in Occupation_Other"
            "-2" = "Question answered in error (Commission Error)"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data (Not Ascertained)"
            "A"-"Z" = "Verbatim response"
        ;
        Value OccupaG
            -9 = "Missing data (Not Ascertained)"
            1 = "Employed only"
            3 = "Homemaker only"
            4 = "Student only"
            5 = "Retired only"
            6 = "Disabled only"
            7 = "Multiple Occupation statuses selected"
            8 = "Unemployed for 1 year or more only"
            9 = "Unemplyed for less than 1 year only"
            91 = "Other Occupation only"
        ;
        Value FullTim
            -4 = "Unreadable or Non-conforming numeric response (Illogical P4/P5 response combination)"
            -9 = "Missing data (Not Ascertained) (P4 or P5 are missing))"
            1 = "Employed full time"
            2 = "Employed part time"
            3 = "Homemaker"
            4 = "Student"
            5 = "Retired"
            6 = "Disabled"
            7 = "Unemployed less than 1 year"
            8 = "Unemployed 1 year or more"
            9 = "Other"
        ;
        Value Marital
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Married"
            2 = "Living as married or living with a romantic partner"
            3 = "Divorced"
            4 = "Widowed"
            5 = "Separated"
            6 = "Single, never been married"
        ;
        Value Educati
            -9 = "Missing data (Not Ascertained)"
            1 = "Less than 8 years"
            2 = "8 through 11 years"
            3 = "12 years or completed high school"
            4 = "Post high school training other than college (vocational or technical)"
            5 = "Some college"
            6 = "College graduate"
            7 = "Postgraduate"
        ;
        Value Hisp_Ca
            -9 = "Missing data (Not Ascertained)"
            10 = "Not Hispanic only"
            21 = "Mexican only"
            22 = "Puerto Rican only"
            23 = "Cuban only"
            24 = "Other Hispanic only"
            25 = "Multiple Hispanic ethnicities selected"
        ;
        Value White
            -9 = "Missing data (Not Ascertained)"
            1 = "Selected"
            2 = "Not Selected"
        ;
        Value Race_Ca
            -9 = "Missing data (Not Ascertained)"
            11 = "White only"
            12 = "Black only"
            14 = "American Indian or Alaska Native only"
            16 = "Multiple races selected"
            31 = "Asian Indian only"
            32 = "Chinese only"
            33 = "Filipino only"
            34 = "Japanese only"
            35 = "Korean only"
            36 = "Vietnamese only"
            37 = "Other Asian only"
            51 = "Native Hawaiian only"
            52 = "Guamanian or Chamorro only"
            53 = "Samoan only"
            54 = "Other Pacific Islander only"
        ;
        Value SexualF
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Heterosexual, or straight"
            2 = "Homosexual, or gay or lesbian"
            3 = "Bisexual"
            91 = "Something else - Specify"
        ;
        Value $SexualO
            "-1" = "Inapplicable, coded 1, 2, or 3 in SexualOrientation"
            "-2" = "Question answered in error (Commission Error)"
            "-4" = "Unreadable or Non-conforming numeric response"
            "-6" = "Missing data (Filter Missing)"
            "-9" = "Missing data (Not Ascertained)"
            "A"-"Z" = "Verbatim response"
        ;
        Value TotalHo
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            00-75 = "Number of people"
        ;
        Value R_HHAdul
            . = "Missing value"
            01-75 = "Number of adults"
        ;
        Value HHAdults
            01-75 = "Number of adults"
        ;
        Value SelfAge
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            018-106 = "Age, in years"
        ;
        Value SelfMOB
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            1 = "January"
            10 = "October"
            11 = "November"
            12 = "December"
            2 = "February"
            3 = "March"
            4 = "April"
            5 = "May"
            6 = "June"
            7 = "July"
            8 = "August"
            9 = "September"
        ;
        Value HHAdulM
            -1 = "Inapplicable, Fewer than 2 adults in HH"
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Male"
            2 = "Female"
        ;
        Value HHAdulH
            -1 = "Inapplicable, Fewer than 2 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            018-106 = "Age, in years"
        ;
        Value HHAdulI
            -1 = "Inapplicable, Fewer than 2 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            1 = "January"
            10 = "October"
            11 = "November"
            12 = "December"
            2 = "February"
            3 = "March"
            4 = "April"
            5 = "May"
            6 = "June"
            7 = "July"
            8 = "August"
            9 = "September"
        ;
        Value HHAdulN
            -1 = "Inapplicable, Fewer than 3 adults in HH"
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Male"
            2 = "Female"
        ;
        Value HHAdult
            -1 = "Inapplicable, Fewer than 3 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            018-100 = "Age, in years"
        ;
        Value HHAdulJ
            -1 = "Inapplicable, Fewer than 3 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            1 = "January"
            10 = "October"
            11 = "November"
            12 = "December"
            2 = "February"
            3 = "March"
            4 = "April"
            5 = "May"
            6 = "June"
            7 = "July"
            8 = "August"
            9 = "September"
        ;
        Value HHAdulO
            -1 = "Inapplicable, Fewer than 4 adults in HH"
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Male"
            2 = "Female"
        ;
        Value HHAdulF
            -1 = "Inapplicable, Fewer than 4 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            018-100 = "Age, in years"
        ;
        Value HHAdulK
            -1 = "Inapplicable, Fewer than 4 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            1 = "January"
            10 = "October"
            11 = "November"
            12 = "December"
            2 = "February"
            3 = "March"
            4 = "April"
            5 = "May"
            6 = "June"
            7 = "July"
            8 = "August"
            9 = "September"
        ;
        Value HHAdulP
            -1 = "Inapplicable, Fewer than 5 adults in HH"
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Male"
            2 = "Female"
        ;
        Value HHAdulG
            -1 = "Inapplicable, Fewer than 5 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            018-100 = "Age, in years"
        ;
        Value HHAdulL
            -1 = "Inapplicable, Fewer than 5 adults in HH"
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            1 = "January"
            10 = "October"
            11 = "November"
            12 = "December"
            2 = "February"
            3 = "March"
            4 = "April"
            5 = "May"
            6 = "June"
            7 = "July"
            8 = "August"
            9 = "September"
        ;
        Value Childre
            -4 = "Unreadable or Non-conforming numeric response"
            -9 = "Missing data (Not Ascertained)"
            00-12 = "Number of children under 18"
        ;
        Value Politic
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Very Liberal"
            2 = "Liberal"
            3 = "Somewhat liberal"
            4 = "Moderate"
            5 = "Somewhat Conservative"
            6 = "Conservative"
            7 = "Very Conservative"
        ;
        Value IncomeR
            -9 = "Missing data (Not Ascertained)"
            1 = "$0 to $9,999"
            2 = "$10,000 to $14,999"
            3 = "$15,000 to $19,999"
            4 = "$20,000 to $34,999"
            5 = "$35,000 to $49,999"
            6 = "$50,000 to $74,999"
            7 = "$75,000 to $99,999"
            8 = "$100,000 to $199,999"
            9 = "$200,000 or more"
        ;
        Value IncomeF
            -5 = "Multiple responses selected in error"
            -9 = "Missing data (Not Ascertained)"
            1 = "Living comfortably on present income"
            2 = "Getting by on present income"
            3 = "Finding it difficult on present income"
            4 = "Finding it very difficult on present income"
        ;

    
				value AgeGrpA 
					1 = '18-34'
					2 = '35-39'
					3 = '40-44'
					4 = '45+'
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-9 = 'Missing Data (Not Ascertained)'				;
		
					value AgeGrpB 
					1 = '18-34'
					2 = '35-49'
					3 = '50-64'
					4 = '65-74'
					5 = '75+'
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-9 = 'Missing Data (Not Ascertained)'				;
		
					value EducA 
					1 = 'Less than High School'
					2 = 'High School Graduate'
					3 = 'Some College'
					4 = 'College Graduate or More'
					-9 = 'Missing Data (Not Ascertained)'				;
		
					value EducB 
					1 = 'Less than High School'
					2 = 'High School Graduate'
					3 = 'Some College'
					4 = "Bachelor's Degree"
					5 = 'Post-Baccalaureate Degree'
					-9 = 'Missing Data (Not Ascertained)'				;
		
					value RaceEthn 
					1 = 'Hispanic'
					2 = 'Non-Hispanic White'
					3 = 'Non-Hispanic Black or African American'
					4 = 'Non-Hispanic American Indian or Alaska Native'
					5 = 'Non-Hispanic Asian'
					6 = 'Non-Hispanic Native Hawaiian or other Pacific Islander'
					7 = 'Non-Hispanic Multiple Races Mentioned'
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-9 = 'Missing Data (Not Ascertained)'					;
		
					value RaceEthn5f 
					1 = "Non-Hispanic White"
					2= "Non-Hispanic Black or African American"
					3="Hispanic"
					4="Non-Hispanic Asian"
					5="Non-Hispanic Other"
					-9="Missing Data--Not Ascertained"
					;
		
					value HHInc 
					1 = 'Less than $20,000'
					2 = '$20,000 to < $35,000'
					3 = '$35,000 to < $50,000'
					4 = '$50,000 to < $75,000'
					5 = '$75,000 or More'
					-5 = 'Multiple Responses Selected in Error'
					-9 = 'Missing Data (Not Ascertained)'				;
		
					value BMI 
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-9 = 'Missing Data (Not Ascertained)'			;
		
					value AgeDX 
					-1 = 'Inapplicable, coded 2 in EverHadCancer'
					-2 = 'Question Answered in Error (Commission Error)'
					-4 = 'Unreadable or Non-conforming numeric response'
					-6 = 'Missing Data (Filter Missing)'
					-9 = 'Missing Data (Not Ascertained)'				;
		
					value TimeSinceDX 
					1 = 'Less than 1 Yr Since DX'
					2 = '2-5 Yrs Since DX'
					3 = '6-10 Yrs Since DX'
					4 = '11+ Yrs Since DX'
					-1 = 'Inapplicable, coded 2 in EverHadCancer'
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-6 = 'Missing Data (Filter Missing), coded -9 in EverHadCancer'
					-9 = 'Missing Data (Not Ascertained)'					;
		
					value smokeStat 
					1 = 'Current'
					2 = 'Former'
					3 = 'Never'
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-6 = 'Missing Data (Filter Missing), coded -9 in Smoke100'
					-9 = 'Missing Data (Not Ascertained)'					;
		
					value phq4f
					-5 = 'Multiple Responses Selected in Error'
					-9 = 'Missing Data (Not Ascertained)'
					;
		
					value WeeklyMinutesModerateExercise
					-5 = 'Multiple Responses Selected in Error'
					-9 = 'Missing Data (Not Ascertained)'
					;
		
					value ecigStat 
					1 = 'Current'
					2 = 'Former'
					3 = 'Never'
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-6 = 'Missing Data (Filter Missing), coded -9 in UsedECigEver'
					-9 = 'Missing Data (Not Ascertained)';
		
					value AvgDrinksPerWeek
					-4 = 'Unreadable or Nonconforming Numeric Response'
					-5 = 'Multiple Responses Selected in Error'
					-9 = 'Missing Data (Not Ascertained)'
					;
                    
					value pccscale
					-9 = 'Missing data (Not Ascertained)'
					;

run;
