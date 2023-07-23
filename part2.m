% Abhirav Joshi
% Project 2 -- LP Models
% Part II Live Script

load('data/eth_2019.mat');

dates = block_difficulty(:,1);
eth = block_difficulty(:,2);
initial = 1000;
max_weeks = length(dates);


%% part a
%{
% a
p = 2; r = 0; N = 154; N2 = 181;
pastX = eth(1:N); % first half year data
futureX =  eth(N+1:N+1+N2);
[a, X] = predictor(pastX, p, r);
predicted = -filter(a,1,futureX);
e = futureX + predicted;
figure(1)

hold on
plot(dates(N+1:N+1+N2), predicted, 'b')
plot(dates(N+1:N+1+N2), futureX, 'r')
datetick('x',2)
axis tight
legend('predicted future','actual future')
title('Predicted Future Value vs Actual Future Value')
xlabel('date')
ylabel('Block Difficulty')
hold off

%b

A = {};E = []; Eavg = []; r=0;
p_arr=2:4:50;
for i=p_arr
    [a, X] = predictor(pastX, i, r);
    predicted = -filter(a,1,futureX);
    e = futureX + predicted;
    E=[E;sum(abs(e).^2);];
    Eavg = [Eavg; sum(abs(e).^2)/N2];
end
figure(2)
subplot(2,1,1)
plot(p_arr,E,'r*-');
title('Least Squared Prediction Error vs Order')
xlabel('Order (P)')
ylabel('Least Squares Prediction Error')
axis tight

% c
subplot(2,1,2)
plot(p_arr,Eavg,'b*-');
title('Average Prediction Error vs Order')
xlabel('Order (P)')
ylabel('Average Prediction Error')
axis tight
% plots have similar trend, but different values
% it is a scaled down version of the actual value differences between
% the p values

%%{
%% part b
N1 = 155;
N2 = 365;
pastX = eth(N1:N1+N2-1);
futureX1 = eth(N1+N2:N1+2*N2-1);
futureX2 = eth(N1+2*N2:N1+3*N2-1);
p = 2;
[a, X] = predictor(pastX, p, r);
predicted1 = -filter(a,1,futureX1);
predicted2 = -filter(a,1,futureX2);
e = futureX1 - predicted1;
e2 = futureX2 - predicted2;
E1partb = sum(abs(e).^2)/N2;
E2partb = sum(abs(e2).^2)/N2;

% a
figure(3)
hold on
plot(dates(N1+N2:N1+2*N2-1), predicted1, 'b')
plot(dates(N1+N2:N1+2*N2-1), futureX1, 'r')
datetick('x',2)
axis tight
legend('predicted future','actual future')
title('Predicted Future Value vs Actual Future Value')
xlabel('date')
ylabel('Block Difficulty')
hold off

% a
figure(4)
hold on
plot(dates(N1+2*N2:N1+3*N2-1), predicted2, 'b')
plot(dates(N1+2*N2:N1+3*N2-1), futureX2, 'r')
datetick('x',2)
axis tight
legend('predicted future','actual future')
title('Predicted Future Value vs Actual Future Value')
xlabel('date')
ylabel('Block Difficulty')
hold off
%}

%% part c
N1 = 155;
N2 = 365;
p = 2; r = 0;
pastXa = eth(N1+N2:N1+2*N2-1);
pastXb = eth(N1+2*N2-1-183:N1+2*N2-1);
pastXc = eth(N1+2*N2-1-31:N1+2*N2-1);
[a1, X1] = predictor(pastXa, p, r);
[a2, X2] = predictor(pastXb, p, r);
[a3, X3] = predictor(pastXc, p, r);
futureX = eth(N1+2*N2:N1+2*N2+154);
predictedOneYear = -filter(a1,1,futureX);
predictedSixMonths = -filter(a2,1,futureX);
predictedOneMonth = -filter(a3,1,futureX);
figure(2)
hold on
plot(dates(N1+2*N2:N1+2*N2+154), predictedOneYear, 'r')
plot(dates(N1+2*N2:N1+2*N2+154), predictedSixMonths, 'm')
plot(dates(N1+2*N2:N1+2*N2+154), predictedOneMonth, 'c')
plot(dates(N1+2*N2:N1+2*N2+154), futureX, 'b')
datetick('x',2)
axis tight
legend('predicted 1yr train', 'predicted 6mo. train', 'predicted 1mo. train','actual future')
title('Block Difficulty vs Date')
xlabel('date')
ylabel('Block Difficulty')
hold off

e_a = predictedOneYear - futureX;
e_b = predictedSixMonths - futureX;
e_c = predictedOneMonth - futureX;



figure(1)
hold on
plot(dates(N1+2*N2:N1+2*N2+154), e_a, 'g')
plot(dates(N1+2*N2:N1+2*N2+154), e_b, 'r')
plot(dates(N1+2*N2:N1+2*N2+154), e_c, 'b')
%plot(dates(N1+2*N2:N1+2*N2+154), futureX, 'b')
datetick('x',2)
axis tight
legend('error 1yr train', 'error 6mo. train', 'error 1mo. train')
title('Error vs Date')
xlabel('date')
ylabel('Block Difficulty')
hold off

%% part d

