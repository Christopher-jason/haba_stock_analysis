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



figure; %Price plot
plot(prices_full);
xlim([0,length(prices_full)])
xlabel('Date'); ylabel('Price'); title('Price for Jun to Aug');
legend("Bids","Asks");


mid_price_full = mean(prices_full, 2);

moving_avg = movmean(mid_price_full,405);


mid_price_jun = mean(prices_jun, 2);
mid_price_jul = mean(prices_jul, 2);
mid_price_aug = mean(prices_aug, 2);

moving_avg_jun = movmean(mid_price_jun,101);
moving_avg_jul = movmean(mid_price_jul,101);
moving_avg_aug = movmean(mid_price_aug,101);

figure; %Mid price plot full
hold('on')
plot(mid_price_full);
plot(moving_avg,'r');
xlim([0,length(mid_price_full)])
xlabel('Date');
ylabel('Price');
title('Mid-Price for Jun to Aug');
legend("Mid Price","5 day moving average");

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



%% Returns and Cum ret

returns_full = [0;diff(log(mid_price_full))];
ret_skew = skewness(returns_full);
ret_kurt = kurtosis(returns_full);

cum_ret_full = cumsum(returns_full);

returns_jun = [0;diff(log(mid_price_jun))];
ret_skew_jun = skewness(returns_jun);
ret_kurt_jun = kurtosis(returns_jun);
returns_jul = [0;diff(log(mid_price_jul))];
ret_skew_jul = skewness(returns_jul);
ret_kurt_jul = kurtosis(returns_jul);
returns_aug = [0;diff(log(mid_price_aug))];
ret_skew_aug = skewness(returns_aug);
ret_kurt_aug = kurtosis(returns_aug);
cum_ret_jun = cumsum(returns_jun);
cum_ret_skew_jun = skewness(cum_ret_jun);
cum_ret_kurt_jun = kurtosis(cum_ret_jun);
cum_ret_jul = cumsum(returns_jul);
cum_ret_skew_jul = skewness(cum_ret_jul);
cum_ret_kurt_jul = kurtosis(cum_ret_jul);
cum_ret_aug = cumsum(returns_aug);
cum_ret_skew_aug = skewness(cum_ret_aug);
cum_ret_kurt_aug = kurtosis(cum_ret_aug);

figure; %Returns plot full
plot(returns_full,'r');
hold("on")
plot(cum_ret_full,'b');
xlim([0,length(returns_full)])
xlabel('Date');
ylabel('Price');
title('Returns for Jun - Aug 2007');
legend("Return","Cumulative Returns");
hold("off")

figure; %Returns plot jun
plot(returns_jun,'r');
hold("on")
plot(cum_ret_jun,'b');
xlim([0,length(returns_jun)])
xlabel('Date');
ylabel('Price');
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

%% Peaks and troughs

% Full
basis_points = 100; %change for different basis points

