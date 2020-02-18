function h = ImageTool_v1(varargin)

%======load data============
data = varargin{1};

%=======layout================
h.FigMain = figure();

%Left for control panels, right for image panel
h.HBox_1 = uix.HBox( 'Parent', h.FigMain );
h.panelControl = uix.ScrollingPanel( 'Parent', h.HBox_1);
h.panelImageTool = createImageToolPanel(h.HBox_1, data);
set( h.HBox_1, 'Width', [200, -1]);

h.VBox_1 = uix.VBox( 'Parent', h.panelControl);
h.panelInfo = createInfoPanel( h.VBox_1 );
end