function [tilt_vector] = GetAbsoluteIMU_Tilt(port, varargin)
% Reads the current tilt value from AbsoluteIMU sensor.
%
% Syntax
%
% tilt_vector = GetAbsoluteIMU_Tilt(port)
%
% tilt_vector = GetAbsoluteIMU_Tilt(port, varargin)
%
%Description
% tilt_vector = GetAbsoluteIMU_Tilt(port) returns the current 3x1 tilt vector of the three axes from
% the AbsoluteIMU sensor. The row vector contains the tilt for X, Y and Z-axis, respectively.
% The values returned is between 0 (-90 degrees) and 255 (+90 degrees), with 128 as 0 around that axis.
% Note that tilt for X-axis is measured around Y-axis.
% rad: f(x)=x/255/2*pi  deg: f(x)=x/255*90
%The last optional argument can be a valid NXT handle. If none is
%specified, the default handle will be used (call COM_SetDefaultNXT to
%set one).
%
%Examples
% OpenAccelerator(SENSOR_1);
% tilt_vector = GetAbsoluteIMU_Tilt(SENSOR_1);
% CloseSensor(SENSOR_1);
%
% See also: GetAbsoluteIMU_Acc , OpenAccelerator
%
% Sondre Norheim, 15.10.2012
% Knut Ørland, 19.10.2012

tilt_vector = [NaN; NaN; NaN];
%see if varargin is set, else send standard handle
if nargin > 1
    handle = varargin{1};
else
    handle = COM_GetDefaultNXT;
end

% Read 3 byte from I2C, sensorport "port", device 0x22, adress 0x42
noofbytes =uint8(3);
device = uint8(hex2dec('22'));
address = uint8(hex2dec('42'));

data = COM_ReadI2C(port, noofbytes, device, address, handle);

% Put data in vector
if ~isempty(data)
    tilt_vector = data;       
end

end