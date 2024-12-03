function varargout = powershark_gui(varargin)
% POWERSHARK_GUI MATLAB code for powershark_gui.fig
%      POWERSHARK_GUI, by itself, creates a new POWERSHARK_GUI or raises the existing
%      singleton*.
%
%      H = POWERSHARK_GUI returns the handle to a new POWERSHARK_GUI or the handle to
%      the existing singleton*.
%
%      POWERSHARK_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POWERSHARK_GUI.M with the given input arguments.
%
%      POWERSHARK_GUI('Property','Value',...) creates a new POWERSHARK_GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before powershark_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to powershark_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help powershark_gui

% Last Modified by GUIDE v2.5 05-Apr-2023 19:17:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @powershark_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @powershark_gui_OutputFcn, ...
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

% --- Executes just before powershark_gui is made visible.
function powershark_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to powershark_gui (see VARARGIN)

% Choose default command line output for powershark_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

ha = axes('units','normalized', ...
            'position',[0 0 1 1]);
        
uistack(ha,'bottom');
%I=imread('auxiliary\background.tif');
%hi = imagesc(I);
colormap gray
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
            'visible','off')
%set(handles.tblInputs,'Data',[]);
%set(handles.tblInitCond,'Data',[]);
% UIWAIT makes powershark_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = powershark_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function density_Callback(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density as text
%        str2double(get(hObject,'String')) returns contents of density as a double
density = str2double(get(hObject, 'String'));
if isnan(density)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new density value
handles.metricdata.density = density;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volume as text
%        str2double(get(hObject,'String')) returns contents of volume as a double
volume = str2double(get(hObject, 'String'));
if isnan(volume)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.metricdata.volume = volume;
guidata(hObject,handles)


% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mass = handles.metricdata.density * handles.metricdata.volume;
set(handles.mass, 'String', mass);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialize_gui(gcbf, handles, true);

% --- Executes when selected object changed in unitgroup.
function unitgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in unitgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (hObject == handles.english)
    set(handles.text4, 'String', 'lb/cu.in');
    set(handles.text5, 'String', 'cu.in');
    set(handles.text6, 'String', 'lb');
else
    set(handles.text4, 'String', 'kg/cu.m');
    set(handles.text5, 'String', 'cu.m');
    set(handles.text6, 'String', 'kg');
end

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.


% Update handles structure
guidata(handles.figure1, handles);


function btnSelModelOne_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile;
addpath(pathname);
open_system(filename)  
id = strfind(filename,'.mdl');
fname = filename(1:id-1);
fname = strcat(fname,'/output_mux');
output_struct = get_param(fname,'PortHandles');
outputs_no = length(get_param(output_struct.Inport,'Line'))
output_names = {}
pred_string = {}
a ={}
b = {}
for i = 1:outputs_no
    output_names = [output_names,get_param(output_struct.Inport(i),'Name')];
    i1 = num2str(i);
    r = strcat('r',i1);
    pred_string = [pred_string,r]
    a = [a,'<']
    b = [b, '0']
end
o = {};
pred_string_fill = {};
pred_string_fill = [pred_string(1),a(1),b(1),output_names(1)]
for i = 2:outputs_no
   o = [pred_string(i),a(i),b(i),output_names(i)]
   pred_string_fill = [pred_string_fill;o]
end
%assignin('base','output_names',output_names);
assignin('base','output_names', output_names);
set(handles.txtModelOne, 'String', [filename]);
handles.data = output_names;
set(handles.tblPredSettings,'Data', pred_string_fill)

function txtModelOne_Callback(hObject, eventdata, handles)
% hObject    handle to txtModelOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtModelOne as text
%        str2double(get(hObject,'String')) returns contents of txtModelOne as a double


% --- Executes during object creation, after setting all properties.
function txtModelOne_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtModelOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%set(handles.tblPredSettings, 'String', output_names);


% --- Executes on button press in btnSelModelTwo.
function btnSelModelTwo_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelModelTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile;
set(handles.txtModelTwo, 'String', [filename]);

function txtModelTwo_Callback(hObject, eventdata, handles)
% hObject    handle to txtModelTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtModelTwo as text
%        str2double(get(hObject,'String')) returns contents of txtModelTwo as a double


% --- Executes during object creation, after setting all properties.
function txtModelTwo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtModelTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnIncInputs.
function btnIncInputs_Callback(hObject, eventdata, handles)
% hObject    handle to btnIncInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.tblInputs,'Data');
sz = size(tableData,1);
tableData{sz+1,1} = '';
tableData{sz+1,2} = '';
tableData{sz+1,3} = '';
tableData{sz+1,4} = '';
set(handles.tblInputs,'Data',tableData)

