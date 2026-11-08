function rmvData(F1,todel_11,Rng,Name1)
dir1 = [cd,'\',Name1];
mkdir(dir1);
for p = 1:length(F1.images)
    im = F1.images(p).getImage;
    im(1:500,:) = true;
    im(end-500:end,:) = true;
    for q = 1:length(todel_11)
        im(:,Rng(todel_11(q),1):Rng(todel_11(q),3)) = true;
    end
    BWMker.Save1Bit_Stat(im,F1.images(p).noExtName,800,800,dir1)
end
end