clc
clear all

F = folderTree('ATP_Reg_2');
d1 = [cd,'\ATP_Reg_1'];
d2 = [cd,'\ATP_Reg_3'];
mkdir(d1);
mkdir(d2);
for p = 1:length(F.images)
    imOb = F.images(p);
    im = imOb.getImage;
    im2 = circshift(im,50,2);
    im3 = circshift(im,-50,2);
    BWMker.Save1Bit_Stat(im2,imOb.noExtName,imOb.ResX,imOb.ResY,d1);
    BWMker.Save1Bit_Stat(im3,imOb.noExtName,imOb.ResX,imOb.ResY,d2);
end