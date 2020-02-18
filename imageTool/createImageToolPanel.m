function handles = createImageToolPanel(varargin)
% createImageToolPanel returns to a handle that contains the panel 
% layout:
% 
% varargin{1}   parent object
% varargin{2}   data

%========check data========
guidata(varargin{1}, varargin{2});
data = varargin{2};
dataDim = ndims(data.value);
[X,Y] = meshgrid(data.x, data.y);
X = X';
Y = Y';
if dataDim == 2
    Z = data.value;
elseif dataDim ==3
    zindex = floor(length(data.z)/2);
    data.zCursor = data.z(zindex);
    data.zWidth = 0;
    data.zDirection = 'xy/z';
    guidata(varargin{1}, data);
    Z = data.value(:,:,zindex);
end


%===========layout for 2D data==================================
% Do NOT forget to tag every object
%
% create a grid panel 
handles.panelImageTool = uix.Panel( ...
	'Parent', varargin{1}, ...
	'Tag', 'panelImageTool');
% create a 2*2 grids to contain panels
handles.gridImageTool = uix.Grid( ...
	'Parent', handles.panelImageTool, ...
	'Tag', 'gridImageTool' );
% XDC Panel in topleft
handles.panelXDC = uix.Panel(...
    'Parent', handles.gridImageTool,...
	'BackgroundColor', 'w', ...
    'BorderType', 'none', ...
	'Tag', 'panelXDC');
% Image Panel in bottomleft
handles.panelImage = uix.Panel(...
    'Parent', handles.gridImageTool,...
	'BackgroundColor', 'w', ...
    'BorderType', 'none', ...
	'Tag', 'panelImage');
% ZDC Panel in topright
handles.panelZDC = uix.Panel(...
    'Parent', handles.gridImageTool,...
	'BackgroundColor', 'w', ...
    'BorderType', 'none', ...
	'Tag', 'panelZDC');
% YDC Panel in bottomright
handles.panelYDC = uix.Panel(...
    'Parent', handles.gridImageTool,...
	'BackgroundColor', 'w', ...
    'BorderType', 'none', ...
	'Tag', 'panelYDC');
% set scale for the 2*2 grid (sequence cannot be misset)
set( handles.gridImageTool, ...
	'Width', [-2 -1], ...
	'Height', [-1 -2] );
%---------axes-----------
% axes for image
handles.axesImage = axes( ...
	'Parent', handles.panelImage,...
    'Color','none', ...
    'Tag', 'axesImage');
% axes for XDC 
handles.axesXDC = axes( ...
	'Parent', handles.panelXDC,...
    'Color','none', ...
    'XAxisLocation', 'top', ...
    'Tag', 'axesXDC');
% axes for YDC
handles.axesYDC = axes( ...
	'Parent', handles.panelYDC,...
    'Color','none', ...
    'YAxisLocation', 'right', ...
    'Tag', 'axesYDC');
% axes for ZDC
handles.axesZDC = axes( ...
	'Parent', handles.panelZDC,...
    'Color','none', ...
    'XAxisLocation', 'top', ...
    'YAxisLocation', 'right', ...
    'Tag', 'axesZDC',...
    'XTick', [],...
    'YTick', []);

%---------initiate data and cursor-----------
% image in axesImage
handles.surfImage = pcolor(handles.axesImage, X,Y,Z);
shading( handles.axesImage, 'interp' );
handles.surfImage.Tag = 'surfImage';
handles.axesImage.Tag = 'axesImage'; % no idea, pcolor erased tag of axesImage
%---------cursor----------
XLim = handles.axesImage.XLim;
YLim = handles.axesImage.YLim;
handles.axesXDC.XLim = XLim;
handles.axesYDC.YLim = YLim;

% create crosshair cursor in upon Image
hold (handles.axesImage, 'on');
handles.lineCursorVertical = line( [XLim(1) XLim(1)], YLim, ...
    'Parent', handles.axesImage, ...
    'Marker', 'none',...
    'LineWidth', 1, ...
    'Color', 'r', ...
    'Tag', 'lineCursorVertical');
handles.lineCursorHorizontal = line( XLim, [YLim(1), YLim(1)], ...
    'Parent', handles.axesImage, ...
    'Marker', 'none',...
    'LineWidth', 1, ...
    'Color', 'r', ...
    'Tag', 'lineCursorHorizontal');
handles.crosshairCursor = plot( handles.axesImage,...
    XLim(1), YLim(1),...
    'Marker', 'square',...
    'MarkerSize', 10,...
    'LineWidth', 1, ...
    'MarkerFaceColor', 'none',...
    'Color', 'r', ...
    'Tag', 'crosshairCursor' );
