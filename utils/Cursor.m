classdef Cursor < handle
    % Cursor object can be constructed by:
    % 1. hCursor = Cursor(Axes)
    % 2. hCursor = Cursor(Axes,posX,posY)
    
    properties ( Access = private )        % hierachy
        hParent % should be an axes class
        hImage
        hCrosshair
        hCursorX
        hCursorY
    end
    
    properties (SetObservable, AbortSet)
        % data 
        Position
    end
    
    properties % appearence
        Marker = 'square';
        Color = 'red';
    end
    
    properties (Hidden) % flag
        isActive = 1;
        isCoupled = 0;
        hCoupled;
        Tag = 'Cursor';
    end
    
    properties (Hidden, Dependent)
        hasImage;
        Index;
    end
    
    methods  % basics
        
        function obj = Cursor( Parent, varargin )
            % Constructor
            assert(isa(Parent,'matlab.graphics.axis.Axes'),'Parent should be an axes');
            obj.hParent = Parent;
            % initiate handles
            obj.initiateHandles();
            obj.setCallbacks();
            % handles listen to the position property
            addlistener(obj,'Position','PostSet',@obj.updateHandles);
            % initiate position
            if (nargin < 2)
                obj.Position = [Parent.XLim(1),Parent.YLim(1)];
            else 
                assert( nargin == 3, 'Input Error');
                obj.Position = [varargin{1},varargin{2}];
            end
        end
        
        function set.Position(obj, NewCursor)
            XLim = obj.hParent.XLim;
            YLim = obj.hParent.YLim;
            X = NewCursor(1);
            Y = NewCursor(2);
            % check if the new position is out of range 
            if X < XLim(1)
                X = XLim(1);
            elseif X > XLim(2)
                X = XLim(2);
            end
            if Y < YLim(1)
                Y = YLim(1);
            elseif Y > YLim(2)
                Y = YLim(2);
            end
            obj.Position = [X, Y];
        end
        
        function initiateHandles(obj)
            hAxes = obj.hParent;
            XLim = hAxes.XLim;
            YLim = hAxes.YLim;
            hold (hAxes, 'on');
            obj.hCursorX = line( [XLim(1) XLim(1)], YLim, ...
                'Parent', hAxes, ...
                'Marker', 'none',...
                'LineWidth', 0.5, ...
                'Color', 'r', ...
                'Tag', 'lineCursorX');
            obj.hCursorY = line( XLim, [YLim(1), YLim(1)], ...
                'Parent', hAxes, ...
                'Marker', 'none',...
                'LineWidth', 0.5, ...
                'Color', 'r', ...
                'Tag', 'lineCursorY');
            obj.hCrosshair = plot( hAxes,...
                XLim(1), YLim(1),...
                'Marker', 'square',...
                'MarkerSize', 10,...
                'LineWidth', 0.5, ...
                'MarkerFaceColor', 'none',...
                'Color', 'r', ...
                'Tag', 'pointCrosshair' );
            hold (hAxes, 'off');
        end
        
        function updateHandles(obj,src,~)
            set( obj.hCrosshair, 'XData', obj.Position(1), 'YData', obj.Position(2) );
            set( obj.hCursorX, 'XData', [obj.Position(1),obj.Position(1)] );
            set( obj.hCursorY, 'YData', [obj.Position(2),obj.Position(2)] );
        end
    end
    
    methods  % appearence
        
        function set.Color(obj,newColor)
            obj.hCrosshair.Color = newColor;
            obj.hCursorX.Color = newColor;
            obj.hCursorY.Color = newColor;
            updateHandles(obj);
        end
        
        function set.Marker(obj,newMarker)
            obj.hCrosshair.Marker = newMarker;
            updateHandles(obj);
        end

    end
        
    methods  % callbacks
        
        function obj = setCallbacks(obj)
            obj.hCrosshair.ButtonDownFcn = @obj.crosshairButtonDownCallback;
            obj.hCursorX.ButtonDownFcn = @obj.hCursorXButtonDownCallback;
            obj.hCursorY.ButtonDownFcn = @obj.hCursorYButtonDownCallback;
        end
        
        function crosshairButtonDownCallback(obj,src,~)
            set(gcf,'Pointer','crosshair');
            set(gcf,'WindowButtonUpFcn', @obj.crosshairButtonUpCallback);
            set(gcf,'WindowButtonMotionFcn',@obj.crosshairMotionCallback);
        end
        
        function crosshairButtonUpCallback(obj,src,~)
            set(gcf,'Pointer','arrow');
            set(gcf,'WindowButtonMotionFcn',[]);
        end
        
        function crosshairMotionCallback(obj,src,~)
            hAxes = obj.hParent;
            Position = hAxes.CurrentPoint(1,1:2);
            Position = Position(1,1:2);
            obj.Position = Position;
        end
        
        function hCursorXButtonDownCallback(obj,src,~)
            set(gcf,'Pointer','left');
            set(gcf,'WindowButtonUpFcn', @obj.hCursorXButtonUpCallback);
            set(gcf,'WindowButtonMotionFcn',@obj.hCursorXMotionCallback);
        end
        
        function hCursorXButtonUpCallback(obj,src,~)
            set(gcf,'Pointer','arrow');
            set(gcf,'WindowButtonMotionFcn',[]);
        end
        
        function hCursorXMotionCallback(obj,src,~)
            hAxes = obj.hParent;
            Position = hAxes.CurrentPoint(1,1:2);
            Position = [Position(1,1),obj.Position(2)];
            obj.Position = Position;
        end
        
        function hCursorYButtonDownCallback(obj,src,~)
            set(gcf,'Pointer','top');
            set(gcf,'WindowButtonUpFcn', @obj.hCursorYButtonUpCallback);
            set(gcf,'WindowButtonMotionFcn',@obj.hCursorYMotionCallback);
        end
        
        function hCursorYButtonUpCallback(obj,src,~)
            set(gcf,'Pointer','arrow');
            set(gcf,'WindowButtonMotionFcn',[]);
        end
        
        function hCursorYMotionCallback(obj,src,~)
            hAxes = obj.hParent;
            Position = hAxes.CurrentPoint(1,1:2);
            Position = [obj.Position(1),Position(1,2)];
            obj.Position = Position;
        end
    end
    
    methods  % utils
        
        function tf = get.hasImage(obj)
            obj.hImage = findobj(obj.hParent,'type','Surface');
            tf = isvalid(obj.hImage);
        end
        
        function switchOn(obj)
            % check if position is still in valid rang
            if ~obj.isActive
