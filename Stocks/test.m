load('djiaw_2006.mat');

%% Q1
N = 10.*520; %10 years * 52 weeks
testData = djiaw(1:520, :);
actualData = djiaw(end-104:end, :);
plot(actualData(:, 1), actualData(:, 2)); 
datetick('x',1)
a = lpc(testData(:, 2),5);
predicted = filter([0 -a(2:end)],1,actualData(:,2));
hold on
plot(actualData(:, 1), predicted)
ylim([9000, 12000])
legend('Actual', 'Predicted');
title('DJIA 2005-2006, Predicted from first 10 Years of Data')
xlabel('Date')
ylabel('DJIA Index')

%% Q2
figure
range20034 = (4044-52*4):(4044-52*2);
newData = djiaw((4044-52*4):(4044-52*2), :);
a2 = lpc(newData(:, 2), 5);
predicted2 = filter([0 -a(2:end)],1,newData(:,2));
plot(newData(:, 1), newData(:, 2));
hold on 
plot(newData(:, 1), predicted2)
ylim([7000, 11000])
title('DJIA 2005-2006, Predicted from DJIA 2003-2004')
xlabel('Date')
ylabel('DJIA Index')
datetick('x',1)
legend('Actual', 'Predicted');



%% Q3 



