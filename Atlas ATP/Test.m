
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
fNameOD = 'ATP_OD';
fNameReg = 'ATP_Reg';
fNameLines = 'ATP_Lines';
% obj.AddEl(info);
% obj1.AddEl(info1);
% obj2.AddEl(info2);
obj3.AddEl(info3);
% obj.Run
% obj1.Run
% obj2.Run
obj3.Run
% obj1.saveOneBits(fNameOD);
% obj2.saveOneBits(fNameReg);
obj3.saveOneBits(fNameLines);
%%
pr = 0.22;
W = 100;
margin = [250,0];
% [indS,indE] = getVerticalStartEndValues(~imread('ATP_OD\ATP_OD_C.tif'));
% applyFuncToImagesInF(folderTree('ATP_OD'),@cropImgVerticalyByInd,indS,indE);
% applyFuncToImagesInF(folderTree('ATP_OD'),@addHeatStripesToImgSize,pr,W,margin);
% applyFuncToImagesInF(folderTree('ATP_Reg'),@addHeatStripesToImageByData,pr,W,margin);
applyFuncToImagesInF(folderTree(fNameLines),@addHeatStripesToImageByData,pr,W,margin);
%%
% ODOffsetPos = pix2mm(indS,600);
% R = obj.getReport;
% % R = fixPos(R);
% prv = obj.makePreview;
% imshow(prv);hold on
% plot(mm2pix(R.XPos,Res(2)),mm2pix(R.YPos,Res(1)),'*');
% % PImage.SaveAsPNG(prv,'preview',[600,600]);
% PathPlot([[1,size(prv,1)/2];[size(prv,2),size(prv,1)/2]])

%%
PImage.SaveAsPNG(prv,'preview',[800,800],[cd,'\',fName]);
writetable(R,'Locations32.csv');