%                 XLim = obj.hParent.XLim;
%                 YLim = obj.hParent.YLim;         
%                 XinRange = (obj.Position(1) > XLim(1)) & (obj.Position(1) < XLim(2));
%                 YinRange = (obj.Position(2) > YLim(1)) & (obj.Position(2) < YLim(2));
%                 if ~(XinRange & YinRange)
%                     obj.Position = [obj.hParent.XLim(1),obj.hParent.YLim(1)];
%                 end
                obj.hCrosshair.Visible = 'on';
                obj.hCursorX.Visible = 'on';
                obj.hCursorY.Visible = 'on';
                obj.isActive = 1;
            end
        end
        
        function switchOff(obj)
            if obj.isActive
                obj.hCrosshair.Visible = 'off';
                obj.hCursorX.Visible = 'off';
                obj.hCursorY.Visible = 'off';
                obj.isActive = 0;
            end
        end
        
        function Index = get.Index(obj)
            Index = [nan,nan];
            if obj.hasImage
                if isvector(obj.hImage.XData)
                    xScale = obj.hImage.XData;
                else
                    xScale = obj.hImage.XData(1,:);
                end
                if isvector(obj.hImage.YData)
                    yScale = obj.hImage.YData;
                else
                    yScale = obj.hImage.YData(:,1);
                end
                [~,xIndex] = min(abs(xScale - obj.Position(1)));
                [~,yIndex] = min(abs(yScale - obj.Position(2)));
                Index = [xIndex,yIndex];
            end
        end
       
    end
    
    methods( Static )
        function tf = checkVarargin(varargin)
            assert(isa(Parent,'matlab.graphics.axis.Axes'))
        end
    end
    
end