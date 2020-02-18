classdef ImageTool < handle
    
    properties
        handles;
        handlesState;
        % handlesState -struct to store ui parameters
        % Selection - WindowButtonDown object
        % VisibleCursorA
        % positionCursorA
        % VisibleCursorB default off
        % positionCursorB
        % flagZDC -0 Visible off -1 Visible on
        % positionCursorZ
        % widthCursorZ - default 0 , set by obj.setWidthCursorZ(width)
        data;
        % x,y,value for 2D
        % x,y,z,value for 3D
        dataState;
        % dataName
        % dim - dimesion of data
        % direction 0-2D 1-yz/x 2-xz/y 3-xy/z
        % positionZ -  Z postion [] for 2D data
    end

    methods
        function obj = ImageTool( dataName )
            [obj.data, obj.dataState] = ImageTool.createData( dataName );
            obj.handles = ImageTool.createImageTool( obj );
            ImageTool.initializeCallback( obj );
            obj.handlesState = ImageTool.initializeHandlesState( obj );
        end
    end

    methods ( Hidden )
        updateImage( obj );
        updateEDC( obj );
        updateMDC( obj );
        updateZDC( obj );
        setWidthCursorZ( obj , width );
        callbackCursorImageButtonDown( obj, src, ~);
        callbackDragCursorImage( obj, src, ~);
        callbackCursorImageButtonUp(obj,src,~)
        callbackCursorZDCButtonDown( obj, src, ~);
        callbackDragCursorZDC( obj, src, ~);
        callbackCursorZDCButtonUp( obj, src, ~)
    end

    methods ( Hidden, Static )
        [data, dataState] = createData( dataName );
        handles = createImageTool( obj );
        handlesState = initializeHandlesState( obj );
        initializeCallback( obj );
    end
    
end