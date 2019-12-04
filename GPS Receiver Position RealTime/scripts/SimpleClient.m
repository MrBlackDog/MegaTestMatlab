classdef SimpleClient < WebSocketClient
    %CLIENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        RawMeas;
        RawMeasFlag = 0;
    end
    
    methods
        function obj = SimpleClient(varargin)
            %Constructor
            obj@WebSocketClient(varargin{:});
            
        end
    end
    
    methods (Access = protected)
        function onOpen(~,message)
            % This function simply displays the message received
            fprintf('%s\n',message);
            
        end
        
        function onTextMessage(obj,message)
            % This function simply displays the message received
            %fprintf('Message received:\n%s\n',message);
           obj.RawMeas = message;
           obj.RawMeasFlag = 1;
%             set('RawMeas',message);
%              set('RawMeasFlag',1);
        end

        function onBinaryMessage(~,bytearray)
            % This function simply displays the message received
            fprintf('Binary message received:\n');
            fprintf('Array length: %d\n',length(bytearray));
        end
        
        function onError(~,message)
            % This function simply displays the message received
            fprintf('Error: %s\n',message);
        end
        function onClose(~,message)
            % This function simply displays the message received
            fprintf('%s\n',message);
        end       
    end
      %   methods
        %    function set.RawMeas(this,value)
        %    this.RawMeas = value;
        %    end
         %   function value = get.RawMeas(this)
                
       %     end
    %end
end

