
% obj = Line(pos,ch,msk,H,W,isscanable,stepSz)
% obj = BiDir(pos,sz,ch,msk,dist,isref)
% obj = Scan(pos,sz,ch,msk,dist,isref)
% obj = OD(pos,sz,ch,msk)
clc
clear 
close 
DB = makeDB;
obj = ATPMker(DB.PPRSz,[600,600],DB,'K');
obj.init;
% info = getInfoNeonDB(obj,DB);

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
info1 = addHSOD(info1,DB);
info2 = addHSReg(info2,DB);
info3 = addHSLines(info3,DB);
fName = 'ATP';
obj.AddEl(info);
obj.Run
% %%
% obj.saveOneBits(fName);% A = obj.getFullImg;
%%
f1 = folderTree([cd,'\','ATP_\ATP_OD']);
% f2 = folderTree([cd,'\','ATP_Reg']);
% f3 = folderTree([cd,'\','ATP_Lines']);
for p = 1:length(f1.images)
    if p==1
        im = f1.images(p).getImage;
    else
        im = im & f1.images(p).getImage;
    end
end
imshow(im)
%%
% imshow(A)
R = obj.getReport;
R = fixPos(R);
prv = obj.makePreview;
imshow(prv);hold on
plot(mm2pix(R.XPos,600),mm2pix(R.YPos,600),'*');
% PImage.SaveAsPNG(prv,'preview',[600,600]);
%%
% PImage.SaveAsPNG(prv,'preview',[800,800],[cd,'\',fName]);
writetable(R,'Locations26.csv');