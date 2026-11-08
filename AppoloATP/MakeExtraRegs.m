clc
clear all
%% Shift data LeftRight -> create new reg's
F = folderTree('ATP_Reg');
d1 = [cd,'\ATP_Reg_1'];
d2 = [cd,'\ATP_Reg_3'];
mkdir(d1);
mkdir(d2);
for p = 1:length(F.images)
    imOb = F.images(p);
    im = imOb.getImage;
    im2 = circshift(im,32,2);
    im3 = circshift(im,-32,2);
    BWMker.Save1Bit_Stat(im2,imOb.noExtName,imOb.ResX,imOb.ResY,d1);
    BWMker.Save1Bit_Stat(im3,imOb.noExtName,imOb.ResX,imOb.ResY,d2);
end
%% Split to AB_DE (C is ATP_Reg_2)
clc
clear all
F1 = folderTree('ATP_Reg_1');
F3 = folderTree('ATP_Reg_3');
A = linspace(1,F1.images(1).Width,7)';
A = [A,ones(size(A,1),1)*500];
Rng = PathToEdges(A);
Name1 = 'ATP_Reg_A';
Name2 = 'ATP_Reg_B';
% Name
Name4 = 'ATP_Reg_D';
Name5 = 'ATP_Reg_E';
todel_A = [1,2,4,5];
todel_D = [3,6];
todel_B = [2,3,5,6];
todel_E = [1,4];
rmvData(F1,todel_A,Rng,Name1)
rmvData(F1,todel_D,Rng,Name4)
rmvData(F1,todel_B,Rng,Name2)
rmvData(F1,todel_E,Rng,Name5)

%% Add HS
pr = 0.22;
W = 100;
margin = [250,0];

applyFuncToImagesInF(folderTree('ATP_Reg_A'),@addHeatStripesToImageByData,pr,W,margin);
applyFuncToImagesInF(folderTree('ATP_Reg_B'),@addHeatStripesToImageByData,pr,W,margin);
applyFuncToImagesInF(folderTree('ATP_Reg_D'),@addHeatStripesToImageByData,pr,W,margin);
applyFuncToImagesInF(folderTree('ATP_Reg_E'),@addHeatStripesToImageByData,pr,W,margin);
%%
% %%
% 
% dir1 = [cd,'\',Name1];
% V = folderTree(dir1);
% for p = 1:length(V.images)
%     if p==1
%         im1 = V.images(p).getImage;
%     else
%         im1 = im1 & V.images(p).getImage;
%     end
% end
% dir4 = [cd,'\',Name4];
% V = folderTree(dir4);
% for p = 1:length(V.images)
%     if p==1
%         im4 = V.images(p).getImage;
%     else
%         im4 = im4 & V.images(p).getImage;
%     end
% end
% dir2 = [cd,'\',Name2];
% V = folderTree(dir2);
% for p = 1:length(V.images)
%     if p==1
%         im2 = V.images(p).getImage;
%     else
%         im2 = im2 & V.images(p).getImage;
%     end
% end
% dir5 = [cd,'\',Name5];
% V = folderTree(dir5);
% for p = 1:length(V.images)
%     if p==1
%         im5 = V.images(p).getImage;
%     else
%         im5 = im5 & V.images(p).getImage;
%     end
% end
% %%


