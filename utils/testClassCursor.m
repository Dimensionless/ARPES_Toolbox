[X,Y,Z] = peaks(200);
handles.Figure = figure();
handles.Axes = axes(handles.Figure);
handles.Surface = pcolor(X,Y,Z);
shading(handles.Axes,'interp');
handles.Cursor1 = Cursor(handles.Axes);
handles.Cursor2 = Cursor(handles.Axes,0,0);