% --- Executes on button press in btnDecInputs.
function btnDecInputs_Callback(hObject, eventdata, handles)
% hObject    handle to btnDecInputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user dtableData = get(handles.tblInputs,'Data');
tableData = get(handles.tblInputs,'Data');
sz = size(tableData,1);
tableData(sz,:) = [];
set(handles.tblInputs,'Data',tableData)


% --- Executes on button press in btnIncInitCond.
%function btnIncInitCond_Callback(hObject, eventdata, handles)
% hObject    handle to btnIncInitCond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%tableData = get(handles.tblInitCond,'Data');
%sz = size(tableData,1);
%tableData{sz+1,1} = [];
%tableData{sz+1,2} = [];
%set(handles.tblInitCond,'Data',tableData)

% --- Executes on button press in btnDecInitCond.
%function btnDecInitCond_Callback(hObject, eventdata, handles)
% hObject    handle to btnDecInitCond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%tableData = get(handles.tblInitCond,'Data');
%sz = size(tableData,1);
%tableData(sz,:) = [];
%set(handles.tblInitCond,'Data',tableData)



function txtSpec_Callback(hObject, eventdata, handles)
% hObject    handle to txtSpec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSpec as text
%        str2double(get(hObject,'String')) returns contents of txtSpec as a double


% --- Executes during object creation, after setting all properties.
function txtSpec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSpec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSimTime_Callback(hObject, eventdata, handles)
% hObject    handle to txtSimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSimTime as text
%        str2double(get(hObject,'String')) returns contents of txtSimTime as a double
    set(hObject,'BackgroundColor','white');
    


% --- Executes during object creation, after setting all properties.
function txtSimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmbStochOptimizer.
%function cmbStochOptimizer_Callback(hObject, eventdata, handles)
% hObject    handle to cmbStochOptimizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmbStochOptimizer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmbStochOptimizer

%cmbStochOptimizerIdx = get(handles.cmbStochOptimizer, 'value');
%tempCmbStochOptimizerData = get(handles.cmbStochOptimizer, 'String');
%val = strtrim(tempCmbStochOptimizerData{cmbStochOptimizerIdx});

%switch val
    %case 'SA_Taliro'
        %set(handles.uip_CE,'Visible','off');
        %set(handles.uip_SA,'Visible','on');
%     case 'CE_Taliro'
%         set(handles.uip_SA,'Visible','off');
%         
%         figposSA = get(handles.uip_SA,'Position');
%         figposCE = get(handles.uip_CE,'Position');
%         upos = [figposSA(1), 0.1, figposCE(3), figposCE(4)];
%         set(handles.uip_CE,'Position',upos);
%         
%         set(handles.uip_CE,'Visible','on'); 
        
%end


% --- Executes during object creation, after setting all properties.
%function cmbStochOptimizer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmbStochOptimizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    %set(hObject,'BackgroundColor','white');
%end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmbOdeSolver.
function cmbOdeSolver_Callback(hObject, eventdata, handles)
% hObject    handle to cmbOdeSolver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmbOdeSolver contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmbOdeSolver


% --- Executes during object creation, after setting all properties.
function cmbOdeSolver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmbOdeSolver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function txtRobScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRobScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function txtSeed_Callback(hObject, eventdata, handles)
% hObject    handle to txtSeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSeed as text
%        str2double(get(hObject,'String')) returns contents of txtSeed as a double


% --- Executes during object creation, after setting all properties.
function txtSeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function savevarname_Callback(hObject, eventdata, handles)
% hObject    handle to savevarname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savevarname as text
%        str2double(get(hObject,'String')) returns contents of savevarname as a double


% --- Executes during object creation, after setting all properties.
function savevarname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savevarname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRuns_Callback(hObject, eventdata, handles)
% hObject    handle to txtRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRuns as text
%        str2double(get(hObject,'String')) returns contents of txtRuns as a double


