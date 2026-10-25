function A = AddCntrBW2A(bw,A,pos)
cntrbw = round(size(bw)/2);
[indy,indx] = find(bw);
indy = indy-cntrbw(1);
indx = indx-cntrbw(2);
dtay = zeros(size(indy,1)*size(pos,1),1);
dtax = zeros(size(indx,1)*size(pos,2),1);
ind = 1;
for p = 1:size(pos,1)
    dtay(ind:ind+size(indy,1)-1) = indy + pos(p,1);
    dtax(ind:ind+size(indx,1)-1) = indx + pos(p,2);
    ind = ind+size(indy,1);
end
[y,x] = removeOutOfRangeData(dtay,dtax,size(A));
pixind = sub2ind(size(A),y,x);
A(pixind) = true;
end
