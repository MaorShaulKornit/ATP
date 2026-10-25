clc
clear all
for pr = [10,15,20,25,30]
mkdir(['ATP_Lines_',num2str(pr)]);
end
F = folderTree('ATP_Lines');
for p = 1:length(F.images)
    imOb = F.images(p);
    img = ~imOb.getImage;
    im1 = imopen(img,ones(5));
    im2 = img & ~im1;
    for pr = [10,15,20,25,30]
        im1T = BWMker.Mask_Stat(im1,pr/100);
        im3 = ~(im1T | im2);
        BWMker.Save1Bit_Stat(im3,['ATP_Lines_',imOb.sepName],imOb.ResX,imOb.ResY,['ATP_Lines_',num2str(pr)]);
    end
end
    
%%
for pr = [10,15,20,25,30]
fNameLines = ['ATP_Lines_',num2str(pr)];
pr1 = 0.22;
W = 100;
margin = [250,0];
applyFuncToImagesInF(folderTree(fNameLines),@addHeatStripesToImageByData,pr1,W,margin);
end