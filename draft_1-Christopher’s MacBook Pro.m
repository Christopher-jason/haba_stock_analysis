%% Load data
%%% Remove the '%' in the month you want to work with and run the program

%aug_data = load('stk_aug07.mat', 'stk_haba');
%jun_date = load('stk_jun07.mat','stk_haba');
%jul_data = load('stk_jul07.mat','stk_haba');

%% Process Data

%%%%%%%%%%%%%%%%%%%   Date   %%%%%%%%%%%%%%%%%%%%%%%%
%date = stk_haba.order_book.date_time;  //get data from struct
%TODO: - get month and date from user with data validation
month = "Aug";     % Enter the month you loaded
date_start = "14"; %watch-out for weekends
date_end = "16";   %watch-out for weekends
%TODO: - Manipulate start and end time as well

[probe_start,probe_end]= getDates(stk_haba,month,date_start,date_end);
probe_prices = getPrices(stk_haba,probe_start,probe_end,month,date_start,date_end);
mid_price = getMidPrice(probe_prices,month,date_start,date_end);
[returns,cum_ret] = getReturn(mid_price,month,date_start,date_end);

function [probe_start,probe_end] = getDates(stk_haba,month,date_start,date_end)
    date_time = datetime(datestr(stk_haba.order_book.date_time));
    probe_start = find(date_time == datetime(date_start+'-'+month+'-2007 08:05:00'));
    probe_end = find(date_time == datetime(date_end+'-'+month+'-2007 16:25:00'));
    %probe_dates = (date_time(probe_start : probe_end));
end

%%%%%%%%%%%%%%%%%%%   Price  %%%%%%%%%%%%%%%%%%%%%%%%
%price = cell2mat(stk_haba.order_book.price);   //get price from struct

function probe_prices = getPrices(stk_haba,probe_start,probe_end,month,date_start,date_end)
    probe_prices = cell2mat(stk_haba.order_book.price(probe_start: probe_end));

    %TODO: Check how to display dates on x-axis to show only specific time of day for each day 
    figure; %Price plot
    plot(probe_prices,'lineWidth',2);
    xlim([0,length(probe_prices)])
    xlabel('Date');
    ylabel('Price');
    title('Price for '+ month +' '+date_start+'-'+date_end);
    legend("Bids","Asks");

end

%%%%%%%%%%%%%%%%%%%   Mid-Price   %%%%%%%%%%%%%%%%%%%%%%%%
function mid_price = getMidPrice(probe_prices,month,date_start,date_end)
    mid_price = mean(probe_prices, 2);

    figure; %Mid price plot
    plot(mid_price,'lineWidth',2);
    xlim([0,length(mid_price)])
    xlabel('Date');
    ylabel('Price');
    title('Mid-Price for '+ month +' '+date_start+'-'+date_end);
    legend("Mid Price");
end

%%%%%%%%%%%%%%%%%%%   Returns   %%%%%%%%%%%%%%%%%%%%%%%%
function [returns,cum_ret] = getReturn(mid_price,month,date_start,date_end)

    returns = [0;diff(log(mid_price))];
    ret_skew = skewness(returns)
    ret_kurt = kurtosis(returns)

    figure; %Returns plot
    plot(returns,'r','lineWidth',2);
    hold("on")

    cum_ret = cumsum(returns);
    cum_ret_skew = skewness(cum_ret)
    cum_ret_kurt = kurtosis(cum_ret)

    plot(cum_ret,'b','lineWidth',2);
    xlim([0,length(returns)])
    xlabel('Date');
    ylabel('Price');
    title('Returns for '+ month +' '+date_start+'-'+date_end);
    legend("Return","Cumulative Returns");
    hold("off")
end





