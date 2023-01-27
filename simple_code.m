jun = load('stk_jun07.mat', 'stk_haba');
date_time_jun = datetime(datestr(jun.stk_haba.order_book.date_time));
probe_start_jun = find(date_time_jun == datetime('01-Jun-2007 08:05:00'));
probe_end_jun = find(date_time_jun == datetime('29-Jun-2007 16:25:00'));
prices_jun = cell2mat(jun.stk_haba.order_book.price(probe_start_jun: probe_end_jun));

jul = load('stk_jul07.mat', 'stk_haba');
date_time_jul = datetime(datestr(jul.stk_haba.order_book.date_time));
probe_start_jul = find(date_time_jul == datetime('02-Jul-2007 08:05:00'));
probe_end_jul = find(date_time_jul == datetime('31-Jul-2007 16:25:00'));
prices_jul = cell2mat(jul.stk_haba.order_book.price(probe_start_jul: probe_end_jul));

aug = load('stk_aug07.mat', 'stk_haba');
date_time_aug = datetime(datestr(aug.stk_haba.order_book.date_time));
probe_start_aug = find(date_time_aug == datetime('01-Aug-2007 08:05:00'));
probe_end_aug = find(date_time_aug == datetime('31-Aug-2007 16:25:00'));
prices_aug = cell2mat(aug.stk_haba.order_book.price(probe_start_aug: probe_end_aug));

%% Price and Mid-Price

prices_full = cat(1,prices_jun, prices_jul, prices_aug);
date_time_full = cat(1,date_time_jun,date_time_jul,date_time_aug);



figure; %Price plot
plot(prices_full);
xlim([0,length(prices_full)])
xlabel('Date'); ylabel('Price'); title('Price for Jun to Aug');
legend("Bids", "Asks");


mid_price_full = mean(prices_full, 2);

moving_avg = movmean(mid_price_full,505);


mid_price_jun = mean(prices_jun, 2);
mid_price_jul = mean(prices_jul, 2);
mid_price_aug = mean(prices_aug, 2);

moving_avg_jun = movmean(mid_price_jun,101);
moving_avg_jul = movmean(mid_price_jul,101);
moving_avg_aug = movmean(mid_price_aug,101);

figure; %Mid price plot full
hold('on')
plot(mid_price_full); plot(moving_avg,'r');
xlim([0,length(mid_price_full)])
xlabel('Date'); ylabel('Price'); title('Mid-Price for Jun to Aug');
legend("Mid Price","5 day moving average");
pd_price = fitdist(mid_price_full,'Normal');
plot(pd_price)
title('Price Distribution')

figure; %Mid price plot jun
hold('on')
plot(mid_price_jun);
plot(moving_avg_jun,'r','LineWidth',1.1);
xlim([0,length(mid_price_jun)])
xlabel('Date');
ylabel('Price');
title('Mid-Price for Jun');
legend("Mid Price","5 day moving average");

figure; %Mid price plot jul
hold('on')
plot(mid_price_jul);
plot(moving_avg_jul,'r','LineWidth',1.1);
xlim([0,length(mid_price_jul)])
xlabel('Date');
ylabel('Price');
title('Mid-Price for Jul');
legend("Mid Price","5 day moving average");

figure; %Mid price plot aug
hold('on')
plot(mid_price_aug);
plot(moving_avg_aug,'r','LineWidth',1.1);
xlim([0,length(mid_price_aug)])
xlabel('Date');
ylabel('Price');
title('Mid-Price for Aug');
legend("Mid Price","5 day moving average");


%% Mid price Stats

mid_price_probe = mid_price_full; % change _full for jun, jul, aug, or full

mp_mu_full = mean(mid_price_probe)
mp_sigma_full = std(mid_price_probe)
mp_variance_full = mp_sigma_full^2
mp_skew_full = skewness(mid_price_probe)
mp_kurt_full = kurtosis(mid_price_probe)
high_full = max(mid_price_probe)
low_full = min(mid_price_probe)
high_full_in = find(mid_price_probe == max(mid_price_probe));
low_full_in = find(mid_price_probe == min(mid_price_probe));
low_full_dt = date_time_full(low_full_in)
high_full_dt = date_time_full(high_full_in)




%% Returns and Cum ret

returns_full = [0;diff(log(mid_price_full))];
mean_returns = mean(returns_full);
ret_skew = skewness(returns_full);
ret_kurt = kurtosis(returns_full);
high_full = find(mid_price_full == max(mid_price_full));
low_full = find(mid_price_full == min(mid_price_full));

