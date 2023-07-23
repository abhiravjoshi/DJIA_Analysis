% Abhirav Joshi
% Project 2 -- LP Models
% Part I Live Script
load('data/djiaw_2019.mat');
dates = djiaw_total(:,1);
djiaw = djiaw_total(:,2);

initial = 1000;
r = 0.03; % annual interest
interest = r/52; % weekly interest
max_weeks = length(dates);


%% part a
figure(1)
subplot(2,1,1)
plot(dates, djiaw);
datetick('x',10);
axis tight
grid on
xlabel('Date')
ylabel('DJIAW')
title('DJIA Plot on Linear Scale')

subplot(2,1,2)
semilogy(dates, djiaw);
datetick('x',10);
axis tight
grid on
xlabel('Date')
ylabel('DJIAW')
title('DJIA Plot on Semilogarithmic Scale')

seq_hold     = initial;
seqInt       = initial;
holdInt         = initial;
investInt    = initial;

for i = 1:max_weeks - 1
    holdInt      = holdInt * djiaw(i+1) / djiaw(i);
    investInt = investInt * (1 + interest);
    seq_hold  = [seq_hold holdInt];
    seqInt    = [seqInt investInt];
end

investInt    = investInt * (1 + interest);
seqInt       = [seqInt investInt];
aprNeeded    = (nthroot(holdInt / initial, max_weeks) - 1) * 52;

% holdInt    = 1.0420e4
% investInt  = 1.5163e5
% aprNeeded  = .0513

%%{
%% part b
p = 3; r = 0; N = 520;
xInput = djiaw(1:N); % take first ten years data
[a, X] = predictor(xInput, p, r);

% a =  [-1.1183 0.0938 0.0268]
%%{
%% part c
xhat1 = -X * a;
e_1 = xInput(p+1+r:end) - xhat1;
xhat2 = -filter(a,1,xInput);
xhat2 = xhat2(p+r:end-1);
e_2 = xInput(p+1+r:end) - xhat2;
E_1 = sum(abs(e_1).^2);
E_2 = sum(abs(e_2).^2);
figure(3)
hold on
plot(dates(p+1+r:N), xhat1, 'r--')
plot(dates(p+1+r:N), xhat2, 'b-.')
plot(dates(p+1+r:N), xInput(p+1+r:end))
datetick('x',10)
legend('xhat1','xhat2','actual')
title('Predicted xhat1, xhat2, & Actual DJIA Data Comparison vs time')
xlabel('date')
ylabel('Dow Jones Industrial Average')
hold off
axis tight
grid on
figure(4)
hold on
plot(dates(p+1+r:N), e_1,'r--')
plot(dates(p+1+r:N), e_2, 'b-.')
datetick('x', 10)
legend('xhat1 error','xhat2 error')
title('xhat1 and xhat2 errors vs date')
xlabel('date')
ylabel('Mean Square Error')
axis tight
grid on
hold off
%%{
%% part d
A = {};E = [];r=0;
p_arr=1:10;
%start_week = 1;
for i=p_arr
    xInput = djiaw(1:N);
    [a,X] = predictor(xInput, i, r);
    xhat1 = -X*a;
    e = xInput(i+1+r:end) - xhat1;
    A=[A a];
    E=[E;sum(abs(e).^2);];
end
figure(5)
plot(p_arr,E,'r*-');
title('Sum Squared Prediction Error vs Order')
xlabel('Order')
ylabel('Sum Squared Prediction Error')


%% part e
p=10;r=0;
xInput = djiaw(1:N);
[a,~] = predictor(xInput, p, r);
X_e =[];
initial = 1000;
for w = 0:N-1
    pred = djiaw(w+p:-1:w+1);
    pred_temp = - (pred')*a;
    X_e = [X_e pred_temp];
end
seq_hold_e = initial;
seqInt_e = initial;
seq_djia_e = initial;
seq_pred_e = initial;
holdInt_e = initial;
interest_e = initial;
djiaw_e = initial;
pred_e = initial;
for i=p+1:N+p
    holdInt_e = holdInt_e*djiaw(i)/djiaw(i-1);
    interest_e = interest_e*(1+interest);
    if(djiaw_e*djiaw(i)/djiaw(i-1)>djiaw_e*(1+interest))
        djiaw_e = djiaw_e*djiaw(i)/djiaw(i-1);
    else
        djiaw_e = djiaw_e*(1+interest);
    end
    
    if(pred_e*X_e(i-p)/djiaw(i-1)>pred_e*(1+interest))
        pred_e = pred_e*djiaw(i)/djiaw(i-1);
    else
        pred_e = pred_e*(1+interest);
    end
    
    seq_hold_e = [seq_hold_e holdInt_e];
    seqInt_e = [seqInt_e interest_e];
    seq_djia_e = [seq_djia_e djiaw_e];
    seq_pred_e = [seq_pred_e pred_e];
end
aprNeeded_hold_e = (nthroot(holdInt_e/initial,N)-1)*52;
aprNeeded_interest_e = (nthroot(interest_e/initial,N)-1)*52;
aprNeeded_djiaw_e = (nthroot(djiaw_e/initial,N)-1)*52;
aprNeeded_pred_e = (nthroot(pred_e/initial,N)-1)*52;


%% part f
p=10;r=0;
start_week = max_weeks-N-p+1;
xInput = djiaw(start_week:max_weeks-p);
[a,~] = predictor(xInput, p, r);
X_f =[];
initial = 1000;
for w = max_weeks-N-p:max_weeks-p-1
    pred = djiaw(w+p:-1:w+1);
    pred_temp = - (pred')*a;
    X_f = [X_f pred_temp];
end
seq_hold_f = initial;
seqInt_f = initial;
seq_djia_f = initial;
seq_pred_f = initial;
holdInt_f = initial;
interest_f = initial;
djiaw_f = initial;
pred_f = initial;
for i=max_weeks-N+1:max_weeks
    holdInt_f = holdInt_f*djiaw(i)/djiaw(i-1);
    interest_f = interest_f*(1+interest);
    if(djiaw_f*djiaw(i)/djiaw(i-1)>djiaw_f*(1+interest))
        djiaw_f = djiaw_f*djiaw(i)/djiaw(i-1);
    else
        djiaw_f = djiaw_f*(1+interest);
    end
    
    if(pred_f*X_f(i-max_weeks+N)/djiaw(i-1)>pred_f*(1+interest))
        pred_f = pred_f*djiaw(i)/djiaw(i-1);
    else
        pred_f = pred_f*(1+interest);
    end
    
    seq_hold_f = [seq_hold_f holdInt_f];
    seqInt_f = [seqInt_f interest_f];
    seq_djia_f = [seq_djia_f djiaw_f];
    seq_pred_f = [seq_pred_f pred_f];
end
aprNeeded_hold_f = (nthroot(holdInt_f/initial,N)-1)*52;
aprNeeded_interest_f = (nthroot(interest_f/initial,N)-1)*52;
aprNeeded_djiaw_f = (nthroot(djiaw_f/initial,N)-1)*52;
aprNeeded_pred_f = (nthroot(pred_f/initial,N)-1)*52;
%}
