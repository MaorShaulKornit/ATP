
function info = getInfo(obj,DB)
ind = 1;
S1 = DB.Section1Start;
S2 = DB.Section2Start;
SectionOffset = DB.sectionOffset;
% Section11 - OD
offsetX = DB.OD.C.offestX;
offsetY = DB.OD.C.offestY;
x = 0/100;
posStart = S1 + DB.OD.C.pos0;
ODSizeReduction = [0.5,0];
ColorChOD = PArray([DB.ChColor,DB.ChColor,DB.ChColor]);
for q = 1:DB.NPH
    PosA = posStart + offsetX.*(q-1);
    for p = 1:DB.LenColor
        Pos = PosA + offsetY.*p;
        info(ind).type = 'OD';
        info(ind).pos = Pos - [DB.OD.C.size(1),0];
        info(ind).sz = DB.OD.C.size;
        info(ind).ch = ColorChOD.pop;
        info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
        info(ind).isscanable = 1;
        info(ind).cName = info(ind).ch;
        ind = ind + 1;
    end
end

% Section12 BiDir + Scan
posStart = DB.BiDir.Pos0C;
offset = DB.BiDir.OffsetC;
bidOffset = DB.BiDir.BidOffset;
scanOffset = DB.BiDir.ScanOffset;
ChInSec = ceil(length(DB.ChColor)/DB.NPH);
ChArr = PArray(DB.ChColor);
for q = 1:DB.NPH
    Apos = posStart + (q-1)* DB.BiDir.offfsetSec;