% --- Executes during object creation, after setting all properties.
function txtRuns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRuns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSampTime_Callback(hObject, eventdata, handles)
% hObject    handle to txtSampTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSampTime as text
%        str2double(get(hObject,'String')) returns contents of txtSampTime as a double


% --- Executes during object creation, after setting all properties.
function txtSampTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSampTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmbTaliroMetric.
function cmbTaliroMetric_Callback(hObject, eventdata, handles)
% hObject    handle to cmbTaliroMetric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmbTaliroMetric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmbTaliroMetric


% --- Executes during object creation, after setting all properties.
%function cmbTaliroMetric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmbTaliroMetric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    %set(hObject,'BackgroundColor','white');
%end



% --- Executes during object creation, after setting all properties.
function txtRobOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRobOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end








function txtCEnTests_Callback(hObject, eventdata, handles)
% hObject    handle to txtCEnTests (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCEnTests as text
%        str2double(get(hObject,'String')) returns contents of txtCEnTests as a double


% --- Executes during object creation, after setting all properties.
function txtCEnTests_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCEnTests (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtCENumSubdivs_Callback(hObject, eventdata, handles)
% hObject    handle to txtCENumSubdivs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCENumSubdivs as text
%        str2double(get(hObject,'String')) returns contents of txtCENumSubdivs as a double


% --- Executes during object creation, after setting all properties.
function txtCENumSubdivs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCENumSubdivs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtCENumIter_Callback(hObject, eventdata, handles)
% hObject    handle to txtCENumIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCENumIter as text
%        str2double(get(hObject,'String')) returns contents of txtCENumIter as a double


% --- Executes during object creation, after setting all properties.
function txtCENumIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCENumIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtCETilt_Callback(hObject, eventdata, handles)
% hObject    handle to txtCETilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCETilt as text
%        str2double(get(hObject,'String')) returns contents of txtCETilt as a double


% --- Executes during object creation, after setting all properties.
function txtCETilt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCETilt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opt = staliro_options();
opt.optimization_solver = 'SA_Taliro';
opt.runs = str2double(get(handles.txtRuns, 'string'));

%cmbStochOptimizerIdx = get(handles.cmbStochOptimizer, 'value')
%tempCmbStochOptimizerData = get(handles.cmbStochOptimizer, 'String')
%if(cmbStochOptimizerIdx == 1)
    %tempVar= tempCmbStochOptimizerData{cmbStochOptimizerIdx};
    %opt.optimization_solver = tempVar(2:end);
%else
    %opt.optimization_solver = tempCmbStochOptimizerData{cmbStochOptimizerIdx};
%end

switch get(get(handles.uiMainOption,'SelectedObject'),'Tag')
    case 'rdbFals', 
        %load_mat ('agent_trained_not_22.mat');
        %load_mat ('states_cp_1.mat');
        load_mat ('rlagent_14bus');
        load_mat ('states_14bus.mat');
        open_system('rl_top.mdl') 
        file_name = get(handles.txtModelOne, 'string')
        set_param('rl_top/Model','ModelName',file_name)
        id = strfind(file_name,'.mdl');
        fname = file_name(1:id-1);
        fname = strcat(fname,'/output_mux');
        output_struct = get_param(fname,'PortHandles');
        file_name = get(handles.txtModelOne, 'string')
        set_param('rl_top/Model','ModelName',file_name)
        outputs_no = length(get_param(output_struct.Inport,'Line'))
        output_names = {}
        for i = 1:outputs_no
            output_names = [output_names,get_param(output_struct.Inport(i),'Name')];
        end
        assignin('base','output_names',output_names);
        %model_data = get(handles.txtModelOne, 'string')
        model_data = 'rl_top.mdl'
   case 'rdbConfTest',
        %load_mat ('agent9busnew2.mat');
        %load_mat ('states_cp_9bus.mat');
        load_mat ('rlagent_9bus.mat');
        load_mat ('states_9bus.mat');
        file_name = get(handles.txtModelOne, 'string')
        open_system(file_name)
        open_system('rl_top_9bus.mdl')      
        set_param('rl_top_9bus/Model','ModelName',file_name)
        id = strfind(file_name,'.mdl');
        fname = file_name(1:id-1);
        fname = strcat(fname,'/output_mux');
        output_struct = get_param(fname,'PortHandles');
        file_name = get(handles.txtModelOne, 'string')
        set_param('rl_top_9bus/Model','ModelName',file_name)
        outputs_no = length(get_param(output_struct.Inport,'Line'))
        output_names = {}
        for i = 1:outputs_no
            output_names = [output_names,get_param(output_struct.Inport(i),'Name')];
        end
        assignin('base','output_names',output_names);
        model_data = 'rl_top_9bus.mdl'
      
    case 'rdbParamEst', 
        
        %load_mat ('agent5bus.mat');
        %load_mat ('states_cp_5bus.mat');
        load_mat ('rlagent_5bus.mat');
        load_mat ('states_5bus.mat');
        file_name = get(handles.txtModelOne, 'string')
        open_system(file_name)
        open_system('rl_top_5bus.mdl')      
        set_param('rl_top_5bus/Model','ModelName',file_name)
        id = strfind(file_name,'.mdl');
        fname = file_name(1:id-1);
        fname = strcat(fname,'/output_mux');
        output_struct = get_param(fname,'PortHandles');
        file_name = get(handles.txtModelOne, 'string')
        set_param('rl_top_5bus/Model','ModelName',file_name)
        outputs_no = length(get_param(output_struct.Inport,'Line'))
        output_names = {}
        for i = 1:outputs_no
            output_names = [output_names,get_param(output_struct.Inport(i),'Name')];
        end
        assignin('base','output_names',output_names);
        model_data = 'rl_top_5bus.mdl'
end


%switch get(get(handles.panSpecSpace,'SelectedObject'),'Tag')
   % case 'specspaceY',  opt.spec_space = 'Y';
   % case 'rdbConfTest',  
   % case 'specspaceX',  opt.spec_space = 'X';
%end


%opt.taliro_metric = get(handles.cmbTaliroMetric, 'string');
%cmbTaliroMetricIdx = get(handles.cmbTaliroMetric, 'value');
%cmbTaliroMetricData = get(handles.cmbTaliroMetric, 'String');
%opt.taliro_metric = cmbTaliroMetricData{cmbTaliroMetricIdx};

opt.SampTime = str2double(get(handles.txtSampTime, 'string'));
opt.RobustnessOffset = 0;
opt.rob_scale = 100;
opt.loc_traj = 'none';
opt.seed = str2double(get(handles.txtSeed, 'string'));
opt.taliro_undersampling_factor = 1;
opt.optim_params.n_tests = 1;
% opt.optim_params.n_tests = str2double(get(handles.txtCEnTests, 'string'));
% opt.optim_params.num_subdivs = str2double(get(handles.txtCENumSubdivs, 'string'));
% opt.optim_params.num_iteration = str2double(get(handles.txtCENumIter, 'string'));
% opt.optim_params.tilt_divisor = str2double(get(handles.txtCETilt, 'string'));


%init_cond_data = get(handles.tblInitCond,'Data');
%if ~isempty(cell2mat(init_cond_data));
    %init_cond = cellfun(@str2num,init_cond_data);
%else
    %init_cond = [];
%end

input_range_data = get(handles.tblInputs,'Data');
tempInpRange = zeros(size(input_range_data,1),1);
for ii = 1:size(input_range_data,1)
    if isempty(cell2mat(input_range_data(ii,:)));
        tempInpRange(ii) = 0;
    else
        tempInpRange(ii) = 1;
    end
end

if any(tempInpRange)
    input_range = cellfun(@str2num,input_range_data(find(tempInpRange==1),1:2));
    opt.interpolationtype = transpose(input_range_data(find(tempInpRange==1),4));
    cp_array = cellfun(@str2num,input_range_data(find(tempInpRange==1),3));
else
    input_range = [];
end

preds_data = get(handles.tblPredSettings,'Data')
tempPredsData = zeros(size(preds_data,1),1);
for ii = 1:size(tempPredsData,1)
    if isempty(preds_data{ii});
        tempPredsData(ii) = 0;
    else
        tempPredsData(ii) = 1;
    end
end

if any(tempPredsData) 
    idx = find(tempPredsData==1);
    for ii = 1:size(idx,1)
        preds(idx(ii)).str = preds_data{idx(ii),1};
        preds(idx(ii)).Outputs = preds_data{idx(ii),4};
        index = find(strcmp(output_names,preds(idx(ii)).Outputs))
        if isstring(preds_data{idx(ii),4})
            preds(idx(ii)).Outputs = preds_data{idx(ii),4};
            index = find(strcmp(output_names,preds(idx(ii)).Outputs))
        else
            preds(idx(ii)).Outputs = num2str(preds_data{idx(ii),4});
        end
        
        if isa(preds_data{idx(ii),2},'char')
            A1 = zeros(1,outputs_no)
            if (preds_data{idx(ii),2} == '<')
                A1(index) = 1
                %preds(idx(ii)).A = preds_data{idx(ii),2};
                preds(idx(ii)).A = A1;
            end
            if (preds_data{idx(ii),2} == '>')
                A1(index) = -1
                %preds(idx(ii)).A = preds_data{idx(ii),2};
                preds(idx(ii)).A = A1;
            end
        else
            preds(idx(ii)).A = str2num(preds_data{idx(ii),2});
        end
                
        if isa(preds_data{idx(ii),3},'numeric')
            
            if (preds_data{idx(ii),2} == '<')
                preds(idx(ii)).b = preds_data{idx(ii),3};
            end
            if (preds_data{idx(ii),2} == '>')
               preds(idx(ii)).b = -1* preds_data{idx(ii),3};
            end
        else
            preds(idx(ii)).b = str2num(preds_data{idx(ii),3});
        end
        
        
    end
else

end
%load_mat ('agent5bus.mat');
%load_mat ('states_cp_5bus.mat');
%file_name = get(handles.txtModelOne, 'string')
%set_param('rl_top_5bus/Model','ModelName',file_name)
%model_data = get(handles.txtModelOne, 'string')
%model_data = 'rl_top_5bus.mdl'
idx = strfind(model_data,'.mdl');
model = model_data(1:idx-1)
opt.falsification = 1;
opt.parameterEstimation = 0;
time = str2double(get(handles.txtSimTime, 'string'));
if isnan(time)
    set(handles.txtSimTime, 'BackgroundColor','Red');
    error('S-TaLiRo: Simulation time cannot be NaN');
end
init_cond = [];
phi = get(handles.txtSpec, 'string');

set(handles.txtResults,'String',' ');
set(handles.txtResults,'String','Simulations Running...'); 
set(handles.txtResults,'Visible','on'); 

%[results history] = staliro(model,init_cond,input_range,cp_array,phi,preds,time,opt);
results = staliro(model,init_cond,input_range,cp_array,phi,preds,time,opt);
set(handles.txtResults,'String','Simulations Complete. See the results and history structures.'); 
%runtime=toc;

%runtime

disp('Displaying the results of the falsification process ...')
results.run(results.optRobIndex).bestRob

disp('Plotting the falsifying behavior ...')
figure
[T1,XT1,YT1,IT1] = SimSimulinkMdl(model,init_cond,input_range,cp_array,results.run(1).bestSample,time,opt)
assignin('base','FDIA', IT1);
%subplot(2,1,1);
%plot([0 20],[60.5 60.5],'r')
%hold on
%plot([0 20],[59.5 59.5],'r')
%plot(T1,YT1(:,1))
%legend('upper-limit','lower-limit','frequency');
%title('Frequency');
%subplot(2,1,2);
%plot([0 10],[40 40],'r')
%hold on
%plot(T1,YT1(:,2),'g')
%title('Residue')
for i = 1:outputs_no
    subplot(outputs_no,1,i)
    plot(T1,YT1(:,i))
    title(output_names(i));
end

% --- Executes on button press in btnIncPreds.
function btnIncPreds_Callback(hObject, eventdata, handles)
% hObject    handle to btnIncPreds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.tblPredSettings,'Data');
sz = size(tableData,1);
tableData{sz+1,1} = [];
tableData{sz+1,2} = [];
set(handles.tblPredSettings,'Data',tableData)



% --- Executes on button press in btnDecPreds.
function btnDecPreds_Callback(hObject, eventdata, handles)
% hObject    handle to btnDecPreds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.tblPredSettings,'Data');
sz = size(tableData,1);
tableData(sz,:) = [];
set(handles.tblPredSettings,'Data',tableData)