hold (handles.axesImage, 'off');
% create XDC according to CursorHorizontal
x = X(:,1);
y = Z(:,1);
hold(handles.axesXDC,'on');
handles.XDC = plot(handles.axesXDC,x,y,...
    'LineWidth', 1);
handles.XDC.Tag = 'XDC';
% create cursor in XDC 
XLim = handles.axesImage.XLim;
YLim = handles.axesXDC.YLim;
handles.lineCursorXDC = plot(handles.axesXDC, [XLim(1),XLim(1)], YLim,...
	 'Color', 'r', ...
	 'LineWidth',1);
hold(handles.axesXDC,'off');
handles.lineCursorXDC.Tag = 'lineCursorXDC';
% create YDC according to CursorVertical
x = Z(1,:);
y = Y(1,:);
hold(handles.axesYDC,'on');
handles.YDC = plot(handles.axesYDC,x,y,...
    'LineWidth', 1);
handles.YDC.Tag = 'YDC';
% create cursor in YDC
XLim = handles.axesYDC.XLim;
YLim = handles.axesImage.YLim;
handles.lineCursorYDC = plot(handles.axesYDC, XLim, [YLim(1),YLim(1)],...
    'Color', 'r', ...
    'LineWidth',1);
hold(handles.axesYDC,'off');
handles.lineCursorYDC.Tag = 'lineCursorYDC';

% initiate ZDC objects for 3D data (mute at first)
hold(handles.axesZDC ,'on');
handles.ZDC = plot(handles.axesZDC,[0 0],[0 0],...
    'Visible', 'off',...
    'Tag','ZDC');
handles.lineCursorLeftZDC = plot(handles.axesZDC,[0 0],[0 0],...
    'Visible', 'off',...
    'Tag','lineCursorLeftZDC');
handles.lineCursorRightZDC = plot(handles.axesZDC,[0 0],[0 0],...
    'Visible', 'off',...
    'Tag','lineCursorRightZDC');
handles.lineCursorZDC = plot(handles.axesZDC,[0 0],[0 0],...
    'Visible', 'off',...
    'Tag','lineCursorZDC');
hold(handles.axesZDC,'off');
%==================layout for 3D data==========================
if ndims(data.value) == 3
    set(handles.axesZDC, ...
        'XLim',[min(data.z),max(data.z)],...
        'YTickMode','auto');
    handles.axesZDC.Title.String = ['Z = ', num2str(data.zCursor)];
    [~, indexXCursor] = min(abs(handles.crosshairCursor.XData - data.x));
    [~, indexYCursor] = min(abs(handles.crosshairCursor.YData - data.y));
    zdc = data.value(indexXCursor,indexYCursor,:);
    set(handles.ZDC,...
        'XData',data.z(:),...
        'YData',zdc(:),...
        'LineWidth', 1, ...
        'Visible', 'on');
    set(handles.lineCursorZDC,...
        'XData',[data.zCursor,data.zCursor],...
        'YData',handles.axesZDC.YLim,...
        'LineWidth',1,...
        'Color', 'red',...
        'Visible','on');
    set(handles.lineCursorLeftZDC,...
        'XData',[data.zCursor - data.zWidth,data.zCursor - data.zWidth],...
        'YData',handles.axesZDC.YLim,...
        'LineWidth',1,...
        'Color', 'red',...
        'Visible','on');
    set(handles.lineCursorRightZDC,...
        'XData',[data.zCursor + data.zWidth,data.zCursor + data.zWidth],...
        'YData',handles.axesZDC.YLim,...
        'LineWidth',1,...
        'Color', 'red',...
        'Visible','on');
end

%======= set CallBacks=======
handles.crosshairCursor.ButtonDownFcn = @crosshairCursorButtonDownCallback;
handles.lineCursorVertical.ButtonDownFcn = @lineCursorVerticalButtonDownCallback;
handles.lineCursorHorizontal.ButtonDownFcn = @lineCursorHorizontalButtonDownCallback;
handles.lineCursorXDC.ButtonDownFcn = @lineCursorXDCButtonDownCallback;
handles.lineCursorYDC.ButtonDownFcn = @lineCursorYDCButtonDownCallback;
handles.lineCursorZDC.ButtonDownFcn = @lineCursorZDCButtonDownCallback;
%======== end set Callbacks=====



end


%==============Callbacks========================
function crosshairCursorButtonDownCallback(src,~)
    handles = guihandles(gcf);
    set(gcf,'Pointer','crosshair');
    set(gcf,'WindowButtonUpFcn', @cursorButtonUpCallback);
    set(gcf,'WindowButtonMotionFcn',@crosshairCursorMotionCallback);