for p = 1:ChInSec
    Ch = ChArr.pop{1};
    info(ind).type = 'BiDir';
    info(ind).pos = Apos + offset.*(p-1);
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;

    info(ind).type = 'Scan';
    info(ind).pos = Apos + offset.*(p-1) + scanOffset;
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;    
    
    info(ind).type = 'BiDir';
    info(ind).pos = Apos + offset.*(p-1) + bidOffset;
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;    
    
    info(ind).type = 'Scan';
    info(ind).pos = Apos + offset.*(p-1) + bidOffset + scanOffset;
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));    
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;
end
end
% section13 - Lines
lineOffset = [DB.Lines.W,0] + [DB.Lines.lineOffset,0];
posStart = DB.Lines.LinesPosStartC;
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
info(ind).cName = 'CMY';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch1{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'CMY';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch1{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'CMY';
ind = ind + 1;

posStart = posStart + SectionOffset/2;
Batch2 = [{'K'},{'R'},{'G'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch2{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'KRG';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch2{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'KRG';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch2{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'KRG';
ind = ind + 1;

posStart = posStart + SectionOffset/2;
Batch3 = [{[{'C'},{'G'},{'Ic'},{'K'},{'M'},{'Qc'},{'R'},{'Y'}]},...
    {[{'C'},{'G'},{'Ic'},{'K'},{'M'},{'Qc'},{'R'},{'Y'}]},...
    {[{'C'},{'G'},{'Ic'},{'K'},{'M'},{'Qc'},{'R'},{'Y'}]}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch3{1};
info(ind).msk = [0.0013,8.9250e-14,0.2+x,0,0.0156,0.0079+x,0.0683,0.1131];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = ['OrPrOl'];
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch3{2};
info(ind).msk = [0.1551,8.9335e-04,0.2+x,0.0014,0.1209,0.0157+x,0.0010,7.0912e-04];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrPrOl';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch3{3};
info(ind).msk = [0.0421,0.1115,0.2+x,0,0.0059,0.0118+x,0.0015,0.0535];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrPrOl';
ind = ind + 1;


% Section21 OD-white
posStart = S2 + DB.OD.W.pos0;
offsetX = DB.OD.W.offestX;
offsetY = DB.OD.W.offestY;
WhiteChOD = PArray;

for q = 1:DB.NPH
    PosA = posStart + offsetX.*(q-1);
    for p = 1:length(DB.OD.W.Ch)
        if WhiteChOD.len == 0
            WhiteChOD.append(DB.OD.W.Ch);
        end
        Pos = PosA + offsetY.*p;
        info(ind).type = 'OD';
        info(ind).pos = Pos - [DB.OD.W.size(1),0];
        info(ind).sz = DB.OD.W.size - ODSizeReduction;
        info(ind).ch = WhiteChOD.pop;
        info(ind).msk = DB.OD.msk(ch2ind(DB,info(ind).ch));
        info(ind).isscanable = 1;
        info(ind).cName = info(ind).ch;
        ind = ind + 1;
    end
end

offset = DB.BiDir.OffsetW;
posStart = S2 + DB.BiDir.Pos0W;
bidOffset = DB.BiDir.BidOffset;
scanOffset = DB.BiDir.ScanOffset;
ChInSec = ceil(length(DB.ChWhite)/DB.NPH);
% ChInSec = 2;
ChArr = PArray(DB.ChWhite);
for q = 1:DB.NPH+1
    Apos = posStart + (q-1)* DB.BiDir.offfsetSec;
for p = 1:ChInSec
    if isempty(ChArr.Arr)
        continue
    end
    Ch = ChArr.pop{1};
    info(ind).type = 'BiDir';
    info(ind).pos = Apos + offset.*(p-1);
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;

    info(ind).type = 'Scan';
    info(ind).pos = Apos + offset.*(p-1) + scanOffset;
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 1;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;    
    
    info(ind).type = 'BiDir';
    info(ind).pos = Apos + offset.*(p-1) + bidOffset;
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;    
    
    info(ind).type = 'Scan';
    info(ind).pos = Apos + offset.*(p-1) + bidOffset + scanOffset;
    info(ind).ch = Ch;
    info(ind).msk = DB.BiDir.msk(ch2ind(DB,info(ind).ch));
    info(ind).sz = DB.BiDir.size;
    info(ind).dist = DB.BiDir.dist;
    info(ind).isref = 0;
    info(ind).cName = info(ind).ch;
    ind = ind + 1;
end
end
% Section23 Lines white

lineOffset = [DB.Lines.W,0] + [DB.Lines.lineOffset,0];
posStart = DB.Lines.LinesPosStartW;
posStart(2) = obj.PPrSz_mm(2)/2;

Batch1 = [{'W1'},{'Ic'},{'W2'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch1{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = ['W1IcW2'];
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch1{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = ['W1IcW2'];
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch1{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = ['W1IcW2'];
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
info(ind).cName = ['W3QcW4'];
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch2{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = ['W3QcW4'];
ind = ind + 1;
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch2{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = ['W3QcW4'];
ind = ind + 1;


posStart = posStart + SectionOffset/2;

Batch3 = [{'Qw'},{[{'W1'},{'W2'},{'W3'},{'W4'}]},{'Iw'}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch3{1};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
% info(ind).msk = ones(1,length(DB.Lines.msk(ch2ind(DB,info(ind).ch))));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'WWW';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch3{2};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
% info(ind).msk = ones(1,length(DB.Lines.msk(ch2ind(DB,info(ind).ch))));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'WWW';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch3{3};
info(ind).msk = DB.Lines.msk(ch2ind(DB,info(ind).ch));
% info(ind).msk = ones(1,length(DB.Lines.msk(ch2ind(DB,info(ind).ch))));
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'WWW';
ind = ind + 1;

posStart = posStart + SectionOffset/2;

% Batch4 = [{'Qw'},{[{'W1'},{'W2'},{'W3'},{'W4'}]},{'Iw'}];
Batch4 = [{[{'Iw'},{'M'},{'Qc'},{'Qw'},{'R'},{'W1'},{'W2'},{'W3'},{'W4'},{'Y'}]},...
    {[{'C'},{'Iw'},{'M'},{'Qc'},{'Qw'},{'R'},{'W1'},{'W2'},{'W3'},{'W4'}]},...
    {[{'C'},{'G'},{'Iw'},{'M'},{'Qc'},{'Qw'},{'R'},{'W1'},{'W2'},{'W3'},{'W4'},{'Y'}]}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch4{1};
info(ind).msk = [0.2471+x,0.0081,0.0510+x,0.4196+x,0.1260,0.6509,0.6509,0.6509,0.6509,0.2853];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrWPrWOlW';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch4{2};
info(ind).msk = [0.1482,0.2471+x,0.1306,0.0442+x,0.3868+x,0.0013,0.6354,0.6354,0.6354,0.6354];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrWPrWOlW';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch4{3};
info(ind).msk = [0.0176,0.1861,0.2471+x,7.3031e-04,0.0470+x,0.3877+x,6.4001e-14,0.6368,0.6368,0.6368,0.6368,0.0741];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrWPrWOlW';
ind = ind + 1;



posStart = posStart + SectionOffset/2;

% Batch4 = [{'Qw'},{[{'W1'},{'W2'},{'W3'},{'W4'}]},{'Iw'}];
Batch5 = [{[{'M'},{'R'},{'W1'},{'W2'},{'W3'},{'W4'},{'Y'}]},...
    {[{'C'},{'M'},{'R'},{'W1'},{'W2'},{'W3'},{'W4'}]},...
    {[{'C'},{'G'},{'M'},{'R'},{'W1'},{'W2'},{'W3'},{'W4'},{'Y'}]}];
info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset;
info(ind).ch = Batch5{1};
info(ind).msk = [0.0081,0.1260,0.6509,0.6509,0.6509,0.6509,0.2853];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrWPrWOlW';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*2;
info(ind).ch = Batch5{2};
info(ind).msk = [0.1482,0.1306,0.0013,0.6354,0.6354,0.6354,0.6354];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 1;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrWPrWOlW';
ind = ind + 1;

info(ind).type = 'Line';
info(ind).pos = posStart + lineOffset*3;
info(ind).ch = Batch5{3};
info(ind).msk = [0.0176,0.1861,7.3031e-04,6.4001e-14,0.6368,0.6368,0.6368,0.6368,0.0741];
info(ind).H = DB.Lines.W;
info(ind).W = DB.Lines.H;
info(ind).isscanable = 0;
info(ind).stepSz = DB.Lines.StepSz;
info(ind).cName = 'OrWPrWOlW';
ind = ind + 1;
end