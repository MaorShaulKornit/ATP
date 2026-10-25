% obj = Line(pos,ch,msk,H,W,isscanable,stepSz)
% obj = BiDir(pos,sz,ch,msk,dist,isref)
% obj = Scan(pos,sz,ch,msk,dist,isref)
% obj = OD(pos,sz,ch,msk)
clc
clear 
close 
Res = [800,800];
DB = makeDB;
obj = ATPMker(DB.PPRSz,Res,DB,'K');
obj.init;
obj1 = ATPMker(DB.PPRSz,[600,600],DB,'K');
obj1.init;
obj2 = ATPMker(DB.PPRSz,Res,DB,'K');
obj2.init;
obj3 = ATPMker(DB.PPRSz,Res,DB,'K');
obj3.init;

info = getInfo(obj,DB);

% %% filter as desirerd
for p = 1:length(info)
    if isempty(info(p).H)
        info(p).H = info(p).sz(1);
        info(p).W = info(p).sz(2);
    end
    
    if isempty(info(p).sz)
        info(p).sz = [info(p).H,info(p).W];
    end
end
HSPos = size(info,2)+1;
[info1,info2,info3] = SplitInfo(info,HSPos);
% fNameOD = 'ATP_OD';
fNameReg = 'ATP_Reg_2';
% fNameLines = 'ATP_Lines_Full';
% obj.AddEl(info);
% obj1.AddEl(info1);
obj2.AddEl(info2);
% obj3.AddEl(info3);
% obj.Run
% obj1.Run
obj2.Run
% obj3.Run
% obj1.saveOneBits(fNameOD);
obj2.saveOneBits(fNameReg);
% obj3.saveOneBits(fNameLines);
%%
pr = 0.22;
W = 100;
margin = [250,0];
applyFuncToImagesInF(folderTree('ATP_Reg_2'),@addHeatStripesToImageByData,pr,W,margin);

