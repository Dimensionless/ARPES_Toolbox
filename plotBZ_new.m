function varargout = plotBZ_new(varargin)
% PLOTBZ_NEW Guide code for plotBZ_new.fig
% All 14 Bravais lattices included
% Package needed: matGeom, see(https://github.com/dlegland/matGeom/wiki)
% lastly edited by Xiang Xu 04-Aug-2016
% Bug report: xiangxu1002@gmail.com

% Last Modified by GUIDE v2.5 06-Aug-2016 21:52:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotBZ_new_OpeningFcn, ...
                   'gui_OutputFcn',  @plotBZ_new_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before plotBZ_new is made visible.
function plotBZ_new_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotBZ_new (see VARARGIN)

% Choose default command line output for plotBZ_new
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotBZ_new wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotBZ_new_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in LatticeSystem.
function LatticeSystem_Callback(hObject, eventdata, handles)
% hObject    handle to LatticeSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 7 LatticeSystems with 14 Bravais Lattices
LatticeSystem_index = get(handles.LatticeSystem,'value');
str = get(handles.LatticeSystem,'String');
LatticeSystem_type = str{LatticeSystem_index};
switch LatticeSystem_type
    case 'Cubic'
        set(handles.radio_primitive,'Value',1,'Enable','on');
        set(handles.radio_bodycentered,'Enable','on');
        set(handles.radio_facecentered,'Enable','on');
        set(handles.radio_basecentered,'Enable','off');
        set(handles.a,'Enable','on');
        set(handles.b,...
            'String',get(handles.a,'String'),...
            'Enable','off');
        set(handles.c,...
            'String',get(handles.a,'String'),...
            'Enable','off');
        set(handles.alpha,...
            'String', '90',...
            'Enable','off');
        set(handles.beta,...
            'String', '90',...
            'Enable','off');
        set(handles.gamma,...
            'String', '90',...
            'Enable','off');
    case 'Orthorhombic' 
        set(handles.radio_primitive,'Enable','on');
        set(handles.radio_bodycentered,'Enable','on');
        set(handles.radio_facecentered,'Enable','on');
        set(handles.radio_basecentered,'Enable','on');
        set(handles.a,'Enable','on');
        set(handles.b,'Enable','on');
        set(handles.c,'Enable','on');
        set(handles.alpha,...
            'String', '90',...
            'Enable','off');
        set(handles.beta,...
            'String', '90',...
            'Enable','off');
        set(handles.gamma,...
            'String', '90',...
            'Enable','off');
    case 'Tetragonal' 
        set(handles.radio_primitive,'Value',1,'Enable','on');
        set(handles.radio_bodycentered,'Enable','on');
        set(handles.radio_facecentered,'Enable','off');
        set(handles.radio_basecentered,'Enable','off');
        set(handles.a,'Enable','on');
        set(handles.b,...
            'String',get(handles.a,'String'),...
            'Enable','off');
        set(handles.c,'Enable','on');
        set(handles.alpha,...
            'String', '90',...
            'Enable','off');
        set(handles.beta,...
            'String', '90',...
            'Enable','off');
        set(handles.gamma,...
            'String', '90',...
            'Enable','off');
    case 'Hexagonal'
        set(handles.radio_primitive,'Value',1 ,'Enable','off');
        set(handles.radio_bodycentered,'Enable','off');
        set(handles.radio_facecentered,'Enable','off');
        set(handles.radio_basecentered,'Enable','off');
        set(handles.a,'Enable','on');
        set(handles.b,...
            'String',get(handles.a,'String'),...
            'Enable','off');
        set(handles.c,'Enable','on');
        set(handles.alpha,...
            'String', '90',...
            'Enable','off');
        set(handles.beta,...
            'String', '90',...
            'Enable','off');
        set(handles.gamma,...
            'String', '120',...
            'Enable','off');
    case 'Trigonal'
        set(handles.radio_primitive,'Value',1 ,'Enable','off');
        set(handles.radio_bodycentered,'Enable','off');
        set(handles.radio_facecentered,'Enable','off');
        set(handles.radio_basecentered,'Enable','off');
        set(handles.a,'Enable','on');
        set(handles.b,...
            'String',get(handles.a,'String'),...
            'Enable','off');
        set(handles.c,...
            'String',get(handles.a,'String'),...
            'Enable','off');
        set(handles.alpha,...
            'Enable','on');
        set(handles.beta,...
            'String',get(handles.alpha,'String'),...
            'Enable','off');
        set(handles.gamma,...
            'String',get(handles.alpha,'String'),...
            'Enable','off');
    case 'Triclinic'
        set(handles.radio_primitive,'Value',1 ,'Enable','off');
        set(handles.radio_bodycentered,'Enable','off');
        set(handles.radio_facecentered,'Enable','off');
        set(handles.radio_basecentered,'Enable','off');
        set(handles.a,'Enable','on');
        set(handles.b,'Enable','on');
        set(handles.c,'Enable','on');
        set(handles.alpha,'Enable','on');
        set(handles.beta,'Enable','on');
        set(handles.gamma,'Enable','on');
    case 'Monoclinic'
        set(handles.radio_primitive,'Value',1,'Enable','on');
        set(handles.radio_bodycentered,'Enable','off');
        set(handles.radio_facecentered,'Enable','off');
        set(handles.radio_basecentered,'Enable','on');
        set(handles.a,'Enable','on');
        set(handles.b,'Enable','on');
        set(handles.c,'Enable','on');
        set(handles.alpha,...
            'String', '90',...
            'Enable','off');
        set(handles.beta,'Enable','on');
        set(handles.gamma,...
            'String', '90',...
            'Enable','off');
    otherwise
        return;
end

% --- Executes during object creation, after setting all properties.
function LatticeSystem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LatticeSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set uneditable length to a.string
set(findobj(handles.panel_cell_length,'Enable','off'),'String',get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c_Callback(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c as text
%        str2double(get(hObject,'String')) returns contents of c as a double


% --- Executes during object creation, after setting all properties.
function c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double
LatticeSystem_index = get(handles.LatticeSystem,'value');
str = get(handles.LatticeSystem,'String');
LatticeSystem_type = str{LatticeSystem_index};
if strcmp(LatticeSystem_type,'Trigonal')
    set(handles.beta,'String',get(hObject,'String'));
    set(handles.gamma,'String',get(hObject,'String'));
else
    return
end

% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_Callback(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta as text
%        str2double(get(hObject,'String')) returns contents of beta as a double


% --- Executes during object creation, after setting all properties.
function beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gamma_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Plot3DPushButton.
function Plot3DPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to Plot3DPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Reciprocal_Lattice = LoadParameters(handles);
% Plot 3D BZ (to be updated)
[Vertice,faces] = generate_BZ(0,0,0,Reciprocal_Lattice);
FigNum = str2num(get(handles.figureNum,'str'));
figure(FigNum);
%choose color
lcc = ChooseColor(handles);
%plot! Here you can modify the appearence of the BZ
handles.BZ3D = drawMesh(Vertice, faces,...
                        'FaceColor',lcc,...
                        'FaceAlpha',0.1,...
                        'LineWidth',2,...
                        'EdgeColor',lcc,...
                        'Edgealpha',1,...
                        'Tag','BZ3D');
axis equal;
view(3);

% Append Reciprocal Vectors
if get(handles.CheckVectors,'Value') == 1
    drawVector3d([0 0 0],Reciprocal_Lattice(1,:));
    drawVector3d([0 0 0],Reciprocal_Lattice(2,:));
    drawVector3d([0 0 0],Reciprocal_Lattice(3,:));
end

% Append Lattices
if get(handles.CheckLattice,'Value') == 1
    drawPoint3d([0 0 0]);
end
guidata(hObject,handles);

function MillerH_Callback(hObject, eventdata, handles)
% hObject    handle to MillerH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MillerH as text
%        str2double(get(hObject,'String')) returns contents of MillerH as a double
temp = str2num(get(hObject,'String'));
if fix(temp) ~= temp
    errordlg('please input an integer!');
    set(hObject,'str','0');
    return;
end

% --- Executes during object creation, after setting all properties.
function MillerH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MillerH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MillerK_Callback(hObject, eventdata, handles)
% hObject    handle to INDEX_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of INDEX_K as text
%        str2double(get(hObject,'String')) returns contents of INDEX_K as a double


% --- Executes during object creation, after setting all properties.
function MillerK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to INDEX_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MillerL_Callback(hObject, eventdata, handles)
% hObject    handle to MillerL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MillerL as text
%        str2double(get(hObject,'String')) returns contents of MillerL as a double


% --- Executes during object creation, after setting all properties.
function MillerL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MillerL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in LStepUp.
function LStepUp_Callback(hObject, eventdata, handles)
% hObject    handle to LStepUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.MillerL,'String'));
temp=temp+1;
set(handles.MillerL,'String',num2str(temp));

% --- Executes on button press in LStepDown.
function LStepDown_Callback(hObject, eventdata, handles)
% hObject    handle to LStepDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.MillerL,'String'));
temp=temp-1;
set(handles.MillerL,'String',num2str(temp));

