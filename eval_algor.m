clear all; close all; clc
%% Evaluation of the algorithm
centres_expected = zeros(2,23);
centres_detected = zeros(2,23);
errors = zeros(1,23);

tic;
for i = 1:23    % goes through all the images
    centres_expected(:,i) = project2(['data_new/t',num2str(i),'.png']); % Finding the centre of the references
    centres_detected(:,i) = project2(['data_new/',num2str(i),'.png']);  % Implemented algorithm
    
    errors(i) = sqrt((centres_expected(1,i)-centres_detected(1,i))^2+(centres_expected(2,i)-centres_detected(2,i))^2); % Vector of errors
end
toc;
%% Mean absolute error
MAE = sum(errors)/23;

%% Visualization
figure;
bar(errors)
line([1 23],[MAE MAE],'color','r','linestyle','-')
title('MAE – Mean Absolute Error', 'FontSize',20)
xlabel('# of images','FontSize',15); ylabel('Error [px]','FontSize',15)
legend('Error',['Average (' num2str(round(MAE,2)) ')'],'FontSize',15,'Location','best')
