classdef elmnt < handle
    properties
        pos
        msk
        sz_mm
        ch
        type
        isscanable
        scanpos
        ChName
    end
    
    methods
        function obj = elmnt(pos,sz,ch,type,msk,isscanable,scanpos,ChName)
            if nargin > 0
                if nargin<7
                    obj.scanpos = pos;
                else
                    obj.scanpos = scanpos;
                end
                if nargin < 6
                    obj.isscanable = true;
                else
                    obj.isscanable = isscanable;
                end
                obj.pos = pos;
                obj.sz_mm = sz;
                obj.ch = ch;
                obj.msk = msk;
                obj.type = type;
                obj.ChName = ChName;
            end
        end
        
        function d = getDta(obj)
            d.Type = obj.type;
            d.pos = obj.pos;
            d.sz_mm = obj.sz_mm;
            d.ch = obj.ch;
            d.msk = obj.msk;
            d.ChName = obj.ChName;
        end
    end
end

