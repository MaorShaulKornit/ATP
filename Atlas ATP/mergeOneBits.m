function im = mergeOneBits(F)
% F is a folder tree element containing onebits, all in the same size
% F = folderTree('OneBits');

for p = 1:length(F.images)
    if p==1
        im = F.images(p).getImage;
    else
        im = im & F.images(p).getImage;
    end
end