% --- Executes on button press in KStepUp.
function KStepUp_Callback(hObject, eventdata, handles)
% hObject    handle to KStepUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.MillerK,'String'));
temp=temp+1;
set(handles.MillerK,'String',num2str(temp));

% --- Executes on button press in KStepDown.
function KStepDown_Callback(hObject, eventdata, handles)
% hObject    handle to KStepDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.MillerK,'String'));
temp=temp-1;
set(handles.MillerK,'String',num2str(temp));

% --- Executes on button press in HStepUp.
function HStepUp_Callback(hObject, eventdata, handles)
% hObject    handle to HStepUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.MillerH,'String'));
temp=temp+1;
set(handles.MillerH,'String',num2str(temp));

% --- Executes on button press in HStepDown.
function HStepDown_Callback(hObject, eventdata, handles)
% hObject    handle to HStepDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.MillerH,'String'));
temp=temp-1;
set(handles.MillerH,'String',num2str(temp));

function PL_Callback(hObject, eventdata, handles)
% hObject    handle to PL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PL as text
%        str2double(get(hObject,'String')) returns contents of PL as a double
FigNum = str2num(get(handles.figureNum,'str'));
index = get(handles.Indexlist, 'String');
for i = 1:size(index,1)
    h = findobj(figure(FigNum),'Tag',index{i,:});
    if isempty(h)
        return;
    else
        delete(h);
        PlotBZPushButton_Callback(hObject, eventdata, handles);
    end