returns_jun = [0;diff(log(mid_price_jun))];
ret_skew_jun = skewness(returns_jun);
ret_kurt_jun = kurtosis(returns_jun);

returns_jul = [0;diff(log(mid_price_jul))];
ret_skew_jul = skewness(returns_jul);
ret_kurt_jul = kurtosis(returns_jul);
high_jul = find(mid_price_jul == max(mid_price_jul));
low_jul = find(mid_price_jul == min(mid_price_jul));

returns_aug = [0;diff(log(mid_price_aug))];
ret_skew_aug = skewness(returns_aug);
ret_kurt_aug = kurtosis(returns_aug);
high_aug = find(mid_price_aug == max(mid_price_aug));
low_aug = find(mid_price_aug == min(mid_price_aug));


cum_ret_full = cumsum(returns_full);
pd_cum = fitdist(cum_ret_full,'Normal');
mu = mean(cum_ret_full);
sigma = std(cum_ret_full);
cum_skew_full = skewness(cum_ret_full);
cum_kurt_full = kurtosis(cum_ret_full);
plot(pd_cum);
xlabel('Cumulative Return'); legend('')
cum_ret_jun = cumsum(returns_jun);
cum_ret_skew_jun = skewness(cum_ret_jun);
cum_ret_kurt_jun = kurtosis(cum_ret_jun);

cum_ret_jul = cumsum(returns_jul);
cum_ret_skew_jul = skewness(cum_ret_jul);
cum_ret_kurt_jul = kurtosis(cum_ret_jul);

cum_ret_aug = cumsum(returns_aug);
cum_ret_skew_aug = skewness(cum_ret_aug);
cum_ret_kurt_aug = kurtosis(cum_ret_aug);

%% Cumulative Stats

cum_ret_probe = cum_ret_jun; % change _full for jun, jul, aug, or full
% cumulative returns can be calculated the same way
cr_mu_full = mean(cum_ret_probe)
cr_sigma_full = std(cum_ret_probe)
cr_variance_full = cr_sigma_full^2
cr_skew_full = skewness(cum_ret_probe)
cr_kurt_full = kurtosis(cum_ret_probe)
high_full = max(cum_ret_probe)
low_full = min(cum_ret_probe)
high_full_in = find(cum_ret_probe == max(cum_ret_probe));
low_full_in = find(cum_ret_probe == min(cum_ret_probe));
low_full_dt = date_time_full(low_full_in)
high_full_dt = date_time_full(high_full_in)

%% plot
figure; %Returns vs cumulative return plot full
hold("on")
plot(returns_full,'r');
plot(cum_ret_full,'b');
xlim([0,length(returns_full)])
xlabel('Date'); ylabel('Returns');
title('Returns for Jun - Aug 2007');
legend("Return","Cumulative Returns");


figure; %Returns plot jun
plot(returns_jun,'r');
hold("on")
plot(cum_ret_jun,'b');
xlim([0,length(returns_jun)])
xlabel('Date');
ylabel('Returns');
title('Returns for Jun 2007');
legend("Return","Cumulative Returns");
hold("off")

figure; %Returns plot jul
plot(returns_jul,'r');
hold("on")
plot(cum_ret_jul,'b');
xlim([0,length(returns_jul)])
xlabel('Date');
ylabel('Price');
title('Returns for Jul 2007');
legend("Return","Cumulative Returns");
hold("off")

figure; %Returns plot aug
plot(returns_aug,'r');
hold("on")
plot(cum_ret_aug,'b');
xlim([0,length(returns_aug)])
xlabel('Date');
ylabel('Price');
title('Returns for Aug 2007');
legend("Return","Cumulative Returns");
hold("off")

%% Distribution Plotting.

jun_price_pd = fitdist(mid_price_jun,'Normal');
jul_price_pd = fitdist(mid_price_jul,'Normal');
aug_price_pd = fitdist(mid_price_aug,'Normal');
full_price_pd = fitdist(mid_price_full,'Normal');

figure;
subplot 221; plot(jun_price_pd); title("June 2007 (Price)")
subplot 222; plot(jul_price_pd); title("July 2007 (Price)")
subplot 223; plot(aug_price_pd); title("August 2007 (Price)")
subplot 224; plot(full_price_pd); title("June - August 2007 (Price)")


jun_ret_pd = fitdist(returns_jun,'Normal');
jul_ret_pd = fitdist(returns_jul,'Normal');
aug_ret_pd = fitdist(returns_aug,'Normal');
full_ret_pd = fitdist(returns_full,'Normal');

