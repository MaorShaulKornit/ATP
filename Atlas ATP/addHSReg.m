function info = addHSReg(info,DB)
%  xclear(info2,DB)
ind = length(info)+1;
T = struct2table(info);

poses = unique(T.pos(:,1)); 
PPRSz = UnitConv.PaprSize(DB.PPRSz);
Ch1 = DB.ChColor;
for p = 1:length(Ch1)
    info(ind).type = 'Line';
    info(ind).pos = [poses(1)-DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch1{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length2;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;

    info(ind).type = 'Line';
    info(ind).pos = [poses(2)+DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch1{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length2;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;
end
% 
Ch2 = [DB.ChWhite,{'K'}];
for p = 1:length(Ch2)
    info(ind).type = 'Line';
    info(ind).pos = [poses(3)-DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch2{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length2;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;

    info(ind).type = 'Line';
    info(ind).pos = [poses(4)+DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch2{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length2;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;
end

end