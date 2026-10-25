function info = addHSOD2(info,DB)
% xclear(info1,DB)
% info = info1;
ind = length(info)+1;
T = struct2table(info);
T1 = T(T.isscanable==1,:);

% posesHC = unique(T1.pos(:,1));
[TC,TW] = splitWC(T1,DB);
posesHC = mean(unique(TC.pos(:,1)));
posesHW = mean(unique(TW.pos(:,1)));
possesC = unique(TC.pos(:,2));
possesW = unique(TW.pos(:,2));
LnC = max(possesC)-min(possesC) + DB.OD.C.size(2);
LnW = max(possesW)-min(possesW) + DB.OD.W.size(2);
PPRSz = UnitConv.PaprSize(DB.PPRSz);
Ch1 = DB.ChColor;
for p = 1:length(Ch1)
    info(ind).type = 'Line';
    info(ind).pos = [posesHC-DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch1{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = LnC;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;

    info(ind).type = 'Line';
    info(ind).pos = [posesHC+DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch1{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = LnC;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;
end

Ch2 = DB.ChWhite;
for p = 1:length(Ch1)
    info(ind).type = 'Line';
    info(ind).pos = [posesHW-DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch2{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = LnW;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;

    info(ind).type = 'Line';
    info(ind).pos = [posesHW+DB.HS.DistFromTarget,PPRSz(2)/2];
    info(ind).ch = Ch2{p};
    info(ind).msk = DB.HS.msk;
    info(ind).H = DB.HS.Width;
    info(ind).W = LnW;
    info(ind).isscanable = 0;
    info(ind).stepSz = 20;
    ind = ind + 1;
end



end