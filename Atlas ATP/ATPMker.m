classdef ATPMker < handle
    properties
        PPrSz_mm
        res
        file CArray
        Ch
        DB
        refCh
    end
    properties
        elmnts CArray
    end
    
    properties (Dependent)
        PPrSz_pix
        NElmnts
    end
    
    methods
        function obj = ATPMker(PPr,res,DB,refCh)
            obj.PPrSz_mm = UnitConv.PaprSize(PPr);
            obj.Ch = [DB.ChColor,DB.ChWhite];
            obj.DB = DB;
            obj.refCh = refCh;
            obj.res = res;
            obj.file = CArray;
            obj.elmnts = CArray;
        end
        
        function t = get.PPrSz_pix(obj)
            t = mm2pix(obj.PPrSz_mm,obj.res);
        end
        
        function init(obj)
            Sz = UnitConv.PaprSize_pix('A3',obj.res);
            for p = 1:length(obj.Ch)
                obj.file.Append(ChannelData(false(Sz),obj.Ch{p},p));
            end
        end
        
        function AddEl(obj,info)
            for p = 1:length(info)
                if strcmp(info(p).type,'OD')
                    if iscell(info(p).ch)
                        for q = 1:length(info(p).ch)
                            obj.elmnts.Append(OD(info(p).pos,info(p).sz,info(p).ch{q},info(p).msk(q),info(p).isscanable,info(p).cName));
                        end
                    else
                        obj.elmnts.Append(OD(info(p).pos,info(p).sz,info(p).ch,info(p).msk,info(p).isscanable,info(p).cName));
                    end
                elseif strcmp(info(p).type,'BiDir')
                    obj.elmnts.Append(BiDir(info(p).pos,info(p).sz,info(p).ch,...
                        info(p).msk,info(p).dist,info(p).isref,info(p).cName));
                elseif strcmp(info(p).type,'Scan')
                    obj.elmnts.Append(Scan(info(p).pos,info(p).sz,info(p).ch,...
                        info(p).msk,info(p).dist,info(p).isref,info(p).cName));
                elseif strcmp(info(p).type,'Line')
                    if iscell(info(p).ch)
                        scnbl = [info(p).isscanable,zeros(1,length(info(p).ch)-1)];
                        for q = 1:length(info(p).ch)
                            obj.elmnts.Append(Line(info(p).pos,info(p).ch{q},info(p).msk(q),...
                                info(p).H,info(p).W,scnbl(q),info(p).stepSz,info(p).cName));
                        end
                    else
                        obj.elmnts.Append(Line(info(p).pos,info(p).ch,info(p).msk,...
                            info(p).H,info(p).W,info(p).isscanable,info(p).stepSz,info(p).cName));
                    end
                end
            end
        end
        
        function fl = getfileByCh(obj,ch)
            H = obj.file.Head;
            for p = 1:obj.file.len
                if strcmp(H.Dta.Ch,ch)
                    fl = H;
                    break
                else
                    H = H.next;
                end
            end
        end
        
        function x = get.NElmnts(obj)
            x = obj.elmnts.len;
        end
        
        function Run(obj)
            E = obj.elmnts.Head;
            for p = 1:obj.NElmnts
                H = obj.getfileByCh(E.Dta.ch);
                if strcmp(E.DType,'Scan')
                    ref = obj.getfileByCh(obj.refCh);
                    [bw1,bw2] = Types.(E.DType)(E.Dta,obj.res);
                    pos_pix = mm2pix_rounded(E.Dta.pos,obj.res);
                    pos_pix(2) = pos_pix(2) + mod(pos_pix(2),2);
                    if E.Dta.ref
                        H.Dta.Dta = AddCntrBW2A(bw1,H.Dta.Dta,pos_pix);
                        ref.Dta.Dta = AddCntrBW2A(bw2,ref.Dta.Dta,pos_pix);
                    else
                        H.Dta.Dta = AddCntrBW2A(bw2,H.Dta.Dta,pos_pix);
                        ref.Dta.Dta = AddCntrBW2A(bw1,ref.Dta.Dta,pos_pix);
                    end
                else
                    bw1 = Types.(E.DType)(E.Dta,obj.res);
                    pos_pix = mm2pix_rounded(E.Dta.pos,obj.res);
                    pos_pix(2) = pos_pix(2) + mod(pos_pix(2),2);
                    H.Dta.Dta = AddCntrBW2A(bw1,H.Dta.Dta,pos_pix);
                end
                E = E.next;
            end
        end
        
        function A = getFullImg(obj)
            H = obj.file.Head;
            for p = 1:obj.file.len
                if p == 1
                    A = H.Dta.Dta;
                else
                    A = A | H.Dta.Dta;
                end
                H = H.next;
            end
        end
        
        function saveOneBits(obj,str)
            dir = [cd,'\',str];
            mkdir(dir);
            H = obj.file.Head;
            for p = 1:obj.file.len
                BWMker.Save1Bit_Stat(~H.Dta.Dta,[str,'_',H.Dta.Ch],obj.res(2),obj.res(1),dir);
                H = H.next;
            end
        end
        
        function T = getReport(obj)
            crnt = obj.elmnts.Head;
            ind = 1;
            for p = 1:obj.elmnts.len
                if crnt.Dta.isscanable
                    if size(crnt.Dta.scanpos,1)>1
                        for q = 1:size(crnt.Dta.scanpos,1)
                            dta(ind).type = crnt.Dta.type;
                            dta(ind).XPos = crnt.Dta.scanpos(q,2);
                            dta(ind).YPos = crnt.Dta.scanpos(q,1);
                            dta(ind).Ch = crnt.Dta.ch;
                            dta(ind).Volt = ['V',num2str(randi(6))];
                            dta(ind).PH = randi(3);
                            dta(ind).exposureTime = getETime(crnt.Dta.ch,crnt.Dta.type);
%                             crnt.Dta.ch
                            
                            dta(ind).isInvert = invertCond(crnt.Dta.ch,crnt.Dta.type);
                            dta(ind).isRef = false;
                            dta(ind).ChName = crnt.Dta.ChName;
                            ind = ind + 1;
                        end
                    else
                        dta(ind).type = crnt.Dta.type;
                        dta(ind).XPos = crnt.Dta.scanpos(2);
                        dta(ind).YPos = crnt.Dta.scanpos(1);
                        dta(ind).Ch = crnt.Dta.ch;
                        dta(ind).Volt = ['V',num2str(randi(6))];
                        dta(ind).PH = randi(3);
                        dta(ind).exposureTime = getETime(crnt.Dta.ch,crnt.Dta.type);
                        dta(ind).isInvert = invertCond(crnt.Dta.ch,crnt.Dta.type);
                        if isprop(crnt.Dta, 'ref')
                            dta(ind).isRef = crnt.Dta.ref;
                        else
                            dta(ind).isRef = false;
                        end
                        dta(ind).ChName = crnt.Dta.ChName;
                        ind = ind + 1;
                    end
                end
                crnt = crnt.next;
            end
            T = struct2table(dta);
        end
        
        function img = makePreview(obj)
            H = obj.file.Head;
            im1 = zeros(size(H.Dta.Dta));
            color = [255,255,255];
            for p = 2:obj.file.len+1
                im1(H.Dta.Dta) = p;
                color = cat(1,color,KUtils.getRGBVal(H.Dta.Ch));
                H = H.next;
            end
            img = uint8(ind2rgb(im1,color));
        end
    end
end

