clear all;
%����ratio��ratio>1��ʾ����Ƶ�ʣ�ratio<1��ʾ����Ƶ�ʣ������и���
ratio = [1:0.01:1.3,1.3:-0.01:1,ones(1,50),1:-0.01:0.5,0.51:0.01:1];
ratio = [ratio,ratio];

[data,sr] = audioread( 'Track5_800Hz_Pl1.wav');
tic;
new_data = pitch_shifter( data,sr, ratio );
fprintf('Data processing time is: %fs\n ',toc);
%�����������Ƶ�������ʱ�Ϊ8000Hz
new_data = resample(new_data,8000,sr);

total_time = length(new_data)/8000;
fprintf('Output audio time is: %fs\n ',total_time);

audiowrite('output.wav',new_data,8000);

%�任ǰ�����
soundsc(new_data,8000);
subplot(3,1,1)
specgram(data,1024,8000,1024,512);
title('ԭʼ��ƵƵ��')
subplot(3,1,2)
plot(2 - ratio)
title('Ƶ�ʱ任����')
axis([0 length(2 - ratio) min(2 - ratio) max(2 - ratio)])
subplot(3,1,3)
specgram(new_data,1024,8000,1024,512);
title('�任���Ƶ��')
saveas(gcf,'����Ա�.png')
