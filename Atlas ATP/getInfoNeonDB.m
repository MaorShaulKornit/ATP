
function info = getInfoNeonDB(obj,DB)
ind = 1;
S1 = DB.Section1Start;
S2 = DB.Section2Start;
SectionOffset = DB.sectionOffset;
% Section11 - OD
offset = DB.OD.C.offest;
posStart = S1 + DB.OD.C.pos0;
ODSizeReduction = [0.5,0];
ODSizeAddition = [3,0];
ColorChOD = PArray([DB.ChColor,DB.ChColor,DB.ChColor]);

for p = 1:DB.LenColor
    Pos = posStart + offset.*p;
    info(ind).type = 'OD';
    info(ind).pos = Pos - [DB.OD.C.size(1),0]-ODSizeAddition/2;
    info(ind).sz = DB.OD.C.size + ODSizeAddition;
    info(ind).ch = ColorChOD.pop;
    info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
    info(ind).isscanable = 1;
    ind = ind + 1;
    
    info(ind).type = 'OD';
    info(ind).pos = Pos;
    info(ind).sz = DB.OD.C.size - ODSizeReduction;
    info(ind).ch = ColorChOD.pop;
    info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
    info(ind).isscanable = 1;
    ind = ind + 1;
    
    info(ind).type = 'OD';
    info(ind).pos = Pos + [DB.OD.C.size(1),0] + ODSizeAddition/2;
    info(ind).sz = DB.OD.C.size + ODSizeAddition;
    info(ind).ch = ColorChOD.pop;
    info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
    info(ind).isscanable = 1;
    ind = ind + 1;
end

