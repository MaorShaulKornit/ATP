function R = fixPos(R)
for p = 1:size(R,1)
    if strcmp(R.type(p),'OD')
        if strcmp(R.Ch(p),'C')
            R.YPos(p) = R.YPos(p+1);
        end
        if strcmp(R.Ch(p),'Y')
            R.YPos(p) = R.YPos(p-1);
        end

        if strcmp(R.Ch(p),'K')
            R.YPos(p) = R.YPos(p+1);
        end
        if strcmp(R.Ch(p),'G')
            R.YPos(p) = R.YPos(p-1);
        end
        if strcmp(R.Ch(p),'Np')
            R.YPos(p) = R.YPos(p-1);
        end
        if strcmp(R.Ch(p),'Ny')
            R.YPos(p) = R.YPos(p-1);
        end        
    end
end