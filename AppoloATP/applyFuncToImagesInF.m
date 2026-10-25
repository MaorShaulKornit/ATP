function applyFuncToImagesInF(F,func,varargin)
for p = 1:length(F.images)
    x = func(F.images(p).getImage,varargin{:});
    BWMker.Save1Bit_Stat(x,F.images(p).saveData{:});
end