% Section12 BiDir + Scan
posStart = DB.BiDir.Pos0C;
offset = DB.BiDir.OffsetC;
bidOffset = DB.BiDir.BidOffset;
scanOffset = DB.BiDir.ScanOffset;
for p = 1:DB.LenColor
    info(ind).type = 'BiDir';
    info(ind).pos = posStart + offset.*p;
    info(ind).ch = DB.ChColor{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    ind = ind + 1;

    info(ind).type = 'Scan';
    info(ind).pos = posStart + offset.*p + scanOffset;
    info(ind).ch = DB.ChColor{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    ind = ind + 1;    
    
    info(ind).type = 'BiDir';
    info(ind).pos = posStart + offset.*p + bidOffset;
    info(ind).ch = DB.ChColor{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    ind = ind + 1;    
    
    info(ind).type = 'Scan';
    info(ind).pos = posStart + offset.*p + bidOffset + scanOffset;
    info(ind).ch = DB.ChColor{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));    
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    ind = ind + 1;
end
% section13 - Lines
lineOffset = [DB.Lines.W,0] + [DB.Lines.lineOffset,0];
posStart = DB.OD.C.pos0 + 2*SectionOffset;
posStart(2) = obj.PPrSz_mm(2)/2;

Batch1 = [{'C'},{'M'},{'Y'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch1{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch1{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch1{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

posStart = posStart + SectionOffset/2;
Batch2 = [{'K'},{'Np'},{'Ny'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch2{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch2{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch2{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

posStart = posStart + SectionOffset/2;
Batch3 = [{[{'C'},{'Ny'},{'Ic'},{'K'},{'M'},{'Qc'},{'Np'},{'Y'}]},...
    {[{'C'},{'Ny'},{'Ic'},{'K'},{'M'},{'Qc'},{'Np'},{'Y'}]},...
    {[{'C'},{'Ny'},{'Ic'},{'K'},{'M'},{'Qc'},{'Np'},{'Y'}]}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch3{1};
info(ind).msk = [0.0013,8.9250e-14,0.2,0,0.0156,0.0079,0.0683,0.1131];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch3{2};
info(ind).msk = [0.1551,8.9335e-04,0.2,0.0014,0.1209,0.0157,0.0010,7.0912e-04];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch3{3};
info(ind).msk = [0.0421,0.1115,0.2,0,0.0059,0.0118,0.0015,0.0535];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;


% Section21 OD-white
posStart = S2 + DB.OD.W.pos0;
offset = DB.OD.W.offest;
WhiteChOD = PArray;
for p = 1:DB.LenWhite+1
    if WhiteChOD.len == 0
        WhiteChOD.append(DB.ChWhite);
    end
    Pos = posStart + offset.*p;
    info(ind).type = 'OD';
%     info(ind).pos = Pos - [DB.OD.C.size(1),0]-ODSizeAddition/2;
%     info(ind).sz = DB.OD.C.size + ODSizeAddition;
%     
    info(ind).pos = Pos - [DB.OD.W.size(1),0] - ODSizeAddition/2;
    info(ind).sz = DB.OD.W.size + ODSizeAddition;
    info(ind).ch = WhiteChOD.pop;
    info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
    info(ind).isscanable = 0;
    ind = ind + 1;
    
    info(ind).type = 'OD';
    info(ind).pos = Pos;
    info(ind).sz = DB.OD.W.size - ODSizeReduction;
    info(ind).ch = WhiteChOD.pop;
    info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
    info(ind).isscanable = 1;
    ind = ind + 1;
    
    if WhiteChOD.len > 0
        info(ind).type = 'OD';
        info(ind).pos = Pos + [DB.OD.W.size(1),0] + ODSizeAddition/2;
        info(ind).sz = DB.OD.W.size + ODSizeAddition;
        info(ind).ch = WhiteChOD.pop;
        info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
        info(ind).isscanable = 0;
        ind = ind + 1;
    end
    
end

% Section22 BiDir + Scan white
offset = DB.BiDir.OffsetW;
posStart = S2 + DB.BiDir.Pos0W;
bidOffset = DB.BiDir.BidOffset;
scanOffset = DB.BiDir.ScanOffset;
for p = 1:DB.LenWhite
    info(ind).type = 'BiDir';
    info(ind).pos = posStart + offset.*p;
    info(ind).ch = DB.ChWhite{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    ind = ind + 1;

    info(ind).type = 'Scan';
    info(ind).pos = posStart + offset.*p + scanOffset;
    info(ind).ch = DB.ChWhite{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    ind = ind + 1;    
    
    info(ind).type = 'BiDir';
    info(ind).pos = posStart + offset.*p + bidOffset;
    info(ind).ch = DB.ChWhite{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    ind = ind + 1;    
    
    info(ind).type = 'Scan';
    info(ind).pos = posStart + offset.*p + bidOffset + scanOffset;
    info(ind).ch = DB.ChWhite{p};
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    ind = ind + 1;
end
% Section23 Lines white

lineOffset = [DB.Lines.W,0] + [DB.Lines.lineOffset,0];
posStart = posStart + SectionOffset;
posStart(2) = obj.PPrSz_mm(2)/2;

Batch1 = [{'W1'},{'Ic'},{'DB'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch1{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch1{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch1{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

posStart = posStart + SectionOffset/2;

Batch2 = [{'W3'},{'Qc'},{'W4'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch2{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch2{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch2{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;


posStart = posStart + SectionOffset/2;

Batch3 = [{'Qw'},{[{'W1'},{'DB'},{'W3'},{'W4'}]},{'Iw'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch3{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch3{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch3{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

posStart = posStart + SectionOffset/2;

% Batch4 = [{'Qw'},{[{'W1'},{'DB'},{'W3'},{'W4'}]},{'Iw'}];
Batch4 = [{[{'Iw'},{'M'},{'Qc'},{'Qw'},{'Np'},{'W1'},{'DB'},{'W3'},{'W4'},{'Y'}]},...
    {[{'C'},{'Iw'},{'M'},{'Qc'},{'Qw'},{'Np'},{'W1'},{'DB'},{'W3'},{'W4'}]},...
    {[{'C'},{'Ny'},{'Iw'},{'M'},{'Qc'},{'Qw'},{'Np'},{'W1'},{'DB'},{'W3'},{'W4'},{'Y'}]}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch4{1};
info(ind).msk = [0.2471,0.0081,0.0510,0.4196,0.1260,0.6509,0.6509,0.6509,0.6509,0.2853];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch4{2};
info(ind).msk = [0.1482,0.2471,0.1306,0.0442,0.3868,0.0013,0.6354,0.6354,0.6354,0.6354];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch4{3};
info(ind).msk = [0.0176,0.1861,0.2471,7.3031e-04,0.0470,0.3877,6.4001e-14,0.6368,0.6368,0.6368,0.6368,0.0741];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;



posStart = posStart + SectionOffset/2;

% Batch4 = [{'Qw'},{[{'W1'},{'DB'},{'W3'},{'W4'}]},{'Iw'}];
Batch5 = [{[{'M'},{'Np'},{'W1'},{'DB'},{'W3'},{'W4'},{'Y'}]},...
    {[{'C'},{'M'},{'Np'},{'W1'},{'DB'},{'W3'},{'W4'}]},...
    {[{'C'},{'Ny'},{'M'},{'Np'},{'W1'},{'DB'},{'W3'},{'W4'},{'Y'}]}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch5{1};
info(ind).msk = [0.0081,0.1260,0.6509,0.6509,0.6509,0.6509,0.2853];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch5{2};
info(ind).msk = [0.1482,0.1306,0.0013,0.6354,0.6354,0.6354,0.6354];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch5{3};
info(ind).msk = [0.0176,0.1861,7.3031e-04,6.4001e-14,0.6368,0.6368,0.6368,0.6368,0.0741];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
ind = ind + 1;






end