end

function lineCursorVerticalButtonDownCallback(src,~)
    set(gcf,'Pointer','left');
    set(gcf,'WindowButtonUpFcn', @cursorButtonUpCallback);
    set(gcf,'WindowButtonMotionFcn',@lineCursorVerticalMotionCallback);
end

function lineCursorHorizontalButtonDownCallback(src,~)
    set(gcf,'Pointer','top');
    set(gcf,'WindowButtonUpFcn', @cursorButtonUpCallback);
    set(gcf,'WindowButtonMotionFcn',@lineCursorHorizontalMotionCallback);
end

function lineCursorXDCButtonDownCallback(src,~)
    set(gcf,'Pointer','left');
    set(gcf,'WindowButtonUpFcn', @cursorButtonUpCallback);
    set(gcf,'WindowButtonMotionFcn',@lineCursorXDCMotionCallback);
end

function lineCursorYDCButtonDownCallback(src,~)
    set(gcf,'Pointer','top');
    set(gcf,'WindowButtonUpFcn', @cursorButtonUpCallback);
    set(gcf,'WindowButtonMotionFcn',@lineCursorYDCMotionCallback);
end

function lineCursorZDCButtonDownCallback(src,~)
    set(gcf,'Pointer','left');
    set(gcf,'WindowButtonUpFcn', @cursorButtonUpCallback);
    set(gcf,'WindowButtonMotionFcn',@lineCursorZDCMotionCallback);
end

function crosshairCursorMotionCallback(src,~)
    handles = guihandles(src);
    Position = handles.axesImage.CurrentPoint;
    data = struct();
    data.x = handles.surfImage.XData(:,1);
    data.y = handles.surfImage.YData(1,:);
    data.value = handles.surfImage.CData;
    [~, xindexCurrentCursor] = min(abs(data.x(:) - Position(1,1)));
    [~, yindexCurrentCursor] = min(abs(data.y(:) - Position(1,2)));
    xCurrentCursor=data.x(xindexCurrentCursor);
    yCurrentCursor=data.y(yindexCurrentCursor);
    % update crosshair in axesimage
    cursorPoint = handles.crosshairCursor;
    cursorVertical = handles.lineCursorVertical;
    cursorHorizontal = handles.lineCursorHorizontal;
    set( cursorPoint, 'XData', xCurrentCursor, 'YData', yCurrentCursor );
    set( cursorVertical, 'XData', [xCurrentCursor,xCurrentCursor] );
    set( cursorHorizontal, 'YData', [yCurrentCursor,yCurrentCursor] );
    % update XDC and YDC
    set( handles.lineCursorXDC, 'Visible','off');
    set( handles.XDC, 'YData', data.value(:,yindexCurrentCursor));
    set( handles.lineCursorYDC, 'Visible','off');
    set( handles.YDC, 'XData', data.value(xindexCurrentCursor,:));
    % update cursor in XDC and YDC
    set( handles.lineCursorXDC,...
         'XData', [xCurrentCursor,xCurrentCursor],...
         'YData', handles.axesXDC.YLim,...
         'Visible', 'on');
    set( handles.lineCursorYDC,...
         'XData', handles.axesYDC.XLim,...
         'YData', [yCurrentCursor,yCurrentCursor],...
         'Visible', 'on');
    updateZDC();
end

function lineCursorVerticalMotionCallback(src,~)
    handles = guihandles(src);
    Position = handles.axesImage.CurrentPoint;
    data = struct();
    data.x = handles.surfImage.XData(:,1);
    data.y = handles.surfImage.YData(1,:);
    data.value = handles.surfImage.CData;
    [~, xindexCurrentCursor] = min(abs(data.x(:) - Position(1,1)));
    [~, yindexCurrentCursor] = min(abs(data.y(:) - Position(1,2)));
    xCurrentCursor=data.x(xindexCurrentCursor);
    yCurrentCursor=data.y(yindexCurrentCursor);
    cursorPoint = handles.crosshairCursor;
    cursorVertical = handles.lineCursorVertical;
    set( cursorPoint, 'XData', xCurrentCursor );
    set( cursorVertical, 'XData', [xCurrentCursor,xCurrentCursor] );
    set( handles.lineCursorXDC,...
         'XData', [xCurrentCursor,xCurrentCursor],...
         'YData', handles.axesXDC.YLim)
    set( handles.lineCursorYDC, 'Visible','off');
    set( handles.YDC, 'XData', data.value(xindexCurrentCursor,:));
    set( handles.lineCursorYDC,...
         'XData', handles.axesYDC.XLim,...
         'Visible', 'on');
    updateZDC();
