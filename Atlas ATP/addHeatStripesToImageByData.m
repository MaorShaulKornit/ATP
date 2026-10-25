function img2 = addHeatStripesToImageByData(img,pr,W,margin)

[indS,indE] = getVerticalStartEndValues(~img);

HS = toEmpty(img);
H = size(img,1);
HS(margin(1):margin(1)+W-1,indS:indE) = true;
HS(H-margin(1)-W:H-margin(1),indS:indE) = true;
HS = BWMker.Mask_Stat(HS,pr);
img2 = img & ~HS;
