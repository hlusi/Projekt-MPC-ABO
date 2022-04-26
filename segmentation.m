function seg_im = segmentation(im)
% find threshold with Otsu thresholding method
thr = graythresh(im); 
% convert image into binary image with Otsu thresholding
im1=imbinarize(im,thr); 
% define the structuring element
SE=strel('disk',8,4);  
% apply the opening morphological operation
seg_im=imopen(im1,SE);

end
  