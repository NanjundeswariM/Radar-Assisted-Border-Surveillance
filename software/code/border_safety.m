function varargout = border_safety(varargin)
% border_safety MATLAB GUIDE – FULL WORKING CODE

% ---------------- GUIDE INITIALIZATION ----------------
gui_Singleton = 1;
gui_State = struct( ...
    'gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @border_safety_OpeningFcn, ...
    'gui_OutputFcn',  @border_safety_OutputFcn, ...
    'gui_LayoutFcn',  [], ...
    'gui_Callback',   []);

if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% -----------------------------------------------------


% ---------------- OPENING FUNCTION -------------------
function border_safety_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% ===== SERIAL CONFIG =====
handles.port = 'COM7';        % CHANGE IF REQUIRED
handles.baud = 115200;
handles.s = serial(handles.port,'BaudRate',handles.baud);
fopen(handles.s);

% ===== RADAR AXES =====
axes(handles.axesRadar);
cla;
handles.maxRange = 400;
axis([-400 400 -400 400]);
axis equal;
grid on;
set(gca,'Color','k','XColor','b','YColor','b');
title('360° Radar Display');
xlabel('X (cm)');
ylabel('Y (cm)');
hold on;

% ===== RADAR OBJECTS =====
handles.hDot  = plot(0,0,'ro','MarkerFaceColor','r','MarkerSize',6);
handles.hLine = plot([0 0],[0 handles.maxRange],'g','LineWidth',2);

% ===== TIMER =====
handles.t = timer( ...
    'ExecutionMode','fixedRate', ...
    'Period',0.05, ...
    'TimerFcn',{@updateRadar,hObject});

% ===== INITIAL STATUS =====
set(handles.txtDirection,'String','Direction : --');
set(handles.txtWarning,'String','Status : STOPPED', ...
    'BackgroundColor',[0.9 0.9 0.9]);

guidata(hObject,handles);
% -----------------------------------------------------


% ---------------- START BUTTON -----------------------
function btnStart_Callback(hObject, eventdata, handles)

if strcmp(handles.t.Running,'off')
    start(handles.t);
    set(handles.txtWarning,'String','Status : RUNNING', ...
        'BackgroundColor',[0.8 1 0.8]);
end
% -----------------------------------------------------


% ---------------- STOP BUTTON ------------------------
function btnStop_Callback(hObject, eventdata, handles)

if strcmp(handles.t.Running,'on')
    stop(handles.t);
    set(handles.txtWarning,'String','Status : STOPPED', ...
        'BackgroundColor',[0.9 0.9 0.9]);
end
% -----------------------------------------------------


% ---------------- RADAR UPDATE FUNCTION --------------
function updateRadar(~,~,hObject)

handles = guidata(hObject);

if handles.s.BytesAvailable == 0
    return;
end

data = fgetl(handles.s);
vals = str2num(data); %#ok<ST2NM>
if numel(vals) ~= 2
    return;
end

angle = vals(1);
distance = vals(2);

% ===== POSITION =====
x = distance*cosd(angle);
y = distance*sind(angle);

% ===== UPDATE RADAR =====
set(handles.hDot,'XData',x,'YData',y);
set(handles.hLine,'XData',[0 handles.maxRange*cosd(angle)], ...
                  'YData',[0 handles.maxRange*sind(angle)]);

% ===== DIRECTION LOGIC =====
if angle >= 345 || angle < 15
    dir = 'EAST';
elseif angle < 75
    dir = 'NORTH-EAST';
elseif angle < 105
    dir = 'NORTH';
elseif angle < 165
    dir = 'NORTH-WEST';
elseif angle < 195
    dir = 'WEST';
elseif angle < 255
    dir = 'SOUTH-WEST';
elseif angle < 285
    dir = 'SOUTH';
else
    dir = 'SOUTH-EAST';
end

set(handles.txtDirection,'String',['Direction : ' dir]);
set(handles.txtAngle,'String',['Angle : ' num2str(angle) '°']);
set(handles.txtDistance,'String',['Distance : ' num2str(distance) ' cm']);

% ===== WARNING STATUS =====
if distance > 0 && distance < 15
    set(handles.txtWarning,'String', ...
    ['? INTRUDER ALERT | Direction : ' dir], ...
    'BackgroundColor',[1 0.6 0.6]);
    sound(sin(1:2000));
end
% -----------------------------------------------------


% ---------------- FIGURE CLOSE -----------------------
function figure1_CloseRequestFcn(hObject, eventdata, handles)

try
    stop(handles.t);
    delete(handles.t);
    fclose(handles.s);
    delete(handles.s);
catch
end
delete(hObject);
% -----------------------------------------------------


% ---------------- OUTPUT FUNCTION --------------------
function varargout = border_safety_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
% ----------------------------------------------------


% --- Executes on button press in btnStart.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to btnStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
