function DB = makeDB()

DB.NPH = 6;

DB.PPRSz = 'AppoloPPr';
DB.ChColor = [{'C'},{'M'},{'Y'},{'K'},{'R'},{'G'}];
DB.ChWhite = [{'W1'},{'W2'},{'W3'},{'W4'},{'Ic'},{'Qc'},{'Iw'},{'Qw'}];
DB.LenColor = length(DB.ChColor);
DB.LenWhite = length(DB.ChWhite);
DB.AllCh = [DB.ChColor,DB.ChWhite];
DB.Section1Start = [0,0]; %Section 2 starting pos -> Light media
DB.Section2Start = [200,0]; %Section 2 starting pos -> Dark media 
DB.sectionOffset = [30,0]; %offset between sections (OD/Bi+Scan/Lines)

%OD
DB.OD.C.size = [17,17]; % Object Size
DB.OD.C.offestX = [0,Sizes.PH_508_mm]; % LR/X/CrosScan Distance between OD Squares
DB.OD.C.offestY = [17.8,0]; % LR/X/CrosScan Distance between OD Squares
DB.OD.C.pos0 = [40,25]; % Starting position of square 1 minus offset (pos 1 will be pos0 + offset)

DB.OD.W.size = [17,17]; % Object Size
DB.OD.W.offestX = [0,Sizes.PH_508_mm]; % LR/X/CrosScan Distance between OD Squares
DB.OD.W.offestY = [17.8,0];
DB.OD.W.pos0 = [25,25]; % Starting position of square 1 minus offset(pos 1 will be pos0 + offset)
DB.OD.msk = [0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6].*1.2; % DB.AllCh oeder
DB.OD.W.Ch = DB.ChWhite(1:4);
%biDir + Scan
DB.BiDir.Pos0C = [40,49];
DB.BiDir.Pos0W = [25,49];
DB.BiDir.size = [2.56,2.56];
DB.BiDir.BidOffset = [15,0]; % UD/Y/Scan Distance distance between upper and lower bidirs
DB.BiDir.ScanOffset = [0,15]; % LR/X/CrosScan distance between bidir and scan
DB.BiDir.dist = [1,0]; % UD/Y/Scan Distance between blocks (measured distance) 
DB.BiDir.OffsetC = [33,0]; % LR/X/CrosScan offset between channels
DB.BiDir.OffsetW = [33,0]; % LR/X/CrosScan offset between channels
DB.BiDir.offfsetSec = [0,Sizes.PH_508_mm];

DB.BiDir.msk = [1,1,1,1,1,1,1,1,1,1,1,1,1,1]; % mask order per channel -> oedered as DB.AllCh

%Lines
DB.Lines.LinesPosStartC = [145,50];
DB.Lines.LinesPosStartW = [130+190,50];
DB.Lines.W = 2.5; % UD/Y/Scan width of the lines (up down -> around 2-3 mm)
DB.Lines.H = 210; % LR/X/CrosScan Width of the lines (its too complicated to change this to W)
DB.Lines.StepSz = 10; % steps to take picture (distance between frame position)
x = 0/100;
yAdd = 0;
DB.Lines.msk = [0.5,0.5,0.5+yAdd,0.5,0.5,0.5,0.55,0.55,0.55,0.55,0.25+x,0.25+x,0.25+x,0.25+x];% mask order per channel -> oedered as DB.AllCh
DB.Lines.lineOffset = 0.9; % UD/Y/Scan distance between lines
DB.Lines.Color.Order = [{'C_M_Y'},{'K_R_G'},{'Orange_Prple_Olive'}];
DB.Lines.White.Order = [{'C_M_Y'},{'K_R_G'},{'Orange_Prple_Olive'}];


%HeatStipes
DB.HS.Width = 2;
DB.HS.msk = 0.17;
DB.HS.DistFromTarget = 15; 
DB.HS.length1 = Sizes.PH_508_mm*DB.NPH - 1;
DB.HS.length2 = 245;
DB.HS.length3 = 210;
