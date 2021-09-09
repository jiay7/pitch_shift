clear all;
%生成ratio，ratio>1表示降低频率，ratio<1表示升高频率，可自行更改
ratio = [1:0.01:1.3,1.3:-0.01:1,ones(1,50),1:-0.01:0.5,0.51:0.01:1];
ratio = [ratio,ratio];

[data,sr] = audioread( 'Track5_800Hz_Pl1.wav');
tic;
new_data = pitch_shifter( data,sr, ratio );
fprintf('Data processing time is: %fs\n ',toc);
%降采样输出音频，采样率变为8000Hz
new_data = resample(new_data,8000,sr);

total_time = length(new_data)/8000;
fprintf('Output audio time is: %fs\n ',total_time);

audiowrite('output.wav',new_data,8000);

%变换前后分析
soundsc(new_data,8000);
subplot(3,1,1)
specgram(data,1024,8000,1024,512);
title('原始音频频谱')
subplot(3,1,2)
plot(2 - ratio)
title('频率变换比例')
axis([0 length(2 - ratio) min(2 - ratio) max(2 - ratio)])
subplot(3,1,3)
specgram(new_data,1024,8000,1024,512);
title('变换后的频谱')
saveas(gcf,'结果对比.png')