[maxtab_cumreturns, mintab_cumreturns] = peakdet(cum_ret_full,basis_points/10000);
figure
hold on; 
plot(mintab_cumreturns(:,1), mintab_cumreturns(:,2), 'g*');
plot(maxtab_cumreturns(:,1), maxtab_cumreturns(:,2), 'r*' );
plot(cum_ret_full,'b');
xlim([0,length(cum_ret_full)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest') 
title('Peaks and Troughs in Cumulative Return with 100 basis points') 

% Jun
basis_points_jun = 25; %change for different basis points

[maxtab_cumreturns_jun, mintab_cumreturns_jun] = peakdet(cum_ret_jun,basis_points_jun/10000);
figure
hold on; 
plot(mintab_cumreturns_jun(:,1), mintab_cumreturns_jun(:,2), 'r*');
plot(maxtab_cumreturns_jun(:,1), maxtab_cumreturns_jun(:,2), 'g*' );
plot(cum_ret_jun,'b');
xlim([0,length(cum_ret_jun)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest') 
title('Peaks and Troughs in Cumulative Return for jun with 25 basis points') 

% Jul
basis_points_jul = 50; %change for different basis points

[maxtab_cumreturns_jul, mintab_cumreturns_jul] = peakdet(cum_ret_jul,basis_points_jul/10000);
figure
hold on; 
plot(mintab_cumreturns_jul(:,1), mintab_cumreturns_jul(:,2), 'g*');
plot(maxtab_cumreturns_jul(:,1), maxtab_cumreturns_jul(:,2), 'r*' );
plot(cum_ret_jul,'b');
xlim([0,length(cum_ret_jul)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest') 
title('Peaks and Troughs in Cumulative Return for jul with 50 basis points') 

% Aug
basis_points_aug = 75; %change for different basis points
[maxtab_cumreturns_aug, mintab_cumreturns_aug] = peakdet(cum_ret_aug,basis_points_aug/10000);
figure
hold on; 
plot(mintab_cumreturns_aug(:,1), mintab_cumreturns_aug(:,2), 'g*');
plot(maxtab_cumreturns_aug(:,1), maxtab_cumreturns_aug(:,2), 'r*' );
plot(cum_ret_aug,'b');
xlim([0,length(cum_ret_aug)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest') 
title('Peaks and Troughs in Cumulative Return  for Aug with 75 basis points') 



%% use for specific days

month_start = "Aug"; % Enter the month you loaded
month_end = "Aug"; %Enter the month you loaded
date_start = "20";   %watch-out for weekends
date_end = "20";     %watch-out for weekends

%for jun (comment the other two months while using this month)
%date_time_probe = datetime(datestr(jun.stk_haba.order_book.date_time));

%for jul (comment the other two months while using this month)
%date_time_probe = datetime(datestr(jul.stk_haba.order_book.date_time));

%for aug (comment the other two months while using this month)
date_time_probe = datetime(datestr(aug.stk_haba.order_book.date_time));

probe_start = find(date_time_probe == datetime(date_start+'-'+month_start+'-2007 08:05:00'));
probe_end = find(date_time_probe == datetime(date_end+'-'+month_end+'-2007 16:25:00'));

%probe_prices = cell2mat(jun.stk_haba.order_book.price(probe_start: probe_end));
%probe_prices = cell2mat(jul.stk_haba.order_book.price(probe_start: probe_end));
probe_prices = cell2mat(aug.stk_haba.order_book.price(probe_start: probe_end));

mid_price = mean(probe_prices, 2);
returns = [0;diff(log(mid_price))];
returns_skew = skewness(returns);
returns_kurt = kurtosis(returns);
cum_ret = cumsum(returns);
cum_ret_skew = skewness(cum_ret);
cum_ret_kurt = kurtosis(cum_ret);


%% Peaks and troughs

basis_points = 30; %change for different basis points

[maxtab_cumreturns, mintab_cumreturns] = peakdet(cum_ret,basis_points/10000);
figure
hold on; 
plot(mintab_cumreturns(:,1), mintab_cumreturns(:,2), 'g*');
plot(maxtab_cumreturns(:,1), maxtab_cumreturns(:,2), 'r*' );
plot(cum_ret,'b');
xlim([0,length(cum_ret)])
xlabel('Time')
ylabel ('Cumulative Return(%)')
legend('Trough','Peak','Cumulative Return','Location','Northwest') 
title('Peaks and Troughs in Cumulative Return with 30 basis points') 


%% NVWAP

probe_bids_nvwap = aug.stk_haba.order_book.bids((probe_start+13):(probe_start + 13));
probe_asks_nvwap = aug.stk_haba.order_book.asks((probe_start+13):(probe_start + 13));
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
    c_sub = 1;
    r_sub = ceil(time_range/c_sub);
    y = probe_start+i;
    z = datestr(date_time_probe(y),'HH:MM');
    subplot(r_sub,c_sub,i)
    hold("on")
    plot(b_vol,VWAP_bid,'r','LineWidth',2)
    plot(a_vol,VWAP_ask,'b','LineWidth',2)
    title("Orderbook at "+z)
    hold("off")
end