end

% --- Executes during object creation, after setting all properties.
function PL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rotation_Callback(hObject, eventdata, handles)
% hObject    handle to Rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FigNum = str2num(get(handles.figureNum,'str'));
index = get(handles.Indexlist, 'String');
for i =1:size(index,1)
    h = findobj('Tag',index{i,:});
    if isempty(h)
        return;
    else
        delete(h);
        PlotBZPushButton_Callback(hObject, eventdata, handles);
    end
end


% --- Executes during object creation, after setting all properties.
function Rotation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function figureNum_Callback(hObject, eventdata, handles)
% hObject    handle to figureNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of figureNum as text
%        str2double(get(hObject,'String')) returns contents of figureNum as a double


% --- Executes during object creation, after setting all properties.
function figureNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figureNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotBZPushButton.
function PlotBZPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlotBZPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = str2num(get(handles.MillerH,'String'));
k = str2num(get(handles.MillerK,'String'));
l = str2num(get(handles.MillerL,'String'));
if h==0 && k==0 && l==0
    errordlg('hkl at least one non-zero');
    return;
end
% index_i = str2num(get(handles.index_i,'String'));
% index_j = str2num(get(handles.index_j,'String'));
% index_k = str2num(get(handles.index_k,'String'));
FigNum = str2num(get(handles.figureNum,'str'));
PL = str2double(get(handles.PL,'str'));
azi = str2double(get(handles.Rotation,'str'))*pi/180;

% Construct unit vector G_hkl
Reciprocal_Lattice = LoadParameters(handles);
G_hkl = [h k l]*Reciprocal_Lattice;

% Construct rotation matrix R that makes R*G_hkl==z
if all(G_hkl/norm(G_hkl) == [0 0 1])
    R1 = eye(3);
else
    temp_1 = G_hkl/norm(G_hkl);
    temp_1 = temp_1';
    temp_2 = [0 0 1]';
    v = cross(temp_1,temp_2);
    s = norm(v);
    c = dot(temp_1,temp_2);
    vv = [0 -v(3) v(2);v(3) 0 -v(1);-v(2) v(1) 0];
    R1 = eye(3) + vv + (1-c)/s^2.*vv*vv;
end
Razi = [cos(azi) sin(azi) 0; -sin(azi) cos(azi) 0; 0 0 1];
R = Razi*R1;

