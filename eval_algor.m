%
centres_expected = zeros(2,23);
centres_detected = zeros(2,23);
error_vec = zeros(1,23);


for i = 1:23
    centres_expected(:,i) = project2(['data_new/t',num2str(i),'.png']);
    centres_detected(:,i) = project2(['data_new/',num2str(i),'.png']);
    
    error_vec(i) = sqrt((centres_expected(1,i)-centres_detected(1,i))^2+(centres_expected(2,i)-centres_detected(2,i))^2);
end

MAE = sum(error_vec)/23;