figure; 
subplot 221; plot(jun_ret_pd); title("June 2007 (Returns)")
subplot 222; plot(jul_ret_pd); title("July 2007 (Returns)")
subplot 223; plot(aug_ret_pd); title("August 2007 (Returns)")
subplot 224; plot(full_ret_pd); title("June - August 2007 (Returns)")

%% Peaks and troughs

% Full
basis_points = 100; %change for different basis points

[maxtab_cumreturns, mintab_cumreturns] = peakdet(cum_ret_full,basis_points/10000);
figure
subplot 224
hold on; 
plot(mintab_cumreturns(:,1), mintab_cumreturns(:,2), 'g*');
plot(maxtab_cumreturns(:,1), maxtab_cumreturns(:,2), 'r*' );
plot(cum_ret_full,'b');
xlim([0,length(cum_ret_full)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Southwest') 
title('Jun - Aug 2007 (100 basis)') 

% Jun
basis_points_jun = 25; %change for different basis points

[maxtab_cumreturns_jun, mintab_cumreturns_jun] = peakdet(cum_ret_jun,basis_points_jun/10000);
subplot 221
hold on; 
plot(mintab_cumreturns_jun(:,1), mintab_cumreturns_jun(:,2), 'r*');
plot(maxtab_cumreturns_jun(:,1), maxtab_cumreturns_jun(:,2), 'g*' );
plot(cum_ret_jun,'b');
xlim([0,length(cum_ret_jun)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Southwest') 
title('Jun 2007 (25 basis)') 

% Jul
basis_points_jul = 25; %change for different basis points

[maxtab_cumreturns_jul, mintab_cumreturns_jul] = peakdet(cum_ret_jul,basis_points_jul/10000);
subplot 222
hold on; 
plot(mintab_cumreturns_jul(:,1), mintab_cumreturns_jul(:,2), 'g*');
plot(maxtab_cumreturns_jul(:,1), maxtab_cumreturns_jul(:,2), 'r*' );
plot(cum_ret_jul,'b');
xlim([0,length(cum_ret_jul)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Southwest') 
title('Jul 2007 (25 basis)') 

% Aug
basis_points_aug = 25; %change for different basis points
[maxtab_cumreturns_aug, mintab_cumreturns_aug] = peakdet(cum_ret_aug,basis_points_aug/10000);
subplot 223
hold on; 
plot(mintab_cumreturns_aug(:,1), mintab_cumreturns_aug(:,2), 'g*');
plot(maxtab_cumreturns_aug(:,1), maxtab_cumreturns_aug(:,2), 'r*' );
plot(cum_ret_aug,'b');
xlim([0,length(cum_ret_aug)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Southwest') 
title('Aug 2007 (25 basis)') 

%% Total S/F C/E calc


uptrends = 0;
uptrends_jul = 0;
uptrends_aug = 0;

downtrends = 0;
downtrends_jul = 0;
downtrends_aug = 0;

min_tab = mintab_cumreturns_jul;
max_tab = mintab_cumreturns_jul;

if(min_tab(1)<max_tab(1))
    uptrends = length(max_tab);
    downtrends = length(min_tab) - 1;
else
    uptrends = length(max_tab)-1;
    downtrends = length(min_tab);
end
disp(uptrends)
disp(downtrends)

%for i = 1:max(min_tab,max_tab)
    
%end
%% use for specific days


%month_end = "Jul"; %Enter the month you loaded
month = "Jul"; % Enter the month you loaded
date_p = "12";   % Can be changed for each date
date_end = "13";     %watch-out for weekends

%for jun (comment the other two months while using this month)
%date_time_probe = datetime(datestr(jun.stk_haba.order_book.date_time));

%for jul (comment the other two months while using this month)
date_time_probe = datetime(datestr(jul.stk_haba.order_book.date_time));

%for aug (comment the other two months while using this month)
%date_time_probe = datetime(datestr(aug.stk_haba.order_book.date_time));

probe_start = find(date_time_jul == datetime(date_p+'-'+month+'-2007 08:05:00'));
probe_end = find(date_time_jul == datetime(date_p+'-'+month+'-2007 16:25:00'));

%probe_prices = cell2mat(jun.stk_haba.order_book.price(probe_start: probe_end));
%probe_prices = cell2mat(jul.stk_haba.order_book.price(probe_start: probe_end));
%probe_prices = cell2mat(aug.stk_haba.order_book.price(probe_start: probe_end));

%mid_price = mean(probe_prices, 2);
%returns = [0;diff(log(mid_price))];
cum_ret = cum_ret_jul(probe_start:probe_end);


%% Peaks and troughs

basis_points = 25; %change for different basis points

[maxtab_cumreturns, mintab_cumreturns] = peakdet(cum_ret,basis_points/10000);
figure
hold on; 
plot(mintab_cumreturns(:,1), mintab_cumreturns(:,2), 'g*');
plot(maxtab_cumreturns(:,1), maxtab_cumreturns(:,2), 'r*' );
plot(cum_ret,'b');
xlim([0,length(cum_ret)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Southwest') 
title('13th July with 25 basis points') 


%% NVWAP
start_lag =  4 - 1 ;
end_lag = 9 - 1;
probe_bids_nvwap = jul.stk_haba.order_book.bids((probe_start+start_lag):(probe_start + end_lag));
probe_asks_nvwap = jul.stk_haba.order_book.asks((probe_start+start_lag):(probe_start + end_lag));
[time_range,~] = size(probe_bids_nvwap);
figure;
for i = 1:time_range
    bid_data = cell2mat(probe_bids_nvwap(i));
    b_val = cumsum(bid_data(:,1).*bid_data(:,2));
    b_vol = cumsum(bid_data(:,2));
    VWAP_bid = b_val./b_vol;
    ask_data = cell2mat(probe_asks_nvwap(i));
    a_val = cumsum(ask_data(:,1).*ask_data(:,2));
    a_vol = cumsum(ask_data(:,2));
    VWAP_ask = a_val./a_vol;
    c_sub = 3;
    r_sub = ceil(time_range/c_sub);
    y = probe_start+i+start_lag-1;
    z = datestr(date_time_probe(y),'HH:MM');
    subplot(r_sub,c_sub,i)
    hold("on")
    plot(b_vol,VWAP_bid,'r','LineWidth',2)
    plot(a_vol,VWAP_ask,'b','LineWidth',2)
    xlabel("Volume")
    ylabel("NVWAP")
    
    title("Orderbook at "+z)

    hold("off")
end
legend("Bid","Ask")

%% Bid and Ask Quantity Calc


bid_jun = jun.stk_haba.order_book.bids;
bid_jul = jul.stk_haba.order_book.bids;
bid_aug = aug.stk_haba.order_book.bids;

ask_jun = jun.stk_haba.order_book.asks;
ask_jul = jul.stk_haba.order_book.asks;
ask_aug = aug.stk_haba.order_book.asks;

ask_quant_jun = zeros(2121,1);
ask_quant_jul = zeros(2222,1);
ask_quant_aug = zeros(2222,1);

bid_quant_jun = zeros(2121,1);
bid_quant_jul = zeros(2222,1);
bid_quant_aug = zeros(2222,1);

for i = 1:length(bid_jul)
    if i <= length(bid_jun)
        bid_data = cell2mat(bid_jun(i));
        bid_quant_jun(i) = sum(bid_data(:,2));

        ask_data = cell2mat(ask_jun(i));
        ask_quant_jun(i) = sum(ask_data(:,2));
    end
    

    bid_data = cell2mat(bid_jul(i));
    bid_quant_jul(i) = sum(bid_data(:,2));

    bid_data = cell2mat(bid_aug(i));
    bid_quant_aug(i) = sum(bid_data(:,2));

    ask_data = cell2mat(ask_jul(i));
    ask_quant_jul(i) = sum(ask_data(:,2));

    ask_data = cell2mat(ask_aug(i));
    ask_quant_aug(i) = sum(ask_data(:,2));

end


%% Table Calculation

t = probe_start + 67;
t1 = probe_start + 77;

ttime = date_time_jul(t)
t1time = date_time_jul(t1)

tmp = mid_price_jul(t)
t1mp = mid_price_jul(t1)
dlogmp = log(mid_price_jul(t1)) - log(mid_price_jul(t))

tb = jul.stk_haba.order_book.beta(t,1)
t1b = jul.stk_haba.order_book.beta(t1,1)
dlogb = log(jul.stk_haba.order_book.beta(t1,1)) - log(jul.stk_haba.order_book.beta(t,1))

tquant = bid_quant_jul(t)
t1quant = bid_quant_jul(t1)
dlogquant = log(bid_quant_jul(t1)) -log(bid_quant_jul(t))

ta = jul.stk_haba.order_book.beta(t,2)
t1a = jul.stk_haba.order_book.beta(t1,2)
dloga = log(jul.stk_haba.order_book.beta(t1,2)) - log(jul.stk_haba.order_book.beta(t,2))

tquantask = ask_quant_jul(t)
t1quantask = ask_quant_jul(t1)
dlogquantask = log(ask_quant_jul(t1)) -log(ask_quant_jul(t))




%% peaakdet






