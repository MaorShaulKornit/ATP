function [im2] = cropImgVerticalyByInd(im,ind1,ind2)
if isempty(ind1) || isempty(ind2) || ind1==ind2
    im2 = im;
    return
end
im2 = im(:,ind1:ind2);
end
