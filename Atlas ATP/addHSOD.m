function info = addHSOD(info,DB)
% xclear(info1,DB)
ind = length(info)+1;
T = struct2table(info);
T1 = T(T.isscanable==1,:);
poses = unique(T1.pos(:,1));


PPRSz = UnitConv.PaprSize(DB.PPRSz);
Ch1 = DB.ChColor;
for p = 1:length(Ch1)
    info(ind).type = 'Line';
    info(ind).pos = [poses(1)-DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch1{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length1;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;

    info(ind).type = 'Line';
    info(ind).pos = [poses(1)+DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch1{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length1;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;
end

Ch2 = DB.ChWhite;
for p = 1:length(Ch1)
    info(ind).type = 'Line';
    info(ind).pos = [poses(2)-DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch2{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length1;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;

    info(ind).type = 'Line';
    info(ind).pos = [poses(2)+DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch2{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = DB.HS.length1;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;
end



end