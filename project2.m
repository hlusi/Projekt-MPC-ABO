function [C1,C2] = project2(path)
%% Loading of the current image
%im = im2double(imread('data_new/11.png')); % loading of a specific image
im = im2double(imread(path));

%% Image segmentation
seg_im = segmentation(im);

%% Edge detection
im_edge = edge(seg_im,'canny');

%% Hough transform
rs = 5:35; % radius range
hs = zeros(size(im,1),size(im,2),length(rs));
r_ind =1;
[x,y]=find(im_edge);  % finding the coordinates of the edge pixels
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

%% Finding the position of the centre
maximum = max(max(max(hs))); % maximum value of the Hough transform

C1 = 0;
C2 = 0;
R = 0;
for i = 1:size(hs,1) % rows
    for j = 1:size(hs,2) % columns
        for k = 1:size(hs,3) % slices (radii)
            if hs(i,j,k) == maximum
                C1 = i; % row position of the centre
                C2 = j; % column position of the centre
                R = k;  % slice (radius) of the centre
            end
        end
    end
end

%% Visualization
% figure;
% imshow(hs(:,:,R),[])
% title('Slice of Hough transform which contains the position of the centre (radius = 18 px)', 'FontSize',20)

% figure;
% subplot 131
% imshow(im)
% title('Original image', 'FontSize',20)
% hold on
% plot(C2,C1,'r*','MarkerSize',15,'LineWidth',2)
% subplot 132
% imshow(seg_im,[])
% title('Segmented image', 'FontSize',20)
% hold on
% plot(C2,C1,'r*','MarkerSize',15,'LineWidth',2)
% subplot 133
% imshow(im_edge)
% title('Edge detection', 'FontSize',20)
% hold on
% plot(C2,C1,'r*','MarkerSize',15,'LineWidth',2)
end