end

function lineCursorHorizontalMotionCallback(src,~)
    handles = guihandles(src);
    Position = handles.axesImage.CurrentPoint;
    data = struct();
    data.x = handles.surfImage.XData(:,1);
    data.y = handles.surfImage.YData(1,:);
    data.value = handles.surfImage.CData;
    [~, xindexCurrentCursor] = min(abs(data.x(:) - Position(1,1)));
    [~, yindexCurrentCursor] = min(abs(data.y(:) - Position(1,2)));
    yCurrentCursor=data.y(yindexCurrentCursor);
    cursorPoint = handles.crosshairCursor;
    cursorHorizontal = handles.lineCursorHorizontal;
    set( cursorPoint, 'YData', yCurrentCursor );
    set( cursorHorizontal, 'YData', [yCurrentCursor,yCurrentCursor] );
    set( handles.lineCursorYDC,...
        'XData', handles.axesYDC.XLim,...
        'YData', [yCurrentCursor,yCurrentCursor]);
    set( handles.lineCursorXDC, 'Visible','off');
    set( handles.XDC, 'YData', data.value(:, yindexCurrentCursor));
    set( handles.lineCursorXDC,...
         'YData', handles.axesXDC.YLim,...
         'Visible', 'on');
    updateZDC();
end

function lineCursorXDCMotionCallback(src,~)
    handles = guihandles(src);
    Position = handles.axesXDC.CurrentPoint;
    data = struct();
    data.x = handles.XDC.XData;
    data.value = handles.surfImage.CData;
    [~, xindexCurrentCursor] = min(abs(data.x(:) - Position(1,1)));
    xCurrentCursor = data.x(xindexCurrentCursor);
    cursorPoint = handles.crosshairCursor;
    cursorVertical = handles.lineCursorVertical;
    set( cursorPoint, 'XData', xCurrentCursor );
    set( cursorVertical, 'XData', [xCurrentCursor,xCurrentCursor] );
    set( handles.lineCursorXDC,...
        'XData', [xCurrentCursor,xCurrentCursor]);
    set( handles.lineCursorYDC, 'Visible','off');
    set( handles.YDC, 'XData', data.value(xindexCurrentCursor,:));
    set( handles.lineCursorYDC,...
         'XData', handles.axesYDC.XLim,...
         'Visible', 'on');
    updateZDC();
end

function lineCursorYDCMotionCallback(src,~)
    handles = guihandles(src);
    Position = handles.axesYDC.CurrentPoint;
    data = struct();
    data.y = handles.YDC.YData;
    data.value = handles.surfImage.CData;
    [~, yindexCurrentCursor] = min(abs(data.y(:) - Position(1,2)));
    yCurrentCursor = data.y(yindexCurrentCursor);
    cursorPoint = handles.crosshairCursor;
    cursorHorizontal = handles.lineCursorHorizontal;
    set( cursorPoint, 'YData', yCurrentCursor );
    set( cursorHorizontal, 'YData', [yCurrentCursor,yCurrentCursor] );
    set( handles.lineCursorYDC,...
        'YData', [yCurrentCursor,yCurrentCursor]);
    set( handles.lineCursorXDC, 'Visible','off');
    set( handles.XDC, 'YData', data.value(:,yindexCurrentCursor));
    set( handles.lineCursorXDC,...
         'YData', handles.axesXDC.YLim,...
         'Visible', 'on');
    updateZDC();
end

function lineCursorZDCMotionCallback(src,~)
    handles = guihandles(src);
    data = guidata(gcf);
    Position = handles.axesZDC.CurrentPoint;
    [~, minindex] = min( abs( handles.ZDC.XData(:) - (handles.ZDC.XData(1) + data.zWidth/2) ) );
    [~, maxindex] = min( abs( handles.ZDC.XData(:) - (handles.ZDC.XData(end) - data.zWidth/2) ) );
    [~, zindexCurrentCursor] = min(abs(handles.ZDC.XData(minindex:maxindex) - Position(1,1)));
    zindexCurrentCursor = zindexCurrentCursor + minindex - 1;
    zCurrentCursor = data.z(zindexCurrentCursor);
    data.zCursor = zCurrentCursor;
    guidata(gcf,data);
    set( handles.lineCursorZDC,...
         'XData', [zCurrentCursor, zCurrentCursor]);
    set( handles.lineCursorLeftZDC,...
         'XData', [zCurrentCursor - data.zWidth, zCurrentCursor - data.zWidth]);
    set( handles.lineCursorRightZDC,...
         'XData', [zCurrentCursor + data.zWidth, zCurrentCursor + data.zWidth]);
    handles.axesZDC.Title.String = ['Z = ', num2str(data.zCursor)];
    updateImage();
