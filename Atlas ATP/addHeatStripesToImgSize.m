function im = addHeatStripesToImgSize(im,pr,W,margin)

% HS = getHeatStripesByImgSize(Sz,pr,W,margin)

% Sz = [1000,1000];
% margin = [50,100];
% W = 50;
% pr = 0.1;
Sz = size(im);
BB1 = [margin(1),margin(2)+1,W,Sz(2)-2*margin(2)-1];
BB2 = [Sz(1)-margin(1)-W,margin(2)+1,W,Sz(2)-2*margin(2)-1];
HS = false(Sz);
HS(BB1(1):BB1(1)+BB1(3),BB1(2):BB1(2)+BB1(4)) = true;
HS(BB2(1):BB2(1)+BB2(3),BB2(2):BB2(2)+BB2(4)) = true;
HS = BWMker.Mask_Stat(HS,pr);
im = im & ~HS;
end