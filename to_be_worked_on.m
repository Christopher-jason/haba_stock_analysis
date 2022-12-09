%%%%%%%%%%%%%%% Cumulative of bids and asks in a time-frame %%%%%%%%%%%%%%%

%     [p_size , ~] = size(probe_bids_cells);
%     b_vol_day = zeros(p_size,1);
%     VWAP_bid_day = zeros(p_size,1);
%     a_vol_day = zeros(p_size,1);
%     VWAP_ask_day = zeros(p_size,1);
% 
%     for i = 1:p_size
%         %[probe_bids_i,~] = size(cell2mat(probe_bids_cells(i)));
%         %[probe_asks_i,~] = size(cell2mat(probe_asks_cells(i)));
%         %num_probe = max(probe_asks_i,probe_bids_i);
%         bid_data = cell2mat(probe_bids_cells(i));
%         b_val = sum(bid_data(:,1).*bid_data(:,2));
%         b_vol_day(i) = sum(bid_data(:,2));
%         VWAP_bid_day(i) = b_val./b_vol_day(i);
%         ask_data = cell2mat(probe_asks_cells(i));
%         a_val = sum(ask_data(:,1).*ask_data(:,2));
%         a_vol_day(i) = sum(ask_data(:,2));
%         VWAP_ask_day(i) = a_val./a_vol_day(i);
% 
% %         figure;
% %         hold("on")
% %         plot(b_vol,VWAP_bid,'b','LineWidth',2)
% %         plot(a_vol,VWAP_ask,'r','LineWidth',2)
% %         hold("off")
%     end
%     figure;
%     hold("on")
%     plot(b_vol_day,VWAP_bid_day,'b','LineWidth',2)
%     plot(a_vol_day,VWAP_ask_day,'r','LineWidth',2)
%     hold("off")


    %[n,~] = size(cell2mat(stk_haba.order_book.bids(23)))