% Rotate Reciprocal lattice base
Reciprocal_Lattice_Rotated = (R*(Reciprocal_Lattice'))';
% Create Plane and BZ@(0 0 PL) 
Plane = createPlane((1-1e-10)*0.5*PL*norm(G_hkl).*[0 0 1], [0 0 5]);
% Plat BZ_projection
index = get(handles.Indexlist,'str');
if isempty(index)
    return;
end
if isstr(index)
    index = cellstr(index);
end
for i =1:size(index,1)
    index_str = index{i,:};
    temp = strsplit(index_str,',');
    ii = str2num(temp{1});
    jj = str2num(temp{2});
    kk = str2num(temp{3});
    [Vertice,Faces] = generate_BZ(ii,jj,kk,Reciprocal_Lattice_Rotated);
    PlotBZ2D(ii,jj,kk,Vertice,Faces,Plane,Reciprocal_Lattice_Rotated,FigNum,handles);
end

% --- Executes on button press in iUp.
function iUp_Callback(hObject, eventdata, handles)
% hObject    handle to iUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.index_i,'String'));
temp=temp+1;
set(handles.index_i,'String',num2str(temp));

% --- Executes on button press in iDown.
function iDown_Callback(hObject, eventdata, handles)
% hObject    handle to iDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.index_i,'String'));
temp=temp-1;
set(handles.index_i,'String',num2str(temp));


% --- Executes on button press in jUp.
function jUp_Callback(hObject, eventdata, handles)
% hObject    handle to jUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.index_j,'String'));
temp=temp+1;
set(handles.index_j,'String',num2str(temp));


% --- Executes on button press in jDown.
function jDown_Callback(hObject, eventdata, handles)
% hObject    handle to jDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.index_j,'String'));
temp=temp-1;
set(handles.index_j,'String',num2str(temp));


% --- Executes on button press in kUp.
function kUp_Callback(hObject, eventdata, handles)
% hObject    handle to kUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.index_k,'String'));
temp=temp+1;
set(handles.index_k,'String',num2str(temp));


% --- Executes on button press in kDown.
function kDown_Callback(hObject, eventdata, handles)
% hObject    handle to kDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=str2num(get(handles.index_k,'String'));
temp=temp-1;
set(handles.index_k,'String',num2str(temp));



