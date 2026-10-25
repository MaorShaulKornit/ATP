

clc
clear 
close 
Res = [100,100];
DB = makeDB;
obj = ATPMker(DB.PPRSz,Res,DB,'K');
obj.init;
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
obj.AddEl(info);
obj.Run
R = obj.getReport;
prv = obj.makePreview;
imshow(prv);hold on
plot(mm2pix(R.XPos,Res(2)),mm2pix(R.YPos,Res(1)),'*');
%%
PImage.SaveAsPNG(prv,'Preview',300)

%%
% PImage.SaveAsPNG(prv,'preview',[800,800],[cd,'\',fName]);
writetable(R,'Locations28.csv');