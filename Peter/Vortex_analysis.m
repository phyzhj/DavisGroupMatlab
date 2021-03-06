load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_04_13\NaFeAs504.mat
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_06_13\NaFeAs506.mat
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_04_13\G504.mat
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_06_13\G506.mat

g504=obj_30504A00_G;
g506=obj_30506A00_G;


G504 = polyn_subtract2(G504,0);
G506 = polyn_subtract2(G506,0);
g504 = polyn_subtract2(g504,0);
g506 = polyn_subtract2(g506,0);

A=G504.map(:,:,2)-G506.map(:,:,7);
a=g504.map(:,:,2)-g506.map(:,:,7);

B=G504.map(:,:,2)/abs(max(max(G504.map(:,:,2))))-G506.map(:,:,7)/abs(max(max(G506.map(:,:,7))));

b=g504.map(:,:,2)/abs(max(max(g504.map(:,:,2))))-g506.map(:,:,7)/abs(max(max(g506.map(:,:,7))));

A=(G504.map(:,:,1)-G506.map(:,:,12)+G504.map(:,:,2)-G506.map(:,:,7)+G504.map(:,:,3)-G506.map(:,:,2))*10;
a=(g504.map(:,:,1)-g506.map(:,:,12)+g504.map(:,:,2)-g506.map(:,:,7)+g504.map(:,:,3)-g506.map(:,:,2));

B=(G504.map(:,:,1)/abs(max(max(G504.map(:,:,1))))-G506.map(:,:,12)/abs(max(max(G506.map(:,:,12))))+...
    G504.map(:,:,2)/abs(max(max(G504.map(:,:,2))))-G506.map(:,:,7)/abs(max(max(G506.map(:,:,7))))+...
    G504.map(:,:,3)/abs(max(max(G504.map(:,:,3))))-G506.map(:,:,2)/abs(max(max(G506.map(:,:,2)))));

b=(g504.map(:,:,1)/abs(max(max(g504.map(:,:,1))))-g506.map(:,:,12)/abs(max(max(g506.map(:,:,12))))+...
    g504.map(:,:,2)/abs(max(max(g504.map(:,:,2))))-g506.map(:,:,7)/abs(max(max(g506.map(:,:,7))))+...
    g504.map(:,:,3)/abs(max(max(g504.map(:,:,3))))-g506.map(:,:,2)/abs(max(max(g506.map(:,:,2)))));
% 
% B=(G504.map(:,:,1)/(max(max(G504.map(:,:,1))))-G506.map(:,:,12)/(max(max(G506.map(:,:,12))))+...
%     G504.map(:,:,2)/(max(max(G504.map(:,:,2))))-G506.map(:,:,7)/(max(max(G506.map(:,:,7))))+...
%     G504.map(:,:,3)/(max(max(G504.map(:,:,3))))-G506.map(:,:,2)/(max(max(G506.map(:,:,2)))));
% 
% b=(g504.map(:,:,1)/(max(max(g504.map(:,:,1))))-g506.map(:,:,12)/(max(max(g506.map(:,:,12))))+...
%     g504.map(:,:,2)/(max(max(g504.map(:,:,2))))-g506.map(:,:,7)/(max(max(g506.map(:,:,7))))+...
%     g504.map(:,:,3)/(max(max(g504.map(:,:,3))))-g506.map(:,:,2)/(max(max(g506.map(:,:,2)))));

figure; imagesc(A)
figure; imagesc(a)
figure; imagesc(B)
figure; imagesc(b)