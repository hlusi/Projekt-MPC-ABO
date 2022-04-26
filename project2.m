function [C1,C2] = project2(path)
%nacteni
%im = im2double(imread('data_new/11.png'));%
im = im2double(imread(path));

% Image segmentation
seg_im = segmentation(im);

%detekce hran
im_edge = edge(seg_im,'canny'); % hranova detekce

%houghova transformace
rs = 5:35; % rozsah polomeru
hs = zeros(size(im,1),size(im,2),length(rs));
r_ind =1;
[x,y]=find(im_edge);  % nalezeni souradnic hranovych pixelu
for r=rs
    tmp = gen_kruh(r);
    for i=1:length(x)
        c1 = x(i);
        c2 = y(i);
        if c1>r && c1<size(im,1)-r && c2>r && c2<size(im,2)-r
            hs(c1-r:c1+r,c2-r:c2+r,r_ind)=hs(c1-r:c1+r,c2-r:c2+r,r_ind)+tmp;
            
        end
    end
   r_ind = r_ind+1;
end



%figure (2)
%subplot 131
%imshow(im,[])
%subplot 132
%imshow(im_edge,[])
%subplot 133
%imshow(hs(:,:,1),[])

%pozice stredu
maximum = max(max(max(hs)));

C1 = 0;
C2 = 0;
R = 0;
for i = 1:size(hs,1)
    for j = 1:size(hs,2)
        for k = 1:size(hs,3)
            if hs(i,j,k) == maximum
                C1 = i;
                C2 = j;
                R = k;
            end
        end
    end
end

% figure
% subplot 131
% imshow(im)
% hold on
% plot(C2,C1,'r*')
% subplot 132
% imshow(seg_im,[])
% hold on
% plot(C2,C1,'r*')
% subplot 133
% imshow(im_edge)
% hold on
% plot(C2,C1,'r*')
end