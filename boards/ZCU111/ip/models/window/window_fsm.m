function [fifo_read, address, window_load, data_valid, data_tlast, data_tuser] = window_fsm(data_fifo_count, window_fifo_count, window_step, window_length)
% Define FSM States
WINDOW_LOAD = 0;
READ_FIFO = 1;

% Define m-code variables with the xl_state function
persistent state, state = xl_state(WINDOW_LOAD, {xlUnsigned, 2, 0});

persistent addr, addr = xl_state(0, {xlUnsigned, 11, 0});
persistent data_burst, data_burst = xl_state(0, {xlBoolean});
persistent n, n = xl_state(0, {xlUnsigned,12 ,0});

switch state
        
    case WINDOW_LOAD
        % Set outputs
        fifo_read = false;
        address = addr;
        window_load = true;
        data_valid = false;
        data_tlast = false;
        data_tuser = 0;
           
        % Keep the most recent data in the FIFO
        if (data_fifo_count > window_length)
            fifo_read = true;
        end
        
        if window_fifo_count > 0
            addr = xfix({xlUnsigned, 12, 0, xlTruncate, xlSaturate}, addr + window_step);
            n = xfix({xlUnsigned, 12, 0, xlTruncate, xlSaturate}, n + 1);
        end
            
        if n > window_length
            state = READ_FIFO;
            addr = 0;
            n = 0;
        end
            
    case READ_FIFO
        % Set outputs       
        fifo_read = false;
        address = addr;
        window_load = false;
        data_valid = false;
        data_tlast = false;
        data_tuser = 0;
        
        % Wait until a full frame is available 
        if data_fifo_count >= window_length
            data_burst = true;
        end
            
        % Again, keep the most recent data in the FIFO (push out older data)
        if (data_fifo_count > window_length)
            fifo_read = true;
        end
        
        if data_burst == true 
            fifo_read = true;
            data_valid = true;
            
            if addr == 0
                data_tuser = 1;
            end
            
            addr = xfix({xlUnsigned, 12, 0, xlTruncate, xlSaturate}, addr + window_step);
            n = xfix({xlUnsigned, 12, 0, xlTruncate, xlSaturate}, n + 1);
            
            if n > window_length 
                data_burst = false;
                n = 0;
                addr = 0;
                data_tlast = true;
            end
        end
        
        % When a full window is ready to be loaded and a data burst is not
        % in progress
        if window_fifo_count >= window_length && data_burst == false
            state = WINDOW_LOAD;
        end
        
    otherwise
        % Set outputs
        fifo_read = false;
        address = addr;
        window_load = false;
        data_valid = false;
        data_tlast = false;
        data_tuser = 0;
        
        % Reset variables
        n = 0;
        
        state = READ_FIFO;
        
end
