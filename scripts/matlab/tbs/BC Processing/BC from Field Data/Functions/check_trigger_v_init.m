clear all; close all;

load init.mat;load out.mat;

coord(1).pnt(1) = 300825.0;
coord(1).pnt(2) = 6066943.0;

coord(2).pnt(1) = 325080.0;
coord(2).pnt(2) = 6068400.0;

init_date = datenum(2009,04,01);

dtri = DelaunayTri(XX,YY);

col = {'r';'k'};

sss = find(init.H <= 0.05 & init.H >= 0.04);


for i = 1:length(coord)
    pt_id = nearestNeighbor(dtri,coord(i).pnt);
    
%     figure
%     scatter(XX,YY,'.k');hold on
%     scatter(XX(sss),YY(sss),'.r');hold on
%     scatter(coord(i).pnt(1),coord(i).pnt(2),'*b');
%     
%     stop
    
    
    plot(outX(:,i),outY(:,i),col{i});hold on
    
    scatter(init_date,init.H(pt_id),col{i});
end
    