function index_i_Callback(hObject, eventdata, handles)
% hObject    handle to index_i (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of index_i as text
%        str2double(get(hObject,'String')) returns contents of index_i as a double


% --- Executes during object creation, after setting all properties.
function index_i_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index_i (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function index_j_Callback(hObject, eventdata, handles)
% hObject    handle to index_j (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of index_j as text
%        str2double(get(hObject,'String')) returns contents of index_j as a double


% --- Executes during object creation, after setting all properties.
function index_j_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index_j (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function index_k_Callback(hObject, eventdata, handles)
% hObject    handle to index_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of index_k as text
%        str2double(get(hObject,'String')) returns contents of index_k as a double


% --- Executes during object creation, after setting all properties.
function index_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on key press with focus on MillerH and none of its controls.
function MillerH_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to MillerH (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        HStepUp_Callback(hObject, eventdata, handles);
    case 'downarrow'
        HStepDown_Callback(hObject, eventdata, handles);
end


% --- Executes on key press with focus on MillerK and none of its controls.
function MillerK_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to MillerK (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        KStepUp_Callback(hObject, eventdata, handles);
    case 'downarrow'
        KStepDown_Callback(hObject, eventdata, handles);
end


% --- Executes on key press with focus on MillerL and none of its controls.
function MillerL_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to MillerL (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        LStepUp_Callback(hObject, eventdata, handles);
    case 'downarrow'
        LStepDown_Callback(hObject, eventdata, handles);
end


% --- Executes on key press with focus on index_i and none of its controls.
function index_i_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to index_i (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        iUp_Callback(hObject, eventdata, handles);
    case 'downarrow'
        iDown_Callback(hObject, eventdata, handles);
end


% --- Executes on key press with focus on index_j and none of its controls.
function index_j_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to index_j (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        jUp_Callback(hObject, eventdata, handles);
    case 'downarrow'
        jDown_Callback(hObject, eventdata, handles);
end


% --- Executes on key press with focus on index_k and none of its controls.
function index_k_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to index_k (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        kUp_Callback(hObject, eventdata, handles);
    case 'downarrow'
        kDown_Callback(hObject, eventdata, handles);
end


% --- Executes on selection change in Indexlist.
function Indexlist_Callback(hObject, eventdata, handles)
% hObject    handle to Indexlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Indexlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Indexlist


% --- Executes during object creation, after setting all properties.
function Indexlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Indexlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddLattice.
function AddLattice_Callback(hObject, eventdata, handles)
% hObject    handle to AddLattice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ii = get(handles.index_i,'String');
jj = get(handles.index_j,'String');
kk = get(handles.index_k,'String');
indexAdded = strcat(ii,',',jj,',',kk);
index = get(handles.Indexlist,'str');
if ~iscell(index)
    index = cellstr(index);
end
index = [indexAdded;index];
set(handles.Indexlist,'str',index);
PlotBZPushButton_Callback(hObject, eventdata, handles);

% --- Executes on button press in DeleteLattice.
function DeleteLattice_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteLattice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Select = get(handles.Indexlist,'Value');
index = get(handles.Indexlist, 'String');
if size(index,1) == length(Select)
    errordlg('leave one lattice please!');
    return;
end
index_del = index(find(ismember([1:size(index,1)],Select)),:);
if size(index_del,1) == 1
    h = findobj('Tag',index_del{1});
    if ~isempty(h)
        delete(h);
    end
else
    for i = size(index_del,1)
        h = findobj('Tag',index_del{i,:});
        if ~isempty(h)
            delete(h);
        end
    end
end
index = index(find(~ismember([1:size(index,1)],Select)),:);
set(handles.Indexlist,'String',index);


% --- Executes on button press in SurfaceBZpushbutton.
function SurfaceBZpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SurfaceBZpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = str2num(get(handles.MillerH,'String'));
k = str2num(get(handles.MillerK,'String'));
l = str2num(get(handles.MillerL,'String'));
if h==0 && k==0 && l==0
    errordlg('hkl at least one non-zero');
    return;
end
% index_i = str2num(get(handles.index_i,'String'));
% index_j = str2num(get(handles.index_j,'String'));
% index_k = str2num(get(handles.index_k,'String'));
FigNum = str2num(get(handles.figureNum,'str'));
PL = str2double(get(handles.PL,'str'));
azi = str2double(get(handles.Rotation,'str'))*pi/180;

% Construct unit vector G_hkl
Reciprocal_Lattice = LoadParameters(handles);
G_hkl = [h k l]*Reciprocal_Lattice;

% Construct rotation matrix R that R*G_hkl==z
if all(G_hkl/norm(G_hkl) == [0 0 1])
    R1 = eye(3);
else
    temp_1 = G_hkl/norm(G_hkl);
    temp_1 = temp_1';
    temp_2 = [0 0 1]';
    v = cross(temp_1,temp_2);
    s = norm(v);
    c = dot(temp_1,temp_2);
    vv = [0 -v(3) v(2);v(3) 0 -v(1);-v(2) v(1) 0];
    R1 = eye(3) + vv + (1-c)/s^2.*vv*vv;
end
Razi = [cos(azi) sin(azi) 0; -sin(azi) cos(azi) 0; 0 0 1];
R = Razi*R1;
% Rotate Reciprocal lattice base
Reciprocal_Lattice_Rotated = (R*(Reciprocal_Lattice'))';




% --- Executes on button press in Check_D1.
function Check_D1_Callback(hObject, eventdata, handles)
% hObject    handle to Check_D1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FigNum = str2num(get(handles.figureNum,'str'));
h = figure(FigNum);
delete(findobj(h,'Linestyle','-.'));
PlotBZPushButton_Callback(hObject, eventdata, handles);


% --- Executes on button press in Check_D2.
function Check_D2_Callback(hObject, eventdata, handles)
% hObject    handle to Check_D2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FigNum = str2num(get(handles.figureNum,'str'));
h = figure(FigNum);
delete(findobj(h,'Linestyle','-.'));
PlotBZPushButton_Callback(hObject, eventdata, handles);


% --- Executes on selection change in plotcolor.
function plotcolor_Callback(hObject, eventdata, handles)
% hObject    handle to plotcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotcolor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotcolor


% --- Executes during object creation, after setting all properties.
function plotcolor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckVectors.
function CheckVectors_Callback(hObject, eventdata, handles)
% hObject    handle to CheckVectors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckVectors


% --- Executes on button press in CheckLattice.
function CheckLattice_Callback(hObject, eventdata, handles)
% hObject    handle to CheckLattice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckLattice



% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index = get(handles.Indexlist, 'String');
for i =1:size(index,1)
    h = findobj('Tag',index{i,:});
    if ~isempty(h)
        delete(h);
    end
end


% --- Customized Functions.-------------------------------------
function Reciprocal_Lattice_Base = LoadParameters(handles)
% LoadParameters returns Reciprocal_Lattice_Base 3-3 matrix [b_1;b_2;b_3]
% based on parameters from guihandles

% Load Lattice Parameters
a = str2double(get(handles.a,'String'));
b = str2double(get(handles.b,'String'));
c = str2double(get(handles.c,'String'));
alpha = str2double(get(handles.alpha,'String'))*pi/180;
beta = str2double(get(handles.beta,'String'))*pi/180;
gamma = str2double(get(handles.gamma,'String'))*pi/180;
% check the validity of the parameters (to be updated)
if a == 0 || b == 0 || c == 0 || ~(0 < alpha < 2*pi) || ~(0 < beta < 2*pi) || ~(0 < gamma < 2*pi)|| sin(alpha).^2 - ((cos(beta)-cos(alpha).*cos(gamma))./sin(gamma)).^2 <=0
    errordlg('parameter error');
    return;
end 
% Construct Primitive Cell Vectors
LatticeSystem_index = get(handles.LatticeSystem,'value');
str = get(handles.LatticeSystem,'String');
LatticeSystem_type = str{LatticeSystem_index};
Real_base = eye(3);
switch LatticeSystem_type
    case 'Cubic'
        Real_base = a.*eye(3);
    case 'Orthorhombic'
        Real_base = [a 0 0;
                     0 b 0;
                     0 0 c];
    case 'Tetragonal'
        Real_base = [a 0 0;
                     0 a 0;
                     0 0 c];
    case 'Hexagonal'
        Real_base = [0.5*a -sqrt(3)*0.5*a 0; 
                     0.5*a sqrt(3)*0.5*a 0;
                     0 0 c];
    case 'Trigonal'
        a33 = sqrt(1-cos(alpha)^2/cos(0.5*alpha)^2);
        Real_base = a.*[cos(0.5*alpha) -sin(0.5*alpha) 0; 
                        cos(0.5*alpha) sin(0.5*alpha) 0; 
                        cos(alpha)/cos(0.5*alpha) 0 a33];
    case 'Triclinic'
        a32 = c*(cos(beta)-cos(alpha)*cos(gamma))/sin(gamma);
        a33 = c*sqrt(sin(gamma)^2-cos(alpha)^2-cos(beta)^2+2*cos(alpha)*cos(beta)*cos(gamma))/sin(gamma);
        Real_base = [a 0 0;
                     b*cos(gamma) b*sin(gamma) 0;
                     c*cos(alpha) a32 a33];
    case 'Monoclinic'
        Real_base = [a 0 0;
                     0 b 0;
                     c*cos(beta) 0 c*sin(beta)];
end
% Construct primitive cell vectors
Primitive_Lattice = eye(3);
A = eye(3);
if get(handles.radio_primitive,'Value') == 1
    A = A;
elseif get(handles.radio_bodycentered,'Value') == 1
    A = [-0.5 0.5 0.5;0.5 -0.5 0.5;0.5 0.5 -0.5];
elseif get(handles.radio_facecentered,'Value') == 1
    A = [0 0.5 0.5; 0.5 0 0.5;0.5 0.5 0];
elseif get(handles.radio_basecentered,'Value') == 1
    A = [0.5 -0.5 0;0.5 0.5 0;0 0 1];
end
Primitive_Lattice = A*Real_base;
% Construct Reciprocal Lattice Base
Volumn = abs(det(Primitive_Lattice));
Reciprocal_Lattice_Base = 2*pi/Volumn.*cross(Primitive_Lattice([2,3,1],:)',Primitive_Lattice([3,1,2],:)')';


function [Vertices,Faces] = generate_BZ(i,j,k,Reciprocal_Lattice_Base)
% generate_BZ returns BZ patch object with Vertices and Faces. i j k
% represents the index of the Gamma i*b_1 + j*b_2 + k*b_3
% This function uses voronoi graph base on Qhull, see Qhull

AA = ones(9,1); BB = [j j j j-1 j-1 j-1 j+1 j+1 j+1]'; CC = [k k-1 k+1 k k-1 k+1 k k-1 k+1]';
X = [i.*AA,BB,CC;(i-1).*AA,BB,CC;(i+1).*AA,BB,CC]*Reciprocal_Lattice_Base;
[V,C] = voronoin(X);
Vertices = V(C{1},:);
KK = convhull(Vertices,'simplify',true);
Faces = mergeCoplanarFaces(Vertices, KK);

function PlotBZ2D(ii,jj,kk,Vertice,Faces,Plane,Reciprocal_Lattice_Base,FigNum,handles)
BZ_center = [ii jj kk]*Reciprocal_Lattice_Base;
    % Construct the intersection
    polygon3D = intersect_BZ(Vertice,Faces,Plane);
    if isempty(polygon3D) || size(polygon3D,1) <= 2
        return;
    end
    % Plane has been aligned to z-axis. Projection
    BZ_proj = polygon3D(:,[1,2]);
    % construct convhull graph
    K = convhull(BZ_proj);
    BZ_proj = BZ_proj(K,:);
    % plot settings
    hhh = figure(FigNum);
    hold on;
    lcc = ChooseColor(handles);
    Tag = strcat(num2str(ii),',',num2str(jj),',',num2str(kk));
    drawPolygon(BZ_proj,...
                'Linewidth',1.5,...
                'Color',lcc,...
                'Tag',Tag);
    if get(handles.Check_D1,'Value') == 1
        comb = nchoosek([1:size(BZ_proj,1)],2);
        Edges = createEdge(BZ_proj(comb(:,1),:),BZ_proj(comb(:,2),:));
        Edges = Edges(find(isPointOnEdge(BZ_center(:,[1,2]),Edges)),:);
        drawEdge(Edges,...
                 'Linewidth',1,...
                 'Color',lcc,...
                 'Linestyle','-.',...
                 'Tag',Tag);
    end
    if get(handles.Check_D2,'Value') == 1
        midpoints = midPoint(BZ_proj(1:size(BZ_proj)-1,:),BZ_proj(2:size(BZ_proj),:));
        comb = nchoosek([1:size(midpoints,1)],2);
        Edges = createEdge(midpoints(comb(:,1),:),midpoints(comb(:,2),:));
        Edges = Edges(find(isPointOnEdge(BZ_center(:,[1,2]),Edges)),:);
        drawEdge(Edges,...
                 'Linewidth',1,...
                 'Color',lcc,...
                 'Linestyle','-.',...
                 'Tag',Tag);
    end
    drawPoint(BZ_center(:,[1,2]),...
              'Marker','o',...
              'MarkerFaceColor','red',...
              'MarkerEdgeColor','none',...
              'Tag',Tag); 
    hold off;
    axis equal;

function Polygon = intersect_BZ(v,f,plane)
Polygon = [];
e = meshEdges(f);
% whether v is on the plane, if true append v(i) to polygon delete related
% v 
% inPlaneInds = find(distancePointPlane(v,plane) < eps);
% if ~any(inPlaneInds)
%     EffectiveEdgeInds = intersect(find(~ismember(e(:,1),inPlaneInds)),find(~ismember(e(:,2),inPlaneInds)));
%     Polygon = [Polygon;v(inPlaneInds,:)];
%     eEffective = e(EffectiveEdgeInds,:);
%     EffectiveEdge = [v(e(EffectiveEdgeInds,1),:) v(e(EffectiveEdgeInds,2),:)];
%     inds = isBelowPlane(v, plane);
%     edgeCrossInds = find(sum(inds(eEffective), 2) == 1);
%     intersectionPoints = intersectEdgePlane(EffectiveEdge(edgeCrossInds,:), plane);
%     if ~isempty(intersectionPoints)
%         Polygon = [Polygon;intersectionPoints];
%     end
% else
    edges = [v(e(:,1),:) v(e(:,2),:)];
    inds = isBelowPlane(v, plane);
    edgeCrossInds = find(sum(inds(e), 2) == 1);
    if ~isempty(edgeCrossInds)
        intersectionPoints = intersectEdgePlane(edges(edgeCrossInds, :), plane);
        Polygon = [Polygon;intersectionPoints];
    end
    Polygon=Polygon(~any(isnan(Polygon),2),:);% Make sure no NAN
% end

function lcc = ChooseColor(handles)
lc= get(handles.plotcolor,'Value');
switch lc
    case 1
        lcc = 'b';
    case 2
        lcc = 'y';
    case 3
        lcc = 'r';
    case 4
        lcc = 'k';
    case 5
        lcc = 'w';
end
