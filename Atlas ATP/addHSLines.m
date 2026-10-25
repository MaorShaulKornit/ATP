function info = addHSLines(info,DB)
% xclear(info3,DB);
% info = info3;
ind = length(info)+1;
T = struct2table(info);
PPRSz = UnitConv.PaprSize(DB.PPRSz);

poses = [];
poses = cat(1,poses,DB.Section1Start+[5,0]);
poses = cat(1,poses,DB.Section2Start);
poses = cat(1,poses,[PPRSz(1),0]-[5,0]);

Ch = DB.AllCh;
for p = 1:length(Ch)
info(ind).type = 'Line';
info(ind).pos = [poses(1),PPRSz(2)/2];
info(ind).ch = Ch{p};
info(ind).msk = DB.HS.msk;
info(ind).H = DB.HS.Width;
info(ind).W = DB.HS.length3;
info(ind).isscanable = 0;
info(ind).stepSz = 20;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = [poses(2),PPRSz(2)/2];
info(ind).ch = Ch{p};
info(ind).msk = DB.HS.msk;
info(ind).H = DB.HS.Width;
info(ind).W = DB.HS.length3;
info(ind).isscanable = 0;
info(ind).stepSz = 20;
ind = ind + 1;


info(ind).type = 'Line';
info(ind).pos = [poses(3),PPRSz(2)/2];
info(ind).ch = Ch{p};
info(ind).msk = DB.HS.msk;
info(ind).H = DB.HS.Width;
info(ind).W = DB.HS.length3;
info(ind).isscanable = 0;
info(ind).stepSz = 20;
ind = ind + 1;
end