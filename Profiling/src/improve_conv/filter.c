#ifndef filter_header
#define filter_header 
#include "header.h"

double filter[][5][1][32]=
	{
	{
	{{ 0.06799895,  0.06714036, -0.08655059, -0.04534899,
           0.03968095, -0.04632151, -0.01081733,  0.04869574,
           0.01298015,  0.01209889,  0.04807389, -0.24224836,
          -0.10345212,  0.07282081,  0.02092658, -0.06289458,
           0.03757244, -0.06766793,  0.05128751,  0.08837315,
           0.07355231, -0.00679912,  0.1830766 , -0.10095383,
           0.04666106, -0.19477166,  0.01639977, -0.06557522,
           0.07817177,  0.03822823,  0.02954637,  0.02572026}},

        {{ 0.02703113,  0.0928981 , -0.0492412 ,  0.05207908,
          -0.14634596, -0.08842379,  0.00496002,  0.11583352,
           0.16801043, -0.00295869,  0.03747047, -0.22393721,
           0.03391488, -0.08270074,  0.06659885,  0.09278375,
           0.01752991, -0.03437933, -0.14794444,  0.08469858,
           0.08858262, -0.087552  ,  0.20011571, -0.18874587,
          -0.05434074, -0.18811442, -0.05056431,  0.07065765,
          -0.00257655,  0.06282458,  0.13408169,  0.12025852}},

        {{-0.04734179, -0.03130693,  0.00151849, -0.0434353 ,
          -0.16541131, -0.19496752, -0.14742067,  0.03422216,
           0.20975767, -0.00571346,  0.11803731, -0.25970387,
          -0.04804613, -0.06901404,  0.07675267,  0.02694841,
           0.05190283, -0.0998723 , -0.12846133, -0.03468212,
           0.12520857,  0.00664175,  0.13819529, -0.12732022,
          -0.06070416, -0.08086363, -0.13189656,  0.06476514,
          -0.05422473,  0.09528772,  0.10366364,  0.15414725}},

        {{ 0.04601809, -0.1238003 ,  0.01438532, -0.0138549 ,
          -0.02022417, -0.2583231 , -0.06340586,  0.16827329,
           0.09608281, -0.04095787,  0.13851157, -0.10709504,
          -0.00904381,  0.09243231,  0.01122571, -0.02408429,
           0.07777984,  0.06779172, -0.007277  ,  0.02655362,
           0.02288616, -0.08142833,  0.06211533,  0.05907604,
           0.0515628 , -0.01416102, -0.02928635, -0.09909332,
          -0.079608  , -0.12573555,  0.19136502,  0.14329508}},

        {{ 0.0420898 , -0.1696268 , -0.03608751, -0.0394672 ,
           0.14887773, -0.11051268, -0.10133789,  0.136958  ,
           0.13775283, -0.02540124,  0.08709006, -0.1547127 ,
          -0.10336717,  0.09804174,  0.05734242, -0.08446122,
          -0.11300455,  0.08732841,  0.16436405, -0.07199654,
           0.1097948 , -0.02537254, -0.01449234,  0.04531845,
           0.10543857,  0.10996311,  0.01190045, -0.07569486,
          -0.01924703, -0.13366838,  0.15893205,  0.04962878}}
	},


       {
	{{-0.03960815,  0.06910821, -0.00064598,  0.02196542,
          -0.00994225,  0.14054732,  0.03026928,  0.12451589,
          -0.04446456, -0.16788946, -0.00666198, -0.22092023,
           0.06316888,  0.05579213,  0.1287883 , -0.00735491,
           0.15070298, -0.06246675,  0.05435412, -0.01129287,
           0.13612542, -0.0074326 ,  0.07329493, -0.12954438,
           0.10499402, -0.09130382, -0.03370841,  0.00449312,
           0.00481129,  0.161776  ,  0.02442409,  0.15528063}},

        {{ 0.08475651,  0.08058108, -0.15671529, -0.04254992,
          -0.09265859,  0.07271167, -0.06020408,  0.03594739,
          -0.0856014 , -0.14708644,  0.13699193, -0.24473292,
           0.03911861,  0.07206852,  0.15098864,  0.06923258,
           0.09031244, -0.04763609, -0.1425024 ,  0.07987723,
           0.0028032 , -0.09971324,  0.19716467, -0.03052721,
           0.16654842, -0.15357031, -0.07339751,  0.10109297,
          -0.01076015,  0.01907085,  0.15990016,  0.14746256}},

        {{ 0.07289841,  0.11119524, -0.23186216, -0.02729653,
           0.07224223,  0.03793997, -0.10046939,  0.17786212,
           0.10862309, -0.08593173,  0.065327  , -0.16950709,
          -0.04255334,  0.00656641, -0.04258294,  0.00909064,
          -0.04582878,  0.09069557, -0.1938825 , -0.05574597,
           0.10352381,  0.11032239,  0.0363498 , -0.05450063,
           0.16306522,  0.08150299, -0.10605302, -0.00509246,
           0.05025672,  0.00588129,  0.08738612,  0.13844596}},

        {{ 0.04432097, -0.07970834, -0.18172213, -0.06461485,
           0.15182891, -0.17102158, -0.17161518,  0.0509661 ,
           0.15123837,  0.07800788,  0.16511899, -0.22737181,
           0.0441454 ,  0.05764575, -0.1372516 , -0.02287831,
          -0.10415212,  0.07695068, -0.03392257, -0.19573148,
           0.0636623 ,  0.0738567 ,  0.0322298 ,  0.07962567,
           0.05834124,  0.14019157,  0.02111505, -0.01814087,
          -0.14067753, -0.07347072,  0.01121579,  0.04352165}},

        {{ 0.07416386, -0.10079827, -0.11522197, -0.10891289,
           0.16409332, -0.21252567, -0.11463271,  0.16445926,
           0.15474494, -0.00264431,  0.05010616, -0.20365222,
           0.03235663, -0.03588034, -0.15010373, -0.09603509,
           0.00938657,  0.05314055,  0.15056445, -0.17860855,
           0.08163083,  0.04333622, -0.08923291,  0.04462679,
           0.04711918,  0.00517015,  0.01677892, -0.16525681,
          -0.12781581, -0.16246045,  0.06486554, -0.11612331}}
       },


       {
	  {{-0.04598729, -0.07311595,  0.11856328, -0.14512216,
          -0.01498274,  0.06463782,  0.16683532, -0.1012027 ,
          -0.24839774, -0.06628643,  0.07840403,  0.05903482,
           0.01476601,  0.05341519,  0.07770734, -0.02075964,
           0.11087844,  0.05015327, -0.22088352, -0.08069101,
           0.0898122 , -0.05068393,  0.02841392, -0.00874949,
           0.0745241 , -0.1297416 ,  0.11145025, -0.04029858,
          -0.01092368,  0.05617067,  0.03538681,  0.163932  }},

        {{-0.07439798,  0.10906085, -0.03269673, -0.10174896,
          -0.02204436,  0.23946287,  0.1452623 ,  0.08006971,
          -0.18882976, -0.12985837,  0.0349428 ,  0.09058253,
           0.13829772,  0.10808256,  0.01434535, -0.009885  ,
           0.150688  ,  0.15134212, -0.37243995,  0.13561946,
          -0.01756567,  0.05846764, -0.03055514, -0.00961288,
           0.14500464, -0.00552458, -0.03209742,  0.05948591,
           0.08824836,  0.1044193 ,  0.03693651,  0.12362126}},

        {{ 0.05866602,  0.156504  , -0.08601054, -0.15057963,
           0.1245865 ,  0.16439718, -0.0200795 , -0.02744105,
          -0.23828892,  0.05318259, -0.0621576 , -0.00848326,
           0.06235682, -0.04770404, -0.04411404,  0.01462133,
          -0.08659913,  0.09774129, -0.19816986,  0.06123253,
          -0.05731535,  0.04562221, -0.06007214,  0.12477284,
           0.13115762,  0.07998238, -0.02612003, -0.00519865,
          -0.02809746,  0.02897348, -0.04976942, -0.02795223}},

        {{-0.06806166,  0.00225955, -0.12685552, -0.097615  ,
           0.12343354,  0.03269073, -0.11804222,  0.04206008,
          -0.09560567,  0.14884123, -0.05354169,  0.04111681,
           0.08263427,  0.08137233, -0.1853976 , -0.11191633,
          -0.14507757, -0.14124745,  0.11801983, -0.07965239,
          -0.0599766 ,  0.08178579, -0.24018396,  0.14586622,
           0.05123837,  0.12553878,  0.06810378,  0.05159933,
          -0.06824112, -0.15786035, -0.11631156, -0.11315364}},

        {{-0.11046448, -0.12293101, -0.01743142,  0.10193702,
          -0.11151721, -0.03064206, -0.06776717, -0.01380346,
           0.04988607,  0.01008116,  0.11236887,  0.01928652,
          -0.0335779 , -0.05472178, -0.1294077 , -0.20204942,
          -0.06139471, -0.10190333,  0.26468542, -0.12945901,
           0.07886576,  0.01250206, -0.20413963, -0.06304597,
           0.03461526,  0.02843213, -0.01071644,  0.02809829,
           0.08772165, -0.14816023, -0.14267118, -0.13279305}}
       },


       {
	  {{-0.05494927, -0.05369868,  0.17096119, -0.05660653,
          -0.01697844, -0.07435612,  0.09452429, -0.2495472 ,
          -0.03410736,  0.01764189, -0.05547659,  0.04872718,
          -0.08314817,  0.09268392,  0.16206445,  0.06444377,
           0.01598877,  0.09543739, -0.32877615, -0.11851057,
          -0.02552354,  0.13546464, -0.16797371,  0.07468946,
          -0.10901724, -0.00878868,  0.13708271, -0.07997919,
          -0.06593443,  0.13093553, -0.10393371, -0.01047662}},

        {{ 0.06830141,  0.01636024,  0.06238842, -0.06119641,
           0.0947381 ,  0.11001278,  0.11482821, -0.23588489,
          -0.2448883 ,  0.07437366, -0.17158218,  0.08867963,
          -0.06863438, -0.00698073,  0.14061108, -0.00126479,
           0.10710155, -0.06320435, -0.24642867,  0.1213194 ,
          -0.00513216,  0.16864397, -0.22767901,  0.13786104,
          -0.11600818,  0.07836681,  0.08890989,  0.11950986,
           0.11678052,  0.00360313, -0.22347222,  0.0162786 }},

        {{ 0.04301035,  0.1527567 ,  0.13627146,  0.04774032,
           0.07451227,  0.17418787,  0.11725248, -0.19377589,
          -0.2807053 ,  0.10263385, -0.17634049,  0.18866357,
           0.08579665, -0.01341302, -0.10217064,  0.1491296 ,
          -0.02959714, -0.12320118,  0.06149248,  0.19926326,
          -0.09512095,  0.10217132, -0.47450465,  0.0837321 ,
          -0.09294174,  0.12479649, -0.00788184,  0.10938096,
           0.12346351,  0.00823621, -0.19142435, -0.07321936}},

        {{-0.0316911 ,  0.10959288,  0.11600003,  0.12473423,
          -0.05325106,  0.06851476, -0.05400427, -0.18058544,
          -0.24064405,  0.14223573, -0.06753048,  0.08083279,
          -0.03945858,  0.06317463, -0.15324804, -0.03014236,
          -0.09637603, -0.15334076,  0.24606092,  0.10980069,
          -0.03799893, -0.11506858, -0.22785307, -0.06875679,
          -0.08171108,  0.06747598,  0.04583703,  0.06736465,
           0.11369711, -0.14921607, -0.1418205 , -0.07358735}},

        {{-0.03807773,  0.05759136,  0.00945079,  0.04430391,
          -0.18206024,  0.08521818, -0.05450163, -0.17202365,
          -0.16850927,  0.04955645,  0.0266174 ,  0.18626143,
           0.12257101,  0.08886208, -0.13288888, -0.11345109,
          -0.10411382,  0.00861915,  0.10723294, -0.04321433,
          -0.12437187, -0.12526354, -0.04775252, -0.1296425 ,
           0.09273835, -0.02308703, -0.04383177,  0.09720691,
           0.02125005, -0.16420291, -0.07237723, -0.12209886}}
       },


       {
	  {{ 0.08880548, -0.05957725,  0.01798138,  0.16166943,
           0.04327551, -0.15866914,  0.01439918, -0.04798164,
           0.1777441 ,  0.1441164 , -0.15505044,  0.17797941,
          -0.19864927,  0.00303385,  0.13674733,  0.03287108,
           0.03838527, -0.00735006, -0.20906281, -0.05583544,
           0.0435448 ,  0.09044266, -0.2319429 ,  0.11482614,
          -0.19581139,  0.00801642, -0.01322751, -0.09085978,
           0.00575998,  0.14695433, -0.09731126,  0.00207646}},

        {{ 0.09197616, -0.05325453,  0.15039958,  0.1663682 ,
          -0.05885221, -0.03933837,  0.15230776, -0.11863159,
           0.20673327,  0.01121937, -0.10073002,  0.11331012,
          -0.07430151,  0.07249415,  0.02300426,  0.03237503,
           0.11052959, -0.09911719,  0.01205442, -0.07626832,
          -0.10805245, -0.00516057, -0.302796  ,  0.00148132,
          -0.2029151 ,  0.07458331,  0.11136577,  0.01663717,
          -0.0172123 ,  0.15833923, -0.07551425, -0.1010408 }},

        {{ 0.06110341,  0.03241846,  0.15207224,  0.12329543,
          -0.0089821 ,  0.08632461,  0.02826407, -0.14336842,
           0.07390029, -0.03858558, -0.07176293,  0.15238877,
           0.07042797, -0.0374818 ,  0.07227431,  0.12452037,
           0.0708188 , -0.00648358,  0.19855343,  0.1321835 ,
          -0.14115623, -0.1584285 ,  0.02426036, -0.0022629 ,
          -0.10627809,  0.0756137 ,  0.07547623,  0.04427491,
           0.09697436,  0.0497782 ,  0.05255945, -0.19441509}},

        {{ 0.06750628,  0.06430297,  0.17004186,  0.0476835 ,
          -0.13700996,  0.11615155,  0.03422091, -0.15694384,
           0.03768574, -0.07136592, -0.0423726 ,  0.14651942,
           0.06272878, -0.01424227, -0.11783552,  0.17699371,
          -0.14121328,  0.1153615 ,  0.16951622,  0.09466357,
          -0.10290958, -0.14126089,  0.01900773,  0.001455  ,
          -0.09522001,  0.09179518,  0.03608763, -0.06532579,
           0.05139335, -0.03152249,  0.10209566, -0.16321641}},

        {{ 0.02285451,  0.03725692,  0.15099587,  0.0605437 ,
          -0.07683439, -0.00590751,  0.01658024, -0.07381624,
          -0.07257413, -0.05858237, -0.07850873,  0.06889415,
           0.10443529, -0.05793901, -0.00214339,  0.12216541,
          -0.09415983,  0.10101117,  0.0832154 ,  0.08463849,
          -0.08155644, -0.03841683,  0.00249546, -0.04610588,
          -0.08199019, -0.02463337,  0.02569205,  0.08424465,
          -0.0284876 ,  0.02085121,  0.10699166, -0.14288841}}
       }
       };

#endif
