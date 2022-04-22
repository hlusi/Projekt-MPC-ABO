im = im2double(imread('11.png'));%
im = histeq(im); %ekvalizace histogramu- pomaha jen nekdy
im_edge = edge(im,'canny'); % hranova detekce

rs = 5:26; % rozsah polomeru
hs = zeros(size(im,1),size(im,2),length(rs));
r_ind =1;
[x,y]=find(im_edge);  % nalezeni souradnic hranovych pixelu
for r=rs
    tmp = gen_kruh(r);
    for i=1:length(x)
        c1 = x(i);
        c2 = y(i);
        if c1>r && c1<size(im,1)-r && c2>r && c2<size(im,2)-r
            hs(c1-r:c1+r,c2-r:c2+r,r_ind)=hs(c1-r:c1+r,c2-r:c2+r,r_ind)+1;
            
        end
    end
   r_ind = r_ind+1;
end



figure (2)
subplot 131
imshow(im,[])
subplot 132
imshow(im_edge,[])
subplot 133
imshow(hs(:,:,1),[]) % ktery polomer ??