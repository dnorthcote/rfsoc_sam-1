%% Setup environment
% idcs = strfind(pwd,filesep);
% mydir = pwd;
% newdir = [mydir(1:idcs(2)-1) '\hdlspeclib'];
% addpath(newdir);

%% Spectrum Analyzer Parameters
% Set the FPGA System Frequency
f = 256e6;

% Set the Sampling Frequency
fs = 1.024e9;

%% Transmit System Design Parameters
% Set the symbol rate
SymbolRate = 1e6;
% Set the carrier frequency
fc_tx = 64e6;

% Design RRC
F_RRC.Rate = 4;
F_RRC.RollOff = 0.2;
F_RRC.FilterSpan = 10;
F_RRC.LinearGain = 1;

% Design Halfband Filter
F_HB.Rate = 2;
F_HB.TransitionWidth = SymbolRate/2;
F_HB.StopbandAttenuation = 80;
F_HB.SampleRate = SymbolRate*F_RRC.Rate;

% Design CIC Interpolator
F_CICI.Rate = 400;
F_CICI.DifferentialDelay = 1;
F_CICI.Sections = 3;

% Design CIC Compensator
F_CICC.Rate = 2;
F_CICC.Passband = 0.3*SymbolRate*F_RRC.Rate*F_HB.Rate;
F_CICC.Stopband = 0.4*SymbolRate*F_RRC.Rate*F_HB.Rate;
F_CICC.Ripple = 0.1;
F_CICC.StopbandAttenuation = 80;
F_CICC.SampleRate = SymbolRate*F_RRC.Rate*F_HB.Rate;


%% Receive Design Parameters
fc_rx = 56e6;