end

function cursorButtonUpCallback(src,~)
    set(gcf,'Pointer','arrow');
    set(gcf,'WindowButtonMotionFcn',[]);
end

%===============axes updates==================
function updateImage(src,~)
    handles = guihandles(gcf);
    data = guidata(gcf);
    if ndims(data.value) == 3
        switch data.zDirection
            case 'xy/z'
                x = data.x;
                y = data.y;
                z = data.z;
                value = data.value;
            case 'yz/x'
                x = data.y;
                y = data.z;
                z = data.x;
                value = permute(data.value, [2 3 1]);
            case 'xz/y'
                x = data.x;
                y = data.z;
                z = data.y;
                value = permute(data.value, [1 3 2]);
            otherwise
                return
        end
        cursorZCenter = data.zCursor;
        width = data.zWidth;
        [~,indexZCenter] = min(abs(z - data.zCursor));
        [~,indexZLeft] = min(abs(z - (data.zCursor - width/2)));
        [~,indexZRight] = min(abs(z - (data.zCursor + width/2)));
        if ( indexZLeft == indexZRight)
            CData = value(:,:,indexZCenter);
        else
            CData= mean(value(:,:,[indexZLeft:indexZRight]), 3);
        end
        set( handles.surfImage, ...
            'CData', CData );
        updateXDC();
        updateYDC();
    end
end

function updateXDC(src,~)
    handles = guihandles(gcf);
    cursorX = handles.crosshairCursor.XData;
    cursorY = handles.crosshairCursor.YData;
    data = struct();
    data.x = handles.surfImage.XData(:,1);
    data.y = handles.surfImage.YData(1,:);
    data.value = handles.surfImage.CData;
    [~, yindexCurrentCursor] = min(abs(data.y(:) - cursorY));
    set( handles.lineCursorXDC, 'Visible','off');
    set( handles.XDC, 'YData', data.value(:,yindexCurrentCursor));
    set( handles.lineCursorXDC,...
         'YData', handles.axesXDC.YLim,...
         'Visible', 'on');
end

function updateYDC(src,~)
    handles = guihandles(gcf);
    cursorX = handles.crosshairCursor.XData;
    cursorY = handles.crosshairCursor.YData;
    data = struct();
    data.x = handles.surfImage.XData(:,1);
    data.y = handles.surfImage.YData(1,:);
    data.value = handles.surfImage.CData;
    [~, xindexCurrentCursor] = min(abs(data.x(:) - cursorX));
    set( handles.lineCursorYDC, 'Visible','off');
    set( handles.YDC, 'XData', data.value(xindexCurrentCursor,:));
    set( handles.lineCursorYDC,...
         'XData', handles.axesYDC.XLim,...
         'Visible', 'on');
end

function updateZDC(src,~)
    handles = guihandles(gcf);
    data = guidata(gcf);
    [~, indexXCursor] = min(abs(handles.crosshairCursor.XData - data.x));
    [~, indexYCursor] = min(abs(handles.crosshairCursor.YData - data.y));
    zdc = data.value(indexXCursor,indexYCursor,:);
    set(handles.lineCursorLeftZDC,...
        'Visible', 'off');
    set(handles.lineCursorRightZDC,...
        'Visible', 'off');
    set(handles.lineCursorZDC,...
        'Visible', 'off');
    set(handles.ZDC, 'YData', zdc(:));
    YLim = handles.axesZDC.YLim;
    set(handles.lineCursorLeftZDC,...
        'YData', YLim, ...
        'Visible', 'on');
    set(handles.lineCursorRightZDC,...
        'YData', YLim, ...
        'Visible', 'on');
    set(handles.lineCursorZDC,...
        'YData', YLim, ...
        'Visible', 'on');
end

%================utilities================
function setWidthZDC( width )
    handles = guihandles(gcf);
    data = guidata(gcf);
    XLim = handles.axesZDC.XLim;
    if (width < 0) || (width > abs(XLim(1)-XLim(2)))
        % check validity
        return;
    end
    zCursor = data.zCursor;
    leftCursor = zCursor - width/2;
    rightCursor = zCursor + width/2;
    if leftCursor < XLim(1)
        zCursor = XLim(1) + width/2;
        rightCursor = zCursor + width/2;
    elseif rightCursor > XLim(2)
        zCursor = XLim(2) - width/2;
        leftCursor = zCursor - width